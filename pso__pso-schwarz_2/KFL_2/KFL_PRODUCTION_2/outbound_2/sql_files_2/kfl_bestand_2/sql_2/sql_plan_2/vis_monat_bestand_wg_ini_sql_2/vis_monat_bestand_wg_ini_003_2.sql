--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_monat_bestand_stamm_lkp_2 (
    art_id, mandant_id, gjmo, gj, kjmo, max_dat, wg_id,
    abt_id, arthiertyp_id, mwst, wrg_id
)
(
    SELECT
        A.art_id,
        A.mandant_id,
        M.gjmo,
        M.gj,
        M.kjmo,
        M.max_dat,
        AWZP.wg_id,
        WP.abt_id,
        AWZP.arthiertyp_id,
        COALESCE(MP.mwst, 0) AS mp_mwst,
        MWTZ.default_wrg
    FROM dbp_data.art_2 AS A
    INNER JOIN dbp_etl.vis_monat_bestand_relevanz_2 AS M ON A.mandant_id = M.mandant_id
    INNER JOIN dbp_data.art_wg_zu_per_2 AS AWZP
        ON
            A.mandant_id = AWZP.mandant_id AND A.art_id = AWZP.art_id
            AND AWZP.arthiertyp_id = 2 AND AWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.wg_per_2 AS WP
        ON
            AWZP.mandant_id = WP.mandant_id AND AWZP.wg_id = WP.wg_id AND AWZP.arthiertyp_id = WP.arthiertyp_id AND WP.dat_bis = PARSE_DATE('%F', '9999-12-31')
    LEFT JOIN dbp_data.mwst_per_2 AS MP
        ON
            A.mandant_id = MP.mandant_id AND A.mwst_id = MP.mwst_id AND M.max_dat
            BETWEEN MP.dat_von AND MP.dat_bis
    INNER JOIN dbp_data.mandant_2 AS MWTZ ON A.mandant_id = MWTZ.mandant_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- DE: '11','ZZ'---
-- KMO: nur 'S2'---
INSERT INTO dbp_etl.vis_monat_bestand_stamm_lkp2_2 (
    mandant_id,
    wup_id, nb_id, kjmo, art_id, relevant_fg
)
(
    SELECT
        T21.mandant_id,
        T21.wup_id,
        T21.nb_id,
        T22.kjmo,
        T21.art_id,
        1 AS relevanz_fg
    FROM dbp_data.art_wup_zu_per_2 AS T21
    INNER JOIN dbp_etl.vis_monat_bestand_relevanz_2 AS T22
        ON
            T21.mandant_id = T22.mandant_id AND T22.max_dat
            BETWEEN T21.dat_von AND T21.dat_bis
    INNER JOIN dbp_data.art_2 AS T23 ON T21.mandant_id = T23.mandant_id AND T21.art_id = T23.art_id
    INNER JOIN dbp_data.wup_2 AS T24
        ON
            T21.mandant_id = T24.mandant_id AND T21.wup_id = T24.wup_id AND T21.nb_id
            = T24.nb_id AND T22.max_dat BETWEEN T24.dat_von AND T24.dat_bis
    INNER JOIN dbp_data.art_wup_status_per_2 AS T25
        ON
            T21.mandant_id = T25.mandant_id AND T21.art_id = T25.art_id
            AND T21.wup_id = T25.wup_id AND T21.nb_id = T25.nb_id AND T22.max_dat BETWEEN T25.dat_von AND T25.dat_bis
    WHERE
        T21.nb_id = 0
        AND T21.listung_id = 1
        AND COALESCE(T21.kdis, 0) = 0
        AND T23.loesch_id <> 'L'
        AND (T23.display_id NOT IN (1, 2, 3) OR T23.display_id IS NULL)
        AND T23.wg_art_fg <> 1
        AND (T21.mandant_id <> 1 AND T25.dispomerkmal IN ('S2') OR T21.mandant_id = 1 AND T25.dispomerkmal IN ('11', 'ZZ'))
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_etl.vis_monat_bestand_stamm_lkp2_2
WHERE (kjmo, mandant_id, art_id, wup_id, nb_id) IN (
    SELECT (B.kjmo, A.mandant_id, A.art_id, A.wup_id, A.nb_id)
    FROM dbp_etl.vis_mard_relevant_2 AS A
    INNER JOIN dbp_etl.vis_monat_bestand_relevanz_2 AS B ON A.mandant_id = B.mandant_id AND A.dat = B.max_dat
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_monat_bestand_stamm_lkp2_2 (mandant_id, wup_id, nb_id, kjmo, art_id, relevant_fg)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        B.kjmo,
        A.art_id,
        A.relevant_fg
    FROM dbp_etl.vis_mard_relevant_2 AS A
    INNER JOIN dbp_etl.vis_monat_bestand_relevanz_2 AS B ON A.mandant_id = B.mandant_id AND A.dat = B.max_dat
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_monat_bestand_wg_tmp2_2 (
    mandant_id, wup_id, nb_id, art_id, gjmo, gj, kjmo, max_dat,
    wg_id, abt_id, arthiertyp_id, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme, mwst
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.art_id,
        T3.gjmo,
        T3.gj,
        T3.kjmo,
        T3.max_dat,
        T3.wg_id,
        T3.abt_id,
        T3.arthiertyp_id
        -- Falls der Artikel_2 nicht in art_wup_zu_per_2 gelistet ist, wird die Default wrg_id aus mandant_wrg_typ_zu_2 ermittelt

        -- (s. Befuellung vis_monat_bestand_stamm_lkp_2)

        -- Sobald wrg_id in den Bewegungsdaten mitgeliefert wird, sollte immer die wrg_id aus bestand_erp_monat_2 ermittelt werden.

        ,
        T3.wrg_id,
        T1.menge_lgbest_erp_frei_bme,
        T1.menge_lgbest_erp_qual_bme,
        T3.mwst
    FROM dbp_data.bestand_erp_monat_2 AS T1_2
    INNER JOIN dbp_etl.vis_monat_bestand_stamm_lkp_2 AS T3
        ON
            T1.mandant_id = T3.mandant_id AND T1.art_id =
            T3.art_id AND T3.gjmo BETWEEN T1.gjmo AND T1.gjmo_bis
    WHERE T1.nb_id = 0
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq

-- Falls der Artikel_2 nicht in art_wup_zu_per_2 gelistet istt, wird die Default wrg_id aus mandant_2 ermittelt

-- (s. Befuellung vis_monat_bestand_stamm_lkp_2)
-- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq

INSERT INTO dbp_etl.vis_monat_bestand_wg_tmp3_2 (
    mandant_id, wup_id, nb_id, gjmo, gj, kjmo, wg_id, abt_id,
    arthiertyp_id, relevant_fg, bezugsweg_id, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.gjmo,
        T1.gj,
        T1.kjmo,
        T1.wg_id,
        T1.abt_id,
        T1.arthiertyp_id,
        COALESCE(T3.relevant_fg, 0) AS `_relevant_fg`,
        COALESCE(T2.bezugsweg_id, 0) AS `_bezugsweg_id`,
        COALESCE(CASE
            WHEN T2.wrg_id = 'EU4'
                THEN 'EUR'
            ELSE T2.wrg_id
        END, T1.wrg_id) AS `_wrg_id`,
        SUM(T1.menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
        SUM(T1.menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
        SUM(
            CAST(COALESCE(T2.vk_brutto, 0) / (1 + T1.mwst / 100) * T1.menge_lgbest_erp_frei_bme AS NUMERIC)) AS
        betrag_vk_netto_frei_bme,
        SUM(
            CAST(COALESCE(T2.vk_brutto, 0) / (1 + T1.mwst / 100) * T1.menge_lgbest_erp_qual_bme AS NUMERIC)) AS
        betrag_vk_netto_qual_bme,
        SUM(ROUND(CAST(COALESCE(T2.vk_brutto, 0) * T1.menge_lgbest_erp_frei_bme AS NUMERIC), 4)) AS betrag_vk_brutto_frei_bme
        ,
        SUM(ROUND(CAST(COALESCE(T2.vk_brutto, 0) * T1.menge_lgbest_erp_qual_bme AS NUMERIC), 4)) AS betrag_vk_brutto_qual_bme
    FROM dbp_etl.vis_monat_bestand_wg_tmp2_2 AS T1_2
    LEFT JOIN dbp_data.art_wup_zu_per_2 AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id AND
            T1.nb_id = T2.nb_id AND T1.art_id = T2.art_id AND T1.max_dat BETWEEN T2.dat_von AND T2.dat_bis
    LEFT JOIN dbp_etl.vis_monat_bestand_stamm_lkp2_2 AS T3
        ON
            T1.mandant_id = T3.mandant_id AND T1.wup_id =
            T3.wup_id AND T1.nb_id = T3.nb_id AND T1.art_id = T3.art_id AND T1.kjmo = T3.kjmo
    GROUP BY
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.gjmo,
        T1.gj,
        T1.kjmo,
        T1.wg_id,
        T1.abt_id,
        T1.arthiertyp_id,
        `_bezugsweg_id`,
        `_relevant_fg`,
        `_wrg_id`
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_2
--(
--  mandant_id
-- ,wup_id
-- ,nb_id
-- ,gj
-- ,kjmo
-- ,wg_id
-- ,abt_id
-- ,arthiertyp_id
-- ,bezugsweg_id
-- ,relevant_fg
-- ,wrg_id
-- ,menge_lgbest_erp_frei_bme
-- ,menge_lgbest_erp_qual_bme
-- ,betrag_vk_netto_frei_bme
-- ,betrag_vk_netto_qual_bme
-- ,betrag_vk_brutto_frei_bme
-- ,betrag_vk_brutto_qual_bme
-- ,menge_lgbest_erp_frei_bme_kum
-- ,menge_lgbest_erp_qual_bme_kum
-- ,betrag_vk_netto_frei_bme_kum
-- ,betrag_vk_netto_qual_bme_kum
-- ,betrag_vk_brutto_frei_bme_kum
-- ,betrag_vk_brutto_qual_bme_kum
--)
--SELECT
--  tmp.mandant_id
-- ,tmp.wup_id
-- ,tmp.nb_id
-- ,tmp.gj
-- ,tmp.kjmo
-- ,tmp.wg_id
-- ,tmp.abt_id
-- ,tmp.arthiertyp_id
-- ,tmp.bezugsweg_id
-- ,tmp.relevant_fg
-- ,tmp.wrg_id
-- ,tmp.menge_lgbest_erp_frei_bme
-- ,tmp.menge_lgbest_erp_qual_bme
-- ,tmp.betrag_vk_netto_frei_bme
-- ,tmp.betrag_vk_netto_qual_bme
-- ,tmp.betrag_vk_brutto_frei_bme
-- ,tmp.betrag_vk_brutto_qual_bme
-- ,SUM(tmp.menge_lgbest_erp_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS menge_lgbest_erp_frei_bme_kum
-- ,SUM(tmp.menge_lgbest_erp_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS menge_lgbest_erp_qual_bme_kum
-- ,SUM(tmp.betrag_vk_netto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS betrag_vk_netto_frei_bme_kum
-- ,SUM(tmp.betrag_vk_netto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS betrag_vk_netto_qual_bme_kum
-- ,SUM(tmp.betrag_vk_brutto_frei_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS betrag_vk_brutto_frei_bme_kum
-- ,SUM(tmp.betrag_vk_brutto_qual_bme) OVER (PARTITION BY tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id, tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
--                                       ORDER BY m.gjmo ASC
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)   AS betrag_vk_brutto_qual_bme_kum
--
--FROM
--(SELECT
--    mandant_id
--   ,wup_id
--   ,nb_id
--   ,gj
--   ,kjmo
--   ,wg_id
--   ,abt_id
--   ,arthiertyp_id
--   ,bezugsweg_id
--   ,relevant_fg
--   ,wrg_id
--   ,menge_lgbest_erp_frei_bme
--   ,menge_lgbest_erp_qual_bme
--   ,betrag_vk_netto_frei_bme
--   ,betrag_vk_netto_qual_bme
--   ,betrag_vk_brutto_frei_bme
--   ,betrag_vk_brutto_qual_bme
-- FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3_2
-- 
--   UNION ALL
-- SELECT
--    mandant_id
--   ,wup_id
--   ,nb_id
--   ,gj
--   ,kjmo
--   ,wg_id
--   ,abt_id
--   ,arthiertyp_id
--   ,bezugsweg_id
--   ,relevant_fg
--   ,wrg_id
--   ,menge_lgbest_erp_frei_bme
--   ,menge_lgbest_erp_qual_bme
--   ,betrag_vk_netto_frei_bme
--   ,betrag_vk_netto_qual_bme
--   ,betrag_vk_brutto_frei_bme
--   ,betrag_vk_brutto_qual_bme
-- FROM ${DWH_COMMON_DBX_MSI_DATA}.vis_monat_bestand_wg_2 t1_2
-- WHERE (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg) IN
-- (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3_2
-- )
--   AND (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg) NOT IN
-- (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3_2
-- )
--) tmp
--    INNER JOIN
--      ${DWH_COMMON_DBX_DATA}.monat_2 m
--    ON tmp.kjmo = m.kjmo
--
--QUALIFY (tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.wg_id, tmp.wrg_id, tmp.arthiertyp_id, tmp.kjmo, tmp.bezugsweg_id, tmp.relevant_fg) IN
-- (SELECT mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_tmp3_2
-- )
--;
--
--Comment from validation checker
--error line 47 at position 75 unexpected 'MOD'.
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo  ^^^> MOD 100)   AS menge_lgbest_erp_frei_bme_kum
--syntax error line 47 at position 79 unexpected '100'.
--                                       ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD  ^^^> 100)   AS menge_lgbest_erp_frei_bme_kum
--translated statement


INSERT INTO dbp_etl.vis_monat_bestand_wg_2 (
    mandant_id, wup_id, nb_id, kjmo, relevant_fg, bezugsweg_id,
    arthiertyp_id, wg_id, wrg_id, abt_id, gj, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme,
    menge_lgbest_erp_frei_bme_kum, menge_lgbest_erp_qual_bme_kum, betrag_vk_netto_frei_bme_kum,
    betrag_vk_netto_qual_bme_kum, betrag_vk_brutto_frei_bme_kum, betrag_vk_brutto_qual_bme_kum
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        kjmo,
        relevant_fg,
        bezugsweg_id,
        arthiertyp_id,
        wg_id,
        wrg_id,
        abt_id,
        gj,
        menge_lgbest_erp_frei_bme,
        menge_lgbest_erp_qual_bme,
        betrag_vk_netto_frei_bme,
        betrag_vk_netto_qual_bme,
        betrag_vk_brutto_frei_bme,
        betrag_vk_brutto_qual_bme,
        menge_lgbest_erp_frei_bme_kum,
        menge_lgbest_erp_qual_bme_kum,
        betrag_vk_netto_frei_bme_kum,
        betrag_vk_netto_qual_bme_kum,
        betrag_vk_brutto_frei_bme_kum,
        betrag_vk_brutto_qual_bme_kum
    FROM (
        SELECT
            tmp.mandant_id,
            tmp.wup_id,
            tmp.nb_id,
            tmp.gj,
            tmp.kjmo,
            tmp.wg_id,
            tmp.abt_id,
            tmp.arthiertyp_id,
            tmp.bezugsweg_id,
            tmp.relevant_fg,
            tmp.wrg_id,
            tmp.menge_lgbest_erp_frei_bme,
            tmp.menge_lgbest_erp_qual_bme,
            tmp.betrag_vk_netto_frei_bme,
            tmp.betrag_vk_netto_qual_bme,
            tmp.betrag_vk_brutto_frei_bme,
            tmp.betrag_vk_brutto_qual_bme,
            (SUM(tmp.menge_lgbest_erp_frei_bme) OVER (PARTITION BY
                tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id,
                tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
            ORDER BY M.gjmo IS NULL, M.gjmo
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW)) / MOD(M.gjmo, 100) AS menge_lgbest_erp_frei_bme_kum,
            (SUM(tmp.menge_lgbest_erp_qual_bme) OVER (PARTITION BY
                tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id,
                tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
            ORDER BY M.gjmo IS NULL, M.gjmo
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW)) / MOD(M.gjmo, 100) AS menge_lgbest_erp_qual_bme_kum,
            (SUM(tmp.betrag_vk_netto_frei_bme) OVER (PARTITION BY
                tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id,
                tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
            ORDER BY M.gjmo IS NULL, M.gjmo
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW)) / MOD(M.gjmo, 100) AS betrag_vk_netto_frei_bme_kum,
            (SUM(tmp.betrag_vk_netto_qual_bme) OVER (PARTITION BY
                tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id,
                tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
            ORDER BY M.gjmo IS NULL, M.gjmo
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW)) / MOD(M.gjmo, 100) AS betrag_vk_netto_qual_bme_kum,
            (SUM(tmp.betrag_vk_brutto_frei_bme) OVER (PARTITION BY
                tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id,
                tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
            ORDER BY M.gjmo IS NULL, M.gjmo
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW)) / MOD(M.gjmo, 100) AS betrag_vk_brutto_frei_bme_kum,
            (SUM(tmp.betrag_vk_brutto_qual_bme) OVER (PARTITION BY
                tmp.mandant_id, tmp.wup_id, tmp.nb_id, tmp.gj, tmp.wg_id,
                tmp.wrg_id, tmp.bezugsweg_id, tmp.relevant_fg
            ORDER BY M.gjmo IS NULL, M.gjmo
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW)) / MOD(M.gjmo, 100) AS betrag_vk_brutto_qual_bme_kum
        FROM (SELECT
            mandant_id,
            wup_id,
            nb_id,
            gj,
            kjmo,
            wg_id,
            abt_id,
            arthiertyp_id,
            bezugsweg_id,
            relevant_fg,
            wrg_id,
            menge_lgbest_erp_frei_bme,
            menge_lgbest_erp_qual_bme,
            betrag_vk_netto_frei_bme,
            betrag_vk_netto_qual_bme,
            betrag_vk_brutto_frei_bme,
            betrag_vk_brutto_qual_bme
        FROM dbp_etl.vis_monat_bestand_wg_tmp3_2
        UNION ALL
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            gj,
            kjmo,
            wg_id,
            abt_id,
            arthiertyp_id,
            bezugsweg_id,
            relevant_fg,
            wrg_id,
            menge_lgbest_erp_frei_bme,
            menge_lgbest_erp_qual_bme,
            betrag_vk_netto_frei_bme,
            betrag_vk_netto_qual_bme,
            betrag_vk_brutto_frei_bme,
            betrag_vk_brutto_qual_bme
        FROM dbp_msi_data.vis_monat_bestand_wg_2 AS T1_2
        WHERE (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg) IN (SELECT (
            mandant_id,
            wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, gj, bezugsweg_id, relevant_fg
        )
        FROM dbp_etl.vis_monat_bestand_wg_tmp3_2)
        AND (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg) NOT IN (SELECT (
            mandant_id,
            wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
        )
        FROM dbp_etl.vis_monat_bestand_wg_tmp3_2)) AS tmp
        INNER JOIN dbp_data.monat_2 AS M ON tmp.kjmo = M.kjmo
    ) AS t6
    WHERE
        (t6.mandant_id, t6.wup_id, t6.nb_id, t6.wg_id, t6.wrg_id, t6.arthiertyp_id, t6.kjmo, t6.bezugsweg_id, t6.relevant_fg
        ) IN (
            SELECT (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg)
            FROM dbp_etl.vis_monat_bestand_wg_tmp3_2
        )
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_monat_bestand_wg_2 (
    mandant_id, wup_id, nb_id, kjmo, relevant_fg, bezugsweg_id,
    arthiertyp_id, wg_id, wrg_id, abt_id, gj, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme,
    menge_lgbest_erp_frei_bme_kum, menge_lgbest_erp_qual_bme_kum, betrag_vk_netto_frei_bme_kum,
    betrag_vk_netto_qual_bme_kum, betrag_vk_brutto_frei_bme_kum, betrag_vk_brutto_qual_bme_kum
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.kjmo,
        T1.relevant_fg,
        T1.bezugsweg_id,
        T1.arthiertyp_id,
        T1.wg_id,
        K.nach_wrg_id,
        T1.abt_id,
        T1.gj,
        T1.menge_lgbest_erp_frei_bme,
        T1.menge_lgbest_erp_qual_bme,
        T1.betrag_vk_netto_frei_bme * K.umrechnungskurs AS betrag_vk_netto_frei_bme,
        T1.betrag_vk_netto_qual_bme * K.umrechnungskurs AS betrag_vk_netto_qual_bme,
        T1.betrag_vk_brutto_frei_bme * K.umrechnungskurs AS betrag_vk_brutto_frei_bme,
        T1.betrag_vk_brutto_qual_bme * K.umrechnungskurs AS betrag_vk_brutto_qual_bme,
        T1.menge_lgbest_erp_frei_bme_kum,
        T1.menge_lgbest_erp_qual_bme_kum,
        T1.betrag_vk_netto_frei_bme_kum * K.umrechnungskurs AS betrag_vk_netto_frei_bme_kum,
        T1.betrag_vk_netto_qual_bme_kum * K.umrechnungskurs AS betrag_vk_netto_qual_bme_kum,
        T1.betrag_vk_brutto_frei_bme_kum * K.umrechnungskurs AS betrag_vk_brutto_frei_bme_kum,
        T1.betrag_vk_brutto_qual_bme_kum * K.umrechnungskurs AS betrag_vk_brutto_qual_bme_kum
    FROM dbp_etl.vis_monat_bestand_wg_2 AS T1_2
    INNER JOIN dbp_data.kurs_2 AS K
        ON
            T1.wrg_id = K.von_wrg_id AND K.dat_bis = PARSE_DATE('%F', '9999-12-31'
            ) AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
    WHERE T1.wrg_id <> 'EUR'
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_msi_data.vis_monat_bestand_wg_2
WHERE (mandant_id, wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg) IN (SELECT (
    mandant_id,
    wup_id, nb_id, wg_id, wrg_id, arthiertyp_id, kjmo, bezugsweg_id, relevant_fg
)
FROM dbp_etl.vis_monat_bestand_wg_2);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_msi_data.vis_monat_bestand_wg_2 (
    mandant_id, wup_id, nb_id, kjmo, relevant_fg, bezugsweg_id,
    arthiertyp_id, wg_id, wrg_id, abt_id, gj, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme,
    menge_lgbest_erp_frei_bme_kum, menge_lgbest_erp_qual_bme_kum, betrag_vk_netto_frei_bme_kum,
    betrag_vk_netto_qual_bme_kum, betrag_vk_brutto_frei_bme_kum, betrag_vk_brutto_qual_bme_kum
)
(SELECT
    mandant_id,
    wup_id,
    nb_id,
    kjmo,
    relevant_fg,
    bezugsweg_id,
    arthiertyp_id,
    wg_id,
    wrg_id,
    abt_id,
    gj,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme,
    betrag_vk_brutto_frei_bme,
    betrag_vk_brutto_qual_bme,
    menge_lgbest_erp_frei_bme_kum,
    menge_lgbest_erp_qual_bme_kum,
    betrag_vk_netto_frei_bme_kum,
    betrag_vk_netto_qual_bme_kum,
    betrag_vk_brutto_frei_bme_kum,
    betrag_vk_brutto_qual_bme_kum
FROM dbp_etl.vis_monat_bestand_wg_2);
