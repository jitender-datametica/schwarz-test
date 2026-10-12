--[OK] statement is translated correctly (syntax and type checks are fine)
MERGE INTO DBP_DATA.lagerbew_det_wwc_woche a
USING (SELECT a1.mandant_id
            , a1.wup_id
            , a1.nb_id
            , a1.lager_bewart_id
            , a1.art_id
            , a1.gp_id
            , a1.wrg_id
            , b1.kjwo_kl
            , SUM(a1.betrag_lagerbew) AS betrag_lagerbew
            , SUM(a1.betrag_verkauf) AS betrag_verkauf
            , SUM(a1.menge_lagerbew_bme) AS menge_lagerbew_bme
            , SUM(a1.betrag_vk_netto) AS betrag_vk_netto
            , SUM(a1.betrag_verkauf_ist) AS betrag_verkauf_ist
            , SUM(a1.betrag_verkauf_ist_netto) AS betrag_verkauf_ist_netto
            , SUM(a1.betrag_exbwr) AS betrag_exbwr
            , a1.exvkw_gleich_vkwrt_fg
       FROM (-- Der erste UNION-Zweig betreibt den Austausch bereits in der LAGERBEW_DET befindlicher
             -- Belege, indem er die gelieferten Delta-Saetze der MSEG gegenueberstellt und bei Tref-
             -- fern Stornos generiert und diese dann mit dem neuen Delta (s.u.) ausspult.
             SELECT y.mandant_id
                  , y.wup_id
                  , y.nb_id
                  , y.lager_bewart_id
                  , y.art_id
                  , y.gp_id
                  , y.wrg_id
                  , y.dat_buch
                  , (-1)*CAST((y.betrag_lagerbew ) AS DECIMAL(18,2)) AS betrag_lagerbew
                  , (-1)*y.betrag_verkauf AS betrag_verkauf
                  , (-1)*y.menge_lagerbew_bme AS menge_lagerbew_bme
                  , (-1)*y.betrag_vk_netto AS betrag_vk_netto
                  , (-1)*y.betrag_verkauf_ist AS betrag_verkauf_ist
                  , (-1)*y.betrag_verkauf_ist_netto AS betrag_verkauf_ist_netto
                  , (-1)*z.betrag_exbwr AS betrag_exbwr
                  , CASE
                      WHEN y.betrag_verkauf_ist = y.betrag_verkauf 
                      THEN 1
                      ELSE 0
                    END AS exvkw_gleich_vkwrt_fg
             FROM DBP_DATA.lagerbew_det_delta x
             JOIN DBP_DATA.lagerbew_det y
               ON x.mandant_id            = y.mandant_id            AND
                  x.lagerbew_beleg_id     = y.lagerbew_beleg_id     AND
                  x.lagerbew_beleg_pos_id = y.lagerbew_beleg_pos_id AND
                  x.dat_buch              = y.dat_buch
             JOIN DBP_DATA.lagerbew_det_wwc z
               ON x.mandant_id            = z.mandant_id            AND
                  x.lagerbew_beleg_id     = z.lagerbew_beleg_id     AND
                  x.lagerbew_beleg_pos_id = z.lagerbew_beleg_pos_id AND
                  x.dat_buch              = z.dat_buch
                  
             UNION ALL
             
             -- Der zweite UNION-Zweig zieht alle Saetze aus dem Deltatopf 1:1 heran.
             SELECT w.mandant_id
                  , w.wup_id
                  , w.nb_id
                  , w.lager_bewart_id
                  , w.art_id
                  , w.gp_id
                  , w.wrg_id
                  , w.dat_buch
                  , CAST((w.betrag_lagerbew ) AS DECIMAL(18,2)) AS betrag_lagerbew
                  , w.betrag_verkauf
                  , w.menge_lagerbew_bme
                  , w.betrag_vk_netto
                  , w.betrag_verkauf_ist
                  , w.betrag_verkauf_ist_netto
                  , w.betrag_exbwr
                  , CASE
                      WHEN w.betrag_verkauf_ist = w.betrag_verkauf 
                      THEN 1
                      ELSE 0
                    END AS exvkw_gleich_vkwrt_fg
             FROM DBP_DATA.lagerbew_det_delta w) a1
       JOIN DBP_DATA.tag b1
         ON a1.dat_buch = b1.dat
       GROUP BY 1,2,3,4,5,6,7,8,16) b
        
  ON a.mandant_id            = b.mandant_id            AND
     a.art_id                = b.art_id                AND
     a.wup_id                = b.wup_id                AND
     a.nb_id                 = b.nb_id                 AND
     a.lager_bewart_id       = b.lager_bewart_id       AND
     a.gp_id                 = b.gp_id                 AND
     a.kjwo_kl               = b.kjwo_kl               AND
     a.wrg_id                = b.wrg_id                AND
     a.exvkw_gleich_vkwrt_fg = b.exvkw_gleich_vkwrt_fg
     
WHEN MATCHED THEN UPDATE SET betrag_lagerbew          = a.betrag_lagerbew + b.betrag_lagerbew,
                             betrag_verkauf           = a.betrag_verkauf + b.betrag_verkauf,
                             menge_lagerbew_bme       = a.menge_lagerbew_bme + b.menge_lagerbew_bme,
                             betrag_vk_netto          = a.betrag_vk_netto + b.betrag_vk_netto,
                             betrag_verkauf_ist       = a.betrag_verkauf_ist + b.betrag_verkauf_ist,
                             betrag_verkauf_ist_netto = a.betrag_verkauf_ist_netto + b.betrag_verkauf_ist_netto,
                             betrag_exbwr             = a.betrag_exbwr + b.betrag_exbwr

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              wup_id,
                              nb_id,
                              lager_bewart_id,
                              art_id,
                              gp_id,
                              wrg_id,
                              kjwo_kl,
                              betrag_lagerbew,
                              betrag_verkauf,
                              menge_lagerbew_bme,
                              betrag_vk_netto,
                              betrag_verkauf_ist,
                              betrag_verkauf_ist_netto,
                              betrag_exbwr,
                              exvkw_gleich_vkwrt_fg)
                      VALUES (b.mandant_id,
                              b.wup_id,
                              b.nb_id,
                              b.lager_bewart_id,
                              b.art_id,
                              b.gp_id,
                              b.wrg_id,
                              b.kjwo_kl,
                              b.betrag_lagerbew,
                              b.betrag_verkauf,
                              b.menge_lagerbew_bme,
                              b.betrag_vk_netto,
                              b.betrag_verkauf_ist,
                              b.betrag_verkauf_ist_netto,
                              b.betrag_exbwr,
                              b.exvkw_gleich_vkwrt_fg)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
MERGE INTO DBP_DATA.lagerbew_det_wwc_monat a
USING (SELECT a1.mandant_id
            , a1.wup_id
            , a1.nb_id
            , a1.lager_bewart_id
            , a1.art_id
            , a1.gp_id
            , a1.wrg_id
            , b1.kjmo
            , SUM(a1.betrag_lagerbew) AS betrag_lagerbew
            , SUM(a1.betrag_verkauf) AS betrag_verkauf
            , SUM(a1.menge_lagerbew_bme) AS menge_lagerbew_bme
            , SUM(a1.betrag_vk_netto) AS betrag_vk_netto
            , SUM(a1.betrag_verkauf_ist) AS betrag_verkauf_ist
            , SUM(a1.betrag_verkauf_ist_netto) AS betrag_verkauf_ist_netto
            , SUM(a1.betrag_exbwr) AS betrag_exbwr
            , a1.exvkw_gleich_vkwrt_fg
       FROM (-- Der erste UNION-Zweig betreibt den Austausch bereits in der LAGERBEW_DET befindlicher
             -- Belege, indem er die gelieferten Delta-Saetze der MSEG gegenueberstellt und bei Tref-
             -- fern Stornos generiert und diese dann mit dem neuen Delta (s.u.) ausspult.
             SELECT y.mandant_id
                  , y.wup_id
                  , y.nb_id
                  , y.lager_bewart_id
                  , y.art_id
                  , y.gp_id
                  , y.wrg_id
                  , y.dat_buch
                  , (-1)*CAST((y.betrag_lagerbew ) AS DECIMAL(18,2)) AS betrag_lagerbew
                  , (-1)*y.betrag_verkauf AS betrag_verkauf
                  , (-1)*y.menge_lagerbew_bme AS menge_lagerbew_bme
                  , (-1)*y.betrag_vk_netto AS betrag_vk_netto
                  , (-1)*y.betrag_verkauf_ist AS betrag_verkauf_ist
                  , (-1)*y.betrag_verkauf_ist_netto AS betrag_verkauf_ist_netto
                  , (-1)*z.betrag_exbwr AS betrag_exbwr
                  , CASE
                      WHEN y.betrag_verkauf_ist = y.betrag_verkauf 
                      THEN 1
                      ELSE 0
                    END AS exvkw_gleich_vkwrt_fg
             FROM DBP_DATA.lagerbew_det_delta x
             JOIN DBP_DATA.lagerbew_det y
               ON x.mandant_id            = y.mandant_id            AND
                  x.lagerbew_beleg_id     = y.lagerbew_beleg_id     AND
                  x.lagerbew_beleg_pos_id = y.lagerbew_beleg_pos_id AND
                  x.dat_buch              = y.dat_buch
             JOIN DBP_DATA.lagerbew_det_wwc z
               ON x.mandant_id            = z.mandant_id            AND
                  x.lagerbew_beleg_id     = z.lagerbew_beleg_id     AND
                  x.lagerbew_beleg_pos_id = z.lagerbew_beleg_pos_id AND
                  x.dat_buch              = z.dat_buch
                  
             UNION ALL
             
             -- Der zweite UNION-Zweig zieht alle Saetze aus dem Deltatopf 1:1 heran.
             SELECT w.mandant_id
                  , w.wup_id
                  , w.nb_id
                  , w.lager_bewart_id
                  , w.art_id
                  , w.gp_id
                  , w.wrg_id
                  , w.dat_buch
                  , CAST((w.betrag_lagerbew ) AS DECIMAL(18,2)) AS betrag_lagerbew
                  , w.betrag_verkauf
                  , w.menge_lagerbew_bme
                  , w.betrag_vk_netto
                  , w.betrag_verkauf_ist
                  , w.betrag_verkauf_ist_netto
                  , w.betrag_exbwr
                  , CASE
                      WHEN w.betrag_verkauf_ist = w.betrag_verkauf 
                      THEN 1
                      ELSE 0
                    END AS exvkw_gleich_vkwrt_fg
             FROM DBP_DATA.lagerbew_det_delta w) a1
       JOIN DBP_DATA.tag b1
         ON a1.dat_buch = b1.dat
       GROUP BY 1,2,3,4,5,6,7,8,16) b
        
  ON a.mandant_id            = b.mandant_id            AND
     a.art_id                = b.art_id                AND
     a.wup_id                = b.wup_id                AND
     a.nb_id                 = b.nb_id                 AND
     a.lager_bewart_id       = b.lager_bewart_id       AND
     a.gp_id                 = b.gp_id                 AND
     a.kjmo                  = b.kjmo                  AND
     a.wrg_id                = b.wrg_id                AND
     a.exvkw_gleich_vkwrt_fg = b.exvkw_gleich_vkwrt_fg
     
WHEN MATCHED THEN UPDATE SET betrag_lagerbew          = a.betrag_lagerbew + b.betrag_lagerbew,
                             betrag_verkauf           = a.betrag_verkauf + b.betrag_verkauf,
                             menge_lagerbew_bme       = a.menge_lagerbew_bme + b.menge_lagerbew_bme,
                             betrag_vk_netto          = a.betrag_vk_netto + b.betrag_vk_netto,
                             betrag_verkauf_ist       = a.betrag_verkauf_ist + b.betrag_verkauf_ist,
                             betrag_verkauf_ist_netto = a.betrag_verkauf_ist_netto + b.betrag_verkauf_ist_netto,
                             betrag_exbwr             = a.betrag_exbwr + b.betrag_exbwr

WHEN NOT MATCHED THEN INSERT (mandant_id,
                              wup_id,
                              nb_id,
                              lager_bewart_id,
                              art_id,
                              gp_id,
                              wrg_id,
                              kjmo,
                              betrag_lagerbew,
                              betrag_verkauf,
                              menge_lagerbew_bme,
                              betrag_vk_netto,
                              betrag_verkauf_ist,
                              betrag_verkauf_ist_netto,
                              betrag_exbwr,
                              exvkw_gleich_vkwrt_fg)
                      VALUES (b.mandant_id,
                              b.wup_id,
                              b.nb_id,
                              b.lager_bewart_id,
                              b.art_id,
                              b.gp_id,
                              b.wrg_id,
                              b.kjmo,
                              b.betrag_lagerbew,
                              b.betrag_verkauf,
                              b.menge_lagerbew_bme,
                              b.betrag_vk_netto,
                              b.betrag_verkauf_ist,
                              b.betrag_verkauf_ist_netto,
                              b.betrag_exbwr,
                              b.exvkw_gleich_vkwrt_fg)
;

