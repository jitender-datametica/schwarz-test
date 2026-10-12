--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.art_bestand_vw_sum_artbew_tmp_2 (
    mandant_id, wup_id, nb_id, art_id, gp_id, wrg_id,
    relevant_fg, bezugsweg_id, dat, menge_abgang_bme, herkunft
)
(
    SELECT
        M.mandant_id,
        M.wup_id,
        M.nb_id,
        M.art_id,
        A.gp_id,
        A.wrg_2 AS wrg_id,
        M.relevant_fg,
        M.bezugsweg_id,
        D.dat,
        A.menge AS menge_abgang_bme,
        'm' AS herkunft
    FROM dbp_data.marktbestand_erp_2 AS M
    INNER JOIN dbp_data.artbew_2 AS A ON TRUE
    INNER JOIN dbp_etl.art_bestand_vw_sum_artbew_dat_2 AS D ON TRUE
    WHERE
        M.mandant_id = A.mandant_id
        AND M.mandant_id = D.mandant_id
        AND D.dat = M.dat
        AND A.dat = D.dat
        AND M.wup_id = A.wup_id
        AND M.nb_id = A.nb_id
        AND M.art_id = A.art_id
        AND A.bezugsweg_id IN (1, 4)
        AND A.mandant_id = 1
        AND M.bezugsweg_id IN (1, 4)
        AND A.bezugsweg_id = M.bezugsweg_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.art_bestand_vw_sum_artbew_tmp_2 (
    mandant_id, wup_id, nb_id, art_id, gp_id, wrg_id,
    relevant_fg, bezugsweg_id, dat, menge_abgang_bme, herkunft
)
(
    SELECT
        a.mandant_id,
        a.wup_id,
        a.nb_id,
        a.art_id,
        a.gp_id,
        a.wrg_id,
        a.relevant_fg,
        a.bezugsweg_id,
        a.dat,
        a.menge_abgang_bme,
        'a' AS herkunft
    FROM (
        SELECT
            A.mandant_id,
            A.wup_id,
            A.nb_id,
            A.art_id,
            A.gp_id,
            A.wrg_2 AS wrg_id,
            -1 AS relevant_fg,
            A.bezugsweg_id,
            D.dat,
            A.menge AS menge_abgang_bme
        FROM dbp_data.artbew_2 AS A
        INNER JOIN dbp_etl.art_bestand_vw_sum_artbew_dat_2 AS D ON TRUE
        WHERE
            A.mandant_id = D.mandant_id
            AND A.dat = D.dat
            AND A.bezugsweg_id IN (1, 4)
            AND A.mandant_id = 1
    ) AS a
    LEFT JOIN dbp_etl.art_bestand_vw_sum_artbew_tmp_2 AS M
        ON
            a.mandant_id = M.mandant_id AND a.dat = M.dat
            AND a.wup_id = M.wup_id AND a.nb_id = M.nb_id AND a.art_id = M.art_id AND a.bezugsweg_id = M.bezugsweg_id
    WHERE M.mandant_id IS NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.art_bestand_vw_sum_artbew_tmp2_2 (
    mandant_id, wup_id, nb_id, art_id, gp_id, wrg_id,
    vw_id, relevant_fg, bezugsweg_id, dat, menge_abgang_bme, herkunft
)
(
    SELECT
        T.mandant_id,
        CASE
            WHEN T.bezugsweg_id = 1
                THEN -1
            WHEN T.bezugsweg_id = 4
                THEN CASE
                    WHEN WGFZ.wg_id IS NOT NULL
                        THEN 6907 /* Nonfood */
                    ELSE 6906 /* Food */
                END
            ELSE T.wup_id
        END AS wup_id_neu,
        CASE
            WHEN
                CASE
                    WHEN T.bezugsweg_id = 1
                        THEN -1
                    WHEN T.bezugsweg_id = 4
                        THEN CASE
                            WHEN WGFZ.wg_id IS NOT NULL
                                THEN 6907 /* Nonfood */
                            ELSE 6906
                        END
                    ELSE T.wup_id
                END = -1
                THEN -1
            ELSE -111
        END AS nb_id_neu,
        T.art_id,
        T.gp_id,
        T.wrg_id,
        W.vw_id,
        T.relevant_fg,
        T.bezugsweg_id,
        T.dat,
        SUM(T.menge_abgang_bme),
        T.herkunft
    FROM dbp_etl.art_bestand_vw_sum_artbew_tmp_2 AS T
    INNER JOIN dbp_data.wup_2 AS W ON T.mandant_id = W.mandant_id AND T.wup_id = W.wup_id AND T.nb_id = W.nb_id

    INNER JOIN dbp_data.art_wg_zu_per_2 AS AWG
        ON
            T.mandant_id = AWG.mandant_id AND T.art_id = AWG.art_id AND
            T.dat BETWEEN AWG.dat_von AND AWG.dat_bis AND AWG.arthiertyp_id = 2
    LEFT JOIN dbp_data.wg_filter_zu_2 AS WGFZ
        ON
            AWG.mandant_id = WGFZ.mandant_id AND AWG.arthiertyp_id =
            WGFZ.arthiertyp_id AND AWG.wg_id = WGFZ.wg_id AND WGFZ.wg_filter_id = 20
    WHERE T.mandant_id = 1
    GROUP BY
        T.mandant_id,
        wup_id_neu,
        nb_id_neu,
        T.art_id,
        T.gp_id,
        W.vw_id,
        T.relevant_fg,
        T.bezugsweg_id,
        T.dat,
        T.wrg_id,
        T.herkunft
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO dbp_etl.art_bestand_vw_sum_tmp_2 
--(
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,dat
--  ,gp_id
--  ,relevant_fg
--  ,wrg_id
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_gesamt_bme
--  ,menge_lgbest_erp_qual_bme
--  ,betrag_vk_netto_frei_bme
--  ,betrag_vk_netto_gesamt_bme
--  ,betrag_vk_netto_qual_bme
--  ,menge_abgang_bme
--  ,herkunft 
--) 
--SELECT 
--   d.mandant_id
--  ,d.vw_id
--  ,d.bezugsweg_id
--  ,d.lagerbestand_fg
--  ,d.nb_id
--  ,d.art_id
--  ,d.wup_id
--  ,d.dat
--  ,d.gp_id
--  ,d.relevant_fg
--  ,d.wrg_id
--  ,d.menge_lgbest_erp_frei_bme
--  ,d.menge_lgbest_erp_gesamt_bme
--  ,d.menge_lgbest_erp_qual_bme
--  ,d.betrag_vk_netto_frei_bme
--  ,d.betrag_vk_netto_gesamt_bme
--  ,d.betrag_vk_netto_qual_bme
--  ,t.menge_abgang_bme 
--  ,t.herkunft
--FROM dbp_data.art_bestand_vw_sum_2 d
--
--INNER JOIN dbp_etl.art_bestand_vw_sum_artbew_tmp2_2 t
--ON d.mandant_id = t.mandant_id 
--  AND d.wup_id = t.wup_id 
--  AND d.nb_id = t.nb_id 
--  AND d.art_id = t.art_id 
--  AND d.gp_id = t.gp_id 
--  AND d.vw_id = t.vw_id 
--  AND d.bezugsweg_id = t.bezugsweg_id 
--  AND d.dat = t.dat
--  AND d.wrg_id = t.wrg_id 
--  AND d.relevant_fg = t.relevant_fg
--  
--WHERE d.mandant_id = 1
--  AND d.lagerbestand_fg = 0
--  AND t.herkunft = 'm' /*Herkunft marktbestand_erp_per*/
--;
--
--Comment from validation checker
--error line 21 at position 3
--  , ^^^> herkunft 
--invalid identifier 'HERKUNFT'
--translated statement


INSERT INTO dbp_etl.art_bestand_vw_sum_tmp_2 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
    art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme, betrag_vk_netto_qual_bme,
    menge_abgang_bme, herkunft
)
(
    SELECT
        D.mandant_id,
        D.vw_id,
        D.bezugsweg_id,
        D.lagerbestand_fg,
        D.nb_id,
        D.art_id,
        D.wup_id,
        D.dat,
        D.gp_id,
        D.relevant_fg,
        D.wrg_id,
        D.menge_lgbest_erp_frei_bme,
        D.menge_lgbest_erp_gesamt_bme,
        D.menge_lgbest_erp_qual_bme,
        D.betrag_vk_netto_frei_bme,
        D.betrag_vk_netto_gesamt_bme,
        D.betrag_vk_netto_qual_bme,
        T.menge_abgang_bme,
        T.herkunft
    FROM dbp_data.art_bestand_vw_sum_2 AS D
    INNER JOIN dbp_etl.art_bestand_vw_sum_artbew_tmp2_2 AS T
        ON
            D.mandant_id = T.mandant_id AND D.wup_id = T.wup_id AND D.nb_id = T.nb_id AND D.art_id = T.art_id AND D.gp_id = T.gp_id AND D.vw_id = T.vw_id AND D.bezugsweg_id
            = T.bezugsweg_id AND D.dat = T.dat AND D.wrg_id = T.wrg_id AND D.relevant_fg = T.relevant_fg
    WHERE
        D.mandant_id = 1
        AND D.lagerbestand_fg = 0
        AND T.herkunft = 'm' /* Herkunft marktbestand_erp_per */
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM dbp_etl.art_bestand_vw_sum_artbew_tmp2_2 v
--WHERE dbp_etl.art_bestand_vw_sum_tmp.mandant_id   = v.mandant_id 
--  AND dbp_etl.art_bestand_vw_sum_tmp.vw_id        = v.vw_id
--  AND dbp_etl.art_bestand_vw_sum_tmp.bezugsweg_id = v.bezugsweg_id
--  AND dbp_etl.art_bestand_vw_sum_tmp.nb_id        = v.nb_id
--  AND dbp_etl.art_bestand_vw_sum_tmp.art_id       = v.art_id
--  AND dbp_etl.art_bestand_vw_sum_tmp.wup_id       = v.wup_id
--  AND dbp_etl.art_bestand_vw_sum_tmp.gp_id        = v.gp_id
--  AND dbp_etl.art_bestand_vw_sum_tmp.relevant_fg  = v.relevant_fg
--  AND dbp_etl.art_bestand_vw_sum_tmp.wrg_id       = v.wrg_id
--  AND dbp_etl.art_bestand_vw_sum_tmp.dat          = v.dat
--  AND v.mandant_id = 1
--  AND v.herkunft   = 'm'
--;
--
--Comment from validation checker
--error line 2 at position 6
--WHERE  ^^^> dbp_etl.art_bestand_vw_sum_tmp.mandant_id   = v.mandant_id 
--invalid identifier 'dbp_etl.ART_BESTAND_VW_SUM_TMP.MANDANT_ID'
--translated statement


DELETE FROM dbp_etl.art_bestand_vw_sum_artbew_tmp2_2 AS V
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.art_bestand_vw_sum_tmp_2
    WHERE
        mandant_id = V.mandant_id
        AND vw_id = V.vw_id
        AND bezugsweg_id = V.bezugsweg_id
        AND nb_id = V.nb_id
        AND art_id = V.art_id
        AND wup_id = V.wup_id
        AND gp_id = V.gp_id
        AND relevant_fg = V.relevant_fg
        AND wrg_id = V.wrg_id
        AND dat = V.dat
        AND V.mandant_id = 1
        AND V.herkunft = 'm'
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO dbp_etl.art_bestand_vw_sum_tmp_2 
--(
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,dat
--  ,gp_id
--  ,relevant_fg
--  ,wrg_id
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_gesamt_bme
--  ,menge_lgbest_erp_qual_bme
--  ,betrag_vk_netto_frei_bme
--  ,betrag_vk_netto_gesamt_bme
--  ,betrag_vk_netto_qual_bme
--  ,menge_abgang_bme
--  ,herkunft
--) 
--SELECT 
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,dat
--  ,gp_id
--  ,relevant_fg
--  ,wrg_id
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_gesamt_bme
--  ,menge_lgbest_erp_qual_bme
--  ,betrag_vk_netto_frei_bme
--  ,betrag_vk_netto_gesamt_bme
--  ,betrag_vk_netto_qual_bme
--  ,menge_abgang_bme 
--  ,herkunft
--FROM 
--(
--  SELECT 
--     d.mandant_id
--    ,d.vw_id
--    ,d.bezugsweg_id
--    ,d.lagerbestand_fg
--    ,d.nb_id
--    ,d.art_id
--    ,d.wup_id
--    ,t.dat
--    ,d.dat AS csum_dat 
--    ,d.gp_id
--    ,d.relevant_fg
--    ,d.wrg_id
--    ,0 AS menge_lgbest_erp_frei_bme
--    ,0 AS menge_lgbest_erp_gesamt_bme
--    ,0 AS menge_lgbest_erp_qual_bme
--    ,0 AS betrag_vk_netto_frei_bme
--    ,0 AS betrag_vk_netto_gesamt_bme
--    ,0 AS betrag_vk_netto_qual_bme 
--    ,t.menge_abgang_bme 
--    ,t.herkunft
--  FROM dbp_etl.art_bestand_vw_sum_artbew_tmp2_2 t
--  
--  INNER JOIN dbp_data.art_bestand_vw_sum_2 d     
--  ON d.mandant_id = t.mandant_id 
--    AND d.wup_id = t.wup_id 
--    AND d.nb_id = t.nb_id 
--    AND d.art_id = t.art_id 
--    AND d.gp_id = t.gp_id 
--    AND d.vw_id = t.vw_id 
--    AND d.bezugsweg_id = t.bezugsweg_id 
--    AND d.relevant_fg = t.relevant_fg 
--    AND d.dat <= t.dat                           
--    AND d.wrg_id = t.wrg_id 
--    AND d.mandant_id = 1
--    AND d.lagerbestand_fg = 0
--   
--  WHERE t.mandant_id = 1
--    AND t.herkunft = 'm' /*Herkunft marktbestand_erp_per*/                     
--)  a
--GROUP BY 
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,gp_id
--  ,relevant_fg
--  ,wrg_id
--  ,dat
--QUALIFY CSUM (1, csum_dat DESC) = 1        
--;
--
--Comment from validation checker
--error line 97 at position 26 unexpected 'DESC'.
--QUALIFY CSUM (1, csum_dat  ^^^> DESC) = 1        
--translated statement


INSERT INTO dbp_etl.art_bestand_vw_sum_tmp_2 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
    art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme, betrag_vk_netto_qual_bme,
    menge_abgang_bme, herkunft
)
(
    SELECT
        t2.mandant_id,
        t2.vw_id,
        t2.bezugsweg_id,
        t2.lagerbestand_fg,
        t2.nb_id,
        t2.art_id,
        t2.wup_id,
        t2.dat,
        t2.gp_id,
        t2.relevant_fg,
        t2.wrg_id,
        0 AS menge_lgbest_erp_frei_bme,
        0 AS menge_lgbest_erp_gesamt_bme,
        0 AS menge_lgbest_erp_qual_bme,
        0 AS betrag_vk_netto_frei_bme,
        0 AS betrag_vk_netto_gesamt_bme,
        0 AS betrag_vk_netto_qual_bme,
        t2.menge_abgang_bme,
        t2.herkunft
    FROM (
        SELECT
            D.mandant_id,
            D.vw_id,
            D.bezugsweg_id,
            D.lagerbestand_fg,
            D.nb_id,
            D.art_id,
            D.wup_id,
            T.dat,
            D.gp_id,
            D.relevant_fg,
            D.wrg_id,
            0 AS menge_lgbest_erp_frei_bme,
            0 AS menge_lgbest_erp_gesamt_bme,
            0 AS menge_lgbest_erp_qual_bme,
            0 AS betrag_vk_netto_frei_bme,
            0 AS betrag_vk_netto_gesamt_bme,
            0 AS betrag_vk_netto_qual_bme,
            T.menge_abgang_bme,
            T.herkunft,
            D.dat AS csum_dat
        FROM dbp_etl.art_bestand_vw_sum_artbew_tmp2_2 AS T
        INNER JOIN dbp_data.art_bestand_vw_sum_2 AS D
            ON
                T.mandant_id = D.mandant_id AND T.wup_id = D.wup_id
                AND T.nb_id = D.nb_id AND T.art_id = D.art_id AND T.gp_id = D.gp_id AND T.vw_id = D.vw_id AND T.bezugsweg_id
                = D.bezugsweg_id AND T.relevant_fg = D.relevant_fg AND T.dat >= D.dat AND T.wrg_id = D.wrg_id AND D.mandant_id
                = 1 AND D.lagerbestand_fg = 0
        WHERE
            T.mandant_id = 1
            AND T.herkunft = 'm' /* Herkunft marktbestand_erp_per */
        QUALIFY (ROW_NUMBER() OVER (
            PARTITION BY
                D.mandant_id, D.vw_id, D.bezugsweg_id, D.lagerbestand_fg, D.nb_id, D.art_id,
                D.wup_id, D.gp_id, D.relevant_fg, D.wrg_id, T.dat
            ORDER BY csum_dat IS NULL DESC, csum_dat DESC
        )) = 1
    ) AS t2
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : CSUM is Teradata analytical function that is not supported by Snowflake. It needs to be replaced with: SUM(expr1) OVER (PARTITION BY expr2 ORDER BY expr3 ROWS UNBOUNDED PRECEDING). QUALIFY CSUM(1, expr) is probably equivalent of ROW_NUMBER.
--original statement
--INSERT INTO dbp_etl.art_bestand_vw_sum_tmp_2 
--(
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,dat
--  ,gp_id
--  ,relevant_fg
--  ,wrg_id
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_gesamt_bme
--  ,menge_lgbest_erp_qual_bme
--  ,betrag_vk_netto_frei_bme
--  ,betrag_vk_netto_gesamt_bme
--  ,betrag_vk_netto_qual_bme 
--  ,menge_abgang_bme
--  ,herkunft
--) 
--SELECT 
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,dat
--  ,gp_id
--  ,relevant_fg
--  ,wrg_id
--  ,menge_lgbest_erp_frei_bme
--  ,menge_lgbest_erp_gesamt_bme
--  ,menge_lgbest_erp_qual_bme
--  ,betrag_vk_netto_frei_bme
--  ,betrag_vk_netto_gesamt_bme
--  ,betrag_vk_netto_qual_bme
--  ,menge_abgang_bme 
--  ,herkunft
--FROM 
--(
--  SELECT 
--     d.mandant_id
--    ,d.vw_id
--    ,d.bezugsweg_id
--    ,d.lagerbestand_fg
--    ,d.nb_id
--    ,d.art_id
--    ,d.wup_id
--    ,t.dat
--    ,d.dat AS csum_dat
--    ,d.gp_id
--    ,d.relevant_fg
--    ,d.wrg_id
--    ,0 AS menge_lgbest_erp_frei_bme
--    ,0 AS menge_lgbest_erp_gesamt_bme
--    ,0 AS menge_lgbest_erp_qual_bme 
--    ,0 AS betrag_vk_netto_frei_bme
--    ,0 AS betrag_vk_netto_gesamt_bme
--    ,0 AS betrag_vk_netto_qual_bme 
--    ,t.menge_abgang_bme 
--    ,t.herkunft
--  FROM dbp_etl.art_bestand_vw_sum_artbew_tmp2_2 t
--  
--  INNER JOIN dbp_data.art_bestand_vw_sum_2 d     
--  ON d.mandant_id = t.mandant_id 
--    AND d.wup_id = t.wup_id 
--    AND d.nb_id = t.nb_id 
--    AND d.art_id = t.art_id 
--    AND d.gp_id = t.gp_id 
--    AND d.vw_id = t.vw_id 
--    AND d.bezugsweg_id = t.bezugsweg_id 
--    AND d.dat <= t.dat
--    AND d.wrg_id = t.wrg_id 
--    
--  WHERE d.mandant_id = 1
--    AND d.lagerbestand_fg = 0 
--    AND t.herkunft = 'a' /*Herkunft artbew_2*/
--)  a
--GROUP BY 
--   mandant_id
--  ,vw_id
--  ,bezugsweg_id
--  ,lagerbestand_fg
--  ,nb_id
--  ,art_id
--  ,wup_id
--  ,gp_id
--  ,wrg_id
--  ,dat
--QUALIFY CSUM (1, csum_dat DESC, relevant_fg ASC) = 1
--;
--
--Comment from validation checker
--error line 94 at position 26 unexpected 'DESC'.
--QUALIFY CSUM (1, csum_dat  ^^^> DESC, relevant_fg ASC) = 1
--syntax error line 94 at position 44 unexpected 'ASC'.
--QUALIFY CSUM (1, csum_dat DESC, relevant_fg  ^^^> ASC) = 1
--translated statement


INSERT INTO dbp_etl.art_bestand_vw_sum_tmp_2 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
    art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme, betrag_vk_netto_qual_bme,
    menge_abgang_bme, herkunft
)
(SELECT
    t2.mandant_id,
    t2.vw_id,
    t2.bezugsweg_id,
    t2.lagerbestand_fg,
    t2.nb_id,
    t2.art_id,
    t2.wup_id,
    t2.dat,
    t2.gp_id,
    t2.relevant_fg,
    t2.wrg_id,
    0 AS menge_lgbest_erp_frei_bme,
    0 AS menge_lgbest_erp_gesamt_bme,
    0 AS menge_lgbest_erp_qual_bme,
    0 AS betrag_vk_netto_frei_bme,
    0 AS betrag_vk_netto_gesamt_bme,
    0 AS betrag_vk_netto_qual_bme,
    t2.menge_abgang_bme,
    t2.herkunft
FROM (
    SELECT
        D.mandant_id,
        D.vw_id,
        D.bezugsweg_id,
        D.lagerbestand_fg,
        D.nb_id,
        D.art_id,
        D.wup_id,
        T.dat,
        D.gp_id,
        D.relevant_fg,
        D.wrg_id,
        0 AS menge_lgbest_erp_frei_bme,
        0 AS menge_lgbest_erp_gesamt_bme,
        0 AS menge_lgbest_erp_qual_bme,
        0 AS betrag_vk_netto_frei_bme,
        0 AS betrag_vk_netto_gesamt_bme,
        0 AS betrag_vk_netto_qual_bme,
        T.menge_abgang_bme,
        T.herkunft,
        D.dat AS csum_dat
    FROM dbp_etl.art_bestand_vw_sum_artbew_tmp2_2 AS T
    INNER JOIN dbp_data.art_bestand_vw_sum_2 AS D
        ON
            T.mandant_id = D.mandant_id AND T.wup_id = D.wup_id
            AND T.nb_id = D.nb_id AND T.art_id = D.art_id AND T.gp_id = D.gp_id AND T.vw_id = D.vw_id AND T.bezugsweg_id
            = D.bezugsweg_id AND T.dat >= D.dat AND T.wrg_id = D.wrg_id
    WHERE
        D.mandant_id = 1
        AND D.lagerbestand_fg = 0
        AND T.herkunft = 'a' /* Herkunft artbew_2 */
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            D.mandant_id, D.vw_id, D.bezugsweg_id, D.lagerbestand_fg, D.nb_id, D.art_id,
            D.wup_id, D.gp_id, D.wrg_id, T.dat
        ORDER BY csum_dat IS NULL DESC, csum_dat DESC
    )) = 1
) AS t2);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.art_bestand_vw_sum_tmp2_2 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
    art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme, betrag_vk_netto_qual_bme,
    menge_abgang_bme
)
(
    SELECT
        mandant_id,
        vw_id,
        bezugsweg_id,
        lagerbestand_fg,
        nb_id,
        art_id,
        wup_id,
        dat,
        gp_id,
        relevant_fg,
        wrg_id,
        SUM(menge_lgbest_erp_frei_bme),
        SUM(menge_lgbest_erp_gesamt_bme),
        SUM(menge_lgbest_erp_qual_bme),
        SUM(betrag_vk_netto_frei_bme),
        SUM(betrag_vk_netto_gesamt_bme),
        SUM(betrag_vk_netto_qual_bme),
        SUM(menge_abgang_bme)
    FROM dbp_etl.art_bestand_vw_sum_tmp_2
    GROUP BY
        mandant_id,
        vw_id,
        bezugsweg_id,
        lagerbestand_fg,
        nb_id,
        art_id,
        wup_id,
        dat,
        gp_id,
        relevant_fg,
        wrg_id
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM dbp_data.art_bestand_vw_sum_2
--WHERE dbp_data.art_bestand_vw_sum.mandant_id = dbp_etl.art_bestand_vw_sum_tmp2.mandant_id 
--  AND dbp_data.art_bestand_vw_sum.vw_id = dbp_etl.art_bestand_vw_sum_tmp2.vw_id
--  AND dbp_data.art_bestand_vw_sum.bezugsweg_id = dbp_etl.art_bestand_vw_sum_tmp2.bezugsweg_id 
--  AND dbp_data.art_bestand_vw_sum.lagerbestand_fg = dbp_etl.art_bestand_vw_sum_tmp2.lagerbestand_fg
--  AND dbp_data.art_bestand_vw_sum.nb_id = dbp_etl.art_bestand_vw_sum_tmp2.nb_id
--  AND dbp_data.art_bestand_vw_sum.art_id = dbp_etl.art_bestand_vw_sum_tmp2.art_id 
--  AND dbp_data.art_bestand_vw_sum.wup_id = dbp_etl.art_bestand_vw_sum_tmp2.wup_id 
--  AND dbp_data.art_bestand_vw_sum.dat = dbp_etl.art_bestand_vw_sum_tmp2.dat
--  AND dbp_data.art_bestand_vw_sum.gp_id = dbp_etl.art_bestand_vw_sum_tmp2.gp_id 
--  AND dbp_data.art_bestand_vw_sum.relevant_fg = dbp_etl.art_bestand_vw_sum_tmp2.relevant_fg 
--  AND dbp_data.art_bestand_vw_sum.wrg_id = dbp_etl.art_bestand_vw_sum_tmp2.wrg_id
--;
--
--Comment from validation checker
--error line 2 at position 47
--WHERE dbp_data.art_bestand_vw_sum.mandant_id =  ^^^> dbp_etl.art_bestand_vw_sum_tmp2.mandant_id 
--invalid identifier 'dbp_etl.ART_BESTAND_VW_SUM_TMP2.MANDANT_ID'
--translated statement


DELETE FROM dbp_data.art_bestand_vw_sum_2
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.art_bestand_vw_sum_tmp2_2
    WHERE
        art_bestand_vw_sum.mandant_id = mandant_id
        AND art_bestand_vw_sum.vw_id = vw_id
        AND art_bestand_vw_sum.bezugsweg_id = bezugsweg_id
        AND art_bestand_vw_sum.lagerbestand_fg = lagerbestand_fg
        AND art_bestand_vw_sum.nb_id = nb_id
        AND art_bestand_vw_sum.art_id = art_id
        AND art_bestand_vw_sum.wup_id = wup_id
        AND art_bestand_vw_sum.dat = dat
        AND art_bestand_vw_sum.gp_id = gp_id
        AND art_bestand_vw_sum.relevant_fg = relevant_fg
        AND art_bestand_vw_sum.wrg_id = wrg_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.art_bestand_vw_sum_2 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id,
    wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_netto_gesamt_bme,
    menge_abgang_bme
)
(SELECT
    mandant_id,
    vw_id,
    bezugsweg_id,
    lagerbestand_fg,
    nb_id,
    art_id,
    wup_id,
    dat,
    gp_id,
    relevant_fg,
    wrg_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme,
    betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme,
    betrag_vk_netto_gesamt_bme,
    menge_abgang_bme
FROM dbp_etl.art_bestand_vw_sum_tmp2_2);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_artbew_tmp_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_artbew_tmp2_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_tmp_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_tmp2_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.art_bestand_vw_sum_artbew_dat_2;
