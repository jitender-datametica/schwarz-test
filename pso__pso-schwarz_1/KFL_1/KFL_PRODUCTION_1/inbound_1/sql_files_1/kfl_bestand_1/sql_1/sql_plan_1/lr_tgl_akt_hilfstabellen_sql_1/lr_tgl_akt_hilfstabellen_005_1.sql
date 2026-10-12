--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.mk_wupartcal_1
WHERE dat = CURRENT_DATE;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
INSERT INTO DBP_ETL.mk_wupartcal_1 (
  mandant_id
  , wup_id
  , nb_id
  , art_id
  , dat
  , wtag_id
  , aktion_fg
  , saison_fg

  )
    
   
SELECT    t05.mandant_id
            , t05.wup_id
            , t05.nb_id
            , t05.art_id
            , t05.dat
            , t05.wtag_id
            , t05.this_aktion_fg AS aktion_fg
            , t05.saison_fg
  FROM      ( SELECT    t01.mandant_id
                        , t01.wup_id
                        , t01.nb_id
                        , t02.art_id
                        , t01.dat
                        , t01.wtag_id
                        --, t02.reg_fg
                        , t02.aktion_fg
                        -- Überprüfung ob Promotion (1), regulärer (0) 
                        , CASE WHEN t03.art_id IS NOT NULL 
                                      THEN 1 
                           ELSE 0 END  this_aktion_fg  
                        -- Setzen des Saison Flags (Winter: NOV-MRZ, Sommer: APR-OKT)
                        , CASE
                            WHEN EXTRACT(MONTH FROM t01.dat) BETWEEN 4 AND 10 THEN 'S'
                            ELSE 'W' END AS saison_fg
                        , t01.offen
              FROM      DBP_ETL.mk_wupcal_1 AS t01
              INNER JOIN
                        DBP_DATA.mk_art_wup_auswahl_1 AS t02
              ON        t01.mandant_id = t02.mandant_id
              AND       t01.wup_id = t02.wup_id
            
              AND       t01.dat BETWEEN  CURRENT_DATE -7 AND CURRENT_DATE
              AND       t02.aktiv_fg = 1
              AND       CURRENT_DATE BETWEEN t02.dat_von AND t02.dat_bis
              LEFT OUTER JOIN
                        DBP_ETL.mk_promocal_1 AS t03
              ON        t01.mandant_id = t03.mandant_id
              AND       t01.wup_id = t03.wup_id
              AND       t01.nb_id = t03.nb_id
              AND       t02.art_id = t03.art_id
              AND       t01.dat = t03.dat
              INNER JOIN 
                        DBP_DATA.art_wup_zu_per_1 AS t04
              ON        t01.mandant_id = t04.mandant_id
              AND       t01.wup_id = t04.wup_id
              AND       t01.nb_id = t04.nb_id
              AND       t02.art_id = t04.art_id
              AND       t01.dat BETWEEN  t04.dat_von AND t04.dat_bis) AS t05
  WHERE     t05.dat = CURRENT_DATE
  AND       t05.offen = 1
  AND       (       (t05.this_aktion_fg = 1 AND t05.aktion_fg = 1)
              OR    (t05.this_aktion_fg IN (0) AND t05.aktion_fg = 0))
GROUP BY 1,2,3,4,5,6,7,8 ;

