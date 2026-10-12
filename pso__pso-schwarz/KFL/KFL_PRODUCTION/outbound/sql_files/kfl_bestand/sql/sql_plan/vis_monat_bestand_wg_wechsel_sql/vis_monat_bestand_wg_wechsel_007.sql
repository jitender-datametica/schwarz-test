--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.


INSERT INTO dbp_etl.vis_mon_best_wg_wechsel_join (
    mandant_id, art_id, arthiertyp_id, alt_neu_kz, wg_id,
    gj, gjmo, kjmo, max_dat, mwst, wrg_id
)
(
    SELECT
        W1.mandant_id,
        W1.art_id,
        W1.arthiertyp_id,
        W1.alt_neu_kz,
        W1.wg_id,
        M.gj,
        M.gjmo,
        M.kjmo,
        CASE
            WHEN EXTRACT(MONTH FROM M.max_dat) = EXTRACT(MONTH FROM CURRENT_DATE("Europe/Berlin"))
                THEN CURRENT_DATE("Europe/Berlin")
            ELSE M.max_dat
        END AS max_dat,
        COALESCE(MP.mwst, 0) AS mp_mwst,
        MWTZ.default_wrg
    FROM dbp_etl.vis_mon_best_wg_wechsel_tmp AS W1
    INNER JOIN dbp_etl.vis_mon_best_wg_wechsel_tmp AS W2
        ON
            W1.mandant_id = W2.mandant_id AND W1.art_id =
            W2.art_id AND W1.arthiertyp_id = W2.arthiertyp_id AND (
                W1.alt_neu_kz = 1 AND W2.alt_neu_kz = -1 OR W1.alt_neu_kz
                = -1 AND W2.alt_neu_kz = 1
            )
    INNER JOIN dbp_data.monat AS M ON M.akt_mo <= 0 AND M.akt_gj IN (-2, -1, 0)
    INNER JOIN dbp_data.art AS A ON W1.mandant_id = A.mandant_id AND W1.art_id = A.art_id
    INNER JOIN dbp_data.mwst_per AS MP
        ON
            A.mandant_id = MP.mandant_id AND A.mwst_id = MP.mwst_id AND M.max_dat
            BETWEEN MP.dat_von AND MP.dat_bis
    INNER JOIN dbp_data.mandant AS MWTZ ON W1.mandant_id = MWTZ.mandant_id
    WHERE W1.wg_id <> W2.wg_id
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- DE: '11','ZZ'---
-- KMO: nur 'S2'---
INSERT INTO dbp_etl.vis_monat_bestand_stamm_lkp2 (
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
    FROM dbp_data.art_wup_zu_per AS T21
    INNER JOIN dbp_etl.vis_mon_best_wg_wechsel_join AS T22
        ON
            T21.mandant_id = T22.mandant_id AND T21.art_id
            = T22.art_id AND T22.alt_neu_kz = 1 AND T22.max_dat BETWEEN T21.dat_von AND T21.dat_bis
    INNER JOIN dbp_data.art AS T23 ON T21.mandant_id = T23.mandant_id AND T21.art_id = T23.art_id
    INNER JOIN dbp_data.wup AS T24
        ON
            T21.mandant_id = T24.mandant_id AND T21.wup_id = T24.wup_id AND T21.nb_id
            = T24.nb_id AND T22.max_dat BETWEEN T24.dat_von AND T24.dat_bis
    INNER JOIN dbp_data.art_wup_status_per AS T25
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


DELETE FROM dbp_etl.vis_monat_bestand_stamm_lkp2
WHERE (
    kjmo, mandant_id, art_id, wup_id, nb_id) IN (
    SELECT (B.kjmo, A.mandant_id, A.art_id, A.wup_id, A.nb_id)
    FROM dbp_etl.vis_mard_relevant AS A
    INNER JOIN
        dbp_etl.vis_mon_best_wg_wechsel_join
            AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id
            AND B.alt_neu_kz = 1 AND A.dat = B.max_dat
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_monat_bestand_stamm_lkp2 (mandant_id, wup_id, nb_id, kjmo, art_id, relevant_fg)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        B.kjmo,
        A.art_id,
        A.relevant_fg
    FROM dbp_etl.vis_mard_relevant AS A
    INNER JOIN
        dbp_etl.vis_mon_best_wg_wechsel_join
            AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id
            AND B.alt_neu_kz = 1 AND A.dat = B.max_dat
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_mon_best_wg_wechsel_sum_t1 (
    mandant_id, wup_id, wg_id, art_id, gj, kjmo, max_dat,
    arthiertyp_id, nb_id, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme, mwst
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T2.wg_id,
        T2.art_id,
        T2.gj,
        T2.kjmo,
        T2.max_dat,
        T2.arthiertyp_id
        -- Falls der Artikel nicht in art_wup_zu_per gelistet ist, wird die Default wrg_id aus mandant_wrg_typ_zu ermittelt

        -- (s. Befuellung vis_monat_bestand_stamm_lkp)
        ,
        T1.nb_id,
        T2.wrg_id,
        CAST(T1.menge_lgbest_erp_frei_bme * T2.alt_neu_kz AS NUMERIC) AS menge_lgbest_erp_frei_bme,
        CAST(T1.menge_lgbest_erp_qual_bme * T2.alt_neu_kz AS NUMERIC) AS menge_lgbest_erp_qual_bme,
        T2.mwst
    FROM dbp_data.bestand_erp_monat AS T1
    INNER JOIN
        dbp_etl.vis_mon_best_wg_wechsel_join
            AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.art_id =
            T2.art_id AND T2.gjmo BETWEEN T1.gjmo AND T1.gjmo_bis
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- (s. Befuellung vis_monat_bestand_stamm_lkp)
-- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq

-- Wie in Markbestand-Verarbeitung s. bestand_mardf_delta.btq

-- Falls der Artikel nicht in art_wup_zu_per gelistet istt, wird die Default wrg_id aus mandant ermittelt
INSERT INTO
dbp_etl.vis_mon_best_wg_wechsel_sum_t2 (
    mandant_id, wup_id, wg_id, gj, kjmo, arthiertyp_id, nb_id,
    relevant_fg, bezugsweg_id, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.wg_id,
        T1.gj,
        T1.kjmo,
        T1.arthiertyp_id,
        T1.nb_id,
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
    FROM dbp_etl.vis_mon_best_wg_wechsel_sum_t1 AS T1
    LEFT JOIN dbp_data.art_wup_zu_per AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id AND
            T1.nb_id = T2.nb_id AND T1.art_id = T2.art_id AND T1.max_dat BETWEEN T2.dat_von AND T2.dat_bis
    LEFT JOIN dbp_etl.vis_monat_bestand_stamm_lkp2 AS T3
        ON
            T1.mandant_id = T3.mandant_id AND T1.wup_id =
            T3.wup_id AND T1.nb_id = T3.nb_id AND T1.art_id = T3.art_id AND T1.kjmo = T3.kjmo
    GROUP BY
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.gj,
        T1.kjmo,
        T1.wg_id,
        T1.arthiertyp_id,
        `_bezugsweg_id`,
        `_relevant_fg`,
        `_wrg_id`
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_mon_best_wg_wechsel_sum_t2 (
    mandant_id, wup_id, wg_id, gj, kjmo, arthiertyp_id,
    nb_id, relevant_fg, bezugsweg_id, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.wg_id,
        T1.gj,
        T1.kjmo,
        T1.arthiertyp_id,
        T1.nb_id,
        T1.relevant_fg,
        T1.bezugsweg_id,
        K.nach_wrg_id,
        T1.menge_lgbest_erp_frei_bme,
        T1.menge_lgbest_erp_qual_bme,
        T1.betrag_vk_netto_frei_bme * K.umrechnungskurs AS betrag_vk_netto_frei_bme,
        T1.betrag_vk_netto_qual_bme * K.umrechnungskurs AS betrag_vk_netto_qual_bme,
        T1.betrag_vk_brutto_frei_bme * K.umrechnungskurs AS betrag_vk_brutto_frei_bme,
        T1.betrag_vk_brutto_qual_bme * K.umrechnungskurs AS betrag_vk_brutto_qual_bme
    FROM dbp_etl.vis_mon_best_wg_wechsel_sum_t2 AS T1
    INNER JOIN dbp_data.kurs AS K
        ON
            T1.wrg_id = K.von_wrg_id AND K.dat_bis = PARSE_DATE('%F', '9999-12-31'
            ) AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
    WHERE T1.wrg_id <> 'EUR'
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'ZIEL' does not exist or not authorized.


UPDATE dbp_msi_data.vis_monat_bestand_wg AS ZIEL SET
    menge_lgbest_erp_frei_bme = ZIEL.menge_lgbest_erp_frei_bme + tmp.menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme = ZIEL.menge_lgbest_erp_qual_bme + tmp.menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme = ZIEL.betrag_vk_netto_frei_bme + tmp.betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme = ZIEL.betrag_vk_netto_qual_bme + tmp.betrag_vk_netto_qual_bme,
    betrag_vk_brutto_frei_bme = ZIEL.betrag_vk_brutto_frei_bme + tmp.betrag_vk_brutto_frei_bme,
    betrag_vk_brutto_qual_bme = ZIEL.betrag_vk_brutto_qual_bme + tmp.betrag_vk_brutto_qual_bme FROM (
    SELECT *
    FROM dbp_etl.vis_mon_best_wg_wechsel_sum_t2
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            mandant_id, wup_id, wg_id, kjmo, arthiertyp_id, nb_id, wrg_id, bezugsweg_id,
            relevant_fg ORDER BY
            mandant_id IS NULL, mandant_id, wup_id IS NULL, wup_id, wg_id IS NULL, wg_id, kjmo IS NULL,
            kjmo, arthiertyp_id IS NULL, arthiertyp_id, nb_id IS NULL, nb_id, wrg_id IS NULL, wrg_id, bezugsweg_id IS NULL,
            bezugsweg_id, relevant_fg IS NULL, relevant_fg
    )) = 1
) AS tmp
WHERE
    ZIEL.mandant_id = tmp.mandant_id AND ZIEL.wup_id = tmp.wup_id AND ZIEL.wg_id = tmp.wg_id AND ZIEL.kjmo = tmp.kjmo
    AND ZIEL.arthiertyp_id = tmp.arthiertyp_id AND ZIEL.nb_id = tmp.nb_id AND ZIEL.wrg_id = tmp.wrg_id AND ZIEL.bezugsweg_id
    = tmp.bezugsweg_id AND ZIEL.relevant_fg = tmp.relevant_fg;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_msi_data.vis_monat_bestand_wg (
    mandant_id, wup_id, nb_id, kjmo, relevant_fg, bezugsweg_id,
    arthiertyp_id, wg_id, wrg_id, abt_id, gj, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme
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
        T1.wrg_id,
        WP.abt_id,
        T1.gj,
        T1.menge_lgbest_erp_frei_bme,
        T1.menge_lgbest_erp_qual_bme,
        T1.betrag_vk_netto_frei_bme,
        T1.betrag_vk_netto_qual_bme,
        T1.betrag_vk_brutto_frei_bme,
        T1.betrag_vk_brutto_qual_bme
    FROM dbp_etl.vis_mon_best_wg_wechsel_sum_t2 AS T1
    INNER JOIN dbp_data.wg_per AS WP
        ON
            T1.mandant_id = WP.mandant_id AND T1.wg_id = WP.wg_id AND T1.arthiertyp_id
            = WP.arthiertyp_id AND WP.dat_bis = PARSE_DATE('%F', '9999-12-31')
    LEFT JOIN dbp_msi_data.vis_monat_bestand_wg AS ZIEL
        ON
            T1.mandant_id = ZIEL.mandant_id AND T1.wup_id =
            ZIEL.wup_id AND T1.wg_id = ZIEL.wg_id AND T1.kjmo = ZIEL.kjmo AND T1.arthiertyp_id = ZIEL.arthiertyp_id AND
            T1.nb_id = ZIEL.nb_id AND T1.wrg_id = ZIEL.wrg_id AND T1.bezugsweg_id = ZIEL.bezugsweg_id AND T1.relevant_fg =
            ZIEL.relevant_fg
    WHERE ZIEL.mandant_id IS NULL
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Modulo operator does not exist in Snowflake. Use MOD function instead.
--original statement
--UPDATE t1
--FROM ${DWH_COMMON_DBX_MSI_DATA}.vis_monat_bestand_wg t1,
--(SELECT
--     t1.mandant_id
--    ,t1.wup_id
--    ,t1.wg_id
--    ,t1.abt_id
--    ,t1.kjmo
--    ,t1.arthiertyp_id
--    ,t1.bezugsweg_id
--    ,t1.relevant_fg
--    ,t1.nb_id
--    ,t1.wrg_id
--    ,SUM(t1.menge_lgbest_erp_frei_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS menge_lgbest_erp_frei_bme_kum
--    ,SUM(t1.menge_lgbest_erp_qual_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS menge_lgbest_erp_qual_bme_kum
--    ,SUM(t1.betrag_vk_netto_frei_bme)  OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS betrag_vk_netto_frei_bme_kum
--    ,SUM(t1.betrag_vk_netto_qual_bme)  OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS betrag_vk_netto_qual_bme_kum
--    ,SUM(t1.betrag_vk_brutto_frei_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS betrag_vk_brutto_frei_bme_kum
--    ,SUM(t1.betrag_vk_brutto_qual_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--                                             ORDER BY m.gjmo ASC
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD 100)    AS betrag_vk_brutto_qual_bme_kum
-- FROM ${DWH_COMMON_DBX_MSI_DATA}.vis_monat_bestand_wg t1
--   INNER JOIN
--      ${DWH_COMMON_DBX_DATA}.monat m
--   ON t1.kjmo = m.kjmo
-- WHERE (t1.mandant_id, t1.wg_id) IN
-- (SELECT mandant_id, wg_id
--  FROM ${DWH_COMMON_DBX_LOAD}.vis_mon_best_wg_wechsel_join
-- )
--) tmp
--
--SET menge_lgbest_erp_frei_bme_kum = tmp.menge_lgbest_erp_frei_bme_kum
--   ,menge_lgbest_erp_qual_bme_kum = tmp.menge_lgbest_erp_qual_bme_kum
--   ,betrag_vk_netto_frei_bme_kum  = tmp.betrag_vk_netto_frei_bme_kum
--   ,betrag_vk_netto_qual_bme_kum  = tmp.betrag_vk_netto_qual_bme_kum
--   ,betrag_vk_brutto_frei_bme_kum = tmp.betrag_vk_brutto_frei_bme_kum
--   ,betrag_vk_brutto_qual_bme_kum = tmp.betrag_vk_brutto_qual_bme_kum
--WHERE t1.mandant_id    = tmp.mandant_id
--  AND t1.wup_id        = tmp.wup_id
--  AND t1.wg_id         = tmp.wg_id
--  AND t1.abt_id        = tmp.abt_id
--  AND t1.kjmo          = tmp.kjmo
--  AND t1.arthiertyp_id = tmp.arthiertyp_id
--  AND t1.nb_id         = tmp.nb_id
--  AND t1.wrg_id        = tmp.wrg_id
--  AND t1.bezugsweg_id  = tmp.bezugsweg_id
--  AND t1.relevant_fg   = tmp.relevant_fg
--;
--
--Comment from validation checker
--error line 23 at position 81 unexpected 'MOD'.
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo  ^^^> MOD 100)    AS menge_lgbest_erp_frei_bme_kum
--syntax error line 23 at position 85 unexpected '100'.
--                                             ROWS UNBOUNDED PRECEDING) / (m.gjmo MOD  ^^^> 100)    AS menge_lgbest_erp_frei_bme_kum
--syntax error line 24 at position 8 unexpected '('.
--    ,SUM ^^^> (t1.menge_lgbest_erp_qual_bme) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.nb_id, t1.wg_id, t1.abt_id, t1.gj, t1.wrg_id, t1.bezugsweg_id, t1.relevant_fg
--syntax error line 25 at position 45 unexpected 'ORDER'.
--                                              ^^^> ORDER BY m.gjmo ASC
--translated statement


UPDATE dbp_msi_data.vis_monat_bestand_wg AS T1 SET
    menge_lgbest_erp_frei_bme_kum = tmp.menge_lgbest_erp_frei_bme_kum,
    menge_lgbest_erp_qual_bme_kum = tmp.menge_lgbest_erp_qual_bme_kum,
    betrag_vk_netto_frei_bme_kum = tmp.betrag_vk_netto_frei_bme_kum,
    betrag_vk_netto_qual_bme_kum = tmp.betrag_vk_netto_qual_bme_kum,
    betrag_vk_brutto_frei_bme_kum = tmp.betrag_vk_brutto_frei_bme_kum,
    betrag_vk_brutto_qual_bme_kum = tmp.betrag_vk_brutto_qual_bme_kum FROM (
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.wg_id,
        T1.abt_id,
        T1.kjmo,
        T1.arthiertyp_id,
        T1.bezugsweg_id,
        T1.relevant_fg,
        T1.nb_id,
        T1.wrg_id,
        (SUM(T1.menge_lgbest_erp_frei_bme) OVER (PARTITION BY
            T1.mandant_id, T1.wup_id, T1.nb_id, T1.wg_id, T1.abt_id, T1.gj,
            T1.wrg_id, T1.bezugsweg_id, T1.relevant_fg
        ORDER BY M.gjmo IS NULL, M.gjmo
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW)) / MOD(M.gjmo, 100) AS menge_lgbest_erp_frei_bme_kum,
        (SUM(T1.menge_lgbest_erp_qual_bme) OVER (PARTITION BY
            T1.mandant_id, T1.wup_id, T1.nb_id, T1.wg_id, T1.abt_id, T1.gj,
            T1.wrg_id, T1.bezugsweg_id, T1.relevant_fg
        ORDER BY M.gjmo IS NULL, M.gjmo
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW)) / MOD(M.gjmo, 100) AS menge_lgbest_erp_qual_bme_kum,
        (SUM(T1.betrag_vk_netto_frei_bme) OVER (PARTITION BY
            T1.mandant_id, T1.wup_id, T1.nb_id, T1.wg_id, T1.abt_id, T1.gj,
            T1.wrg_id, T1.bezugsweg_id, T1.relevant_fg
        ORDER BY M.gjmo IS NULL, M.gjmo
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW)) / MOD(M.gjmo, 100) AS betrag_vk_netto_frei_bme_kum,
        (SUM(T1.betrag_vk_netto_qual_bme) OVER (PARTITION BY
            T1.mandant_id, T1.wup_id, T1.nb_id, T1.wg_id, T1.abt_id, T1.gj,
            T1.wrg_id, T1.bezugsweg_id, T1.relevant_fg
        ORDER BY M.gjmo IS NULL, M.gjmo
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW)) / MOD(M.gjmo, 100) AS betrag_vk_netto_qual_bme_kum,
        (SUM(T1.betrag_vk_brutto_frei_bme) OVER (PARTITION BY
            T1.mandant_id, T1.wup_id, T1.nb_id, T1.wg_id, T1.abt_id, T1.gj,
            T1.wrg_id, T1.bezugsweg_id, T1.relevant_fg
        ORDER BY M.gjmo IS NULL, M.gjmo
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW)) / MOD(M.gjmo, 100) AS betrag_vk_brutto_frei_bme_kum,
        (SUM(T1.betrag_vk_brutto_qual_bme) OVER (PARTITION BY
            T1.mandant_id, T1.wup_id, T1.nb_id, T1.wg_id, T1.abt_id, T1.gj,
            T1.wrg_id, T1.bezugsweg_id, T1.relevant_fg
        ORDER BY M.gjmo IS NULL, M.gjmo
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW)) / MOD(M.gjmo, 100) AS betrag_vk_brutto_qual_bme_kum
    FROM dbp_msi_data.vis_monat_bestand_wg AS T1
    INNER JOIN dbp_data.monat AS M ON T1.kjmo = M.kjmo
    WHERE (
        T1.mandant_id, T1.wg_id) IN (
        SELECT (mandant_id, wg_id)
        FROM dbp_etl.vis_mon_best_wg_wechsel_join
    )
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            T1.mandant_id, T1.wup_id, T1.wg_id, T1.abt_id, T1.kjmo, T1.arthiertyp_id, T1.bezugsweg_id, T1.relevant_fg, T1.nb_id, T1.wrg_id ORDER BY
            T1.mandant_id IS NULL, T1.mandant_id, T1.wup_id
            IS NULL, T1.wup_id, T1.wg_id IS NULL, T1.wg_id, T1.abt_id IS NULL, T1.abt_id, T1.kjmo IS NULL, T1.kjmo, T1.arthiertyp_id
            IS NULL, T1.arthiertyp_id, T1.bezugsweg_id IS NULL, T1.bezugsweg_id, T1.relevant_fg IS NULL, T1.relevant_fg, T1.nb_id IS NULL, T1.nb_id, T1.wrg_id IS NULL, T1.wrg_id
    )) = 1
) AS tmp
WHERE
    T1.mandant_id = tmp.mandant_id AND T1.wup_id = tmp.wup_id AND T1.wg_id = tmp.wg_id AND T1.abt_id = tmp.abt_id
    AND T1.kjmo = tmp.kjmo AND T1.arthiertyp_id = tmp.arthiertyp_id AND T1.nb_id = tmp.nb_id AND T1.wrg_id = tmp.wrg_id
    AND T1.bezugsweg_id = tmp.bezugsweg_id AND T1.relevant_fg = tmp.relevant_fg;


--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_etl.vis_monat_best_wg_wechsel_log;
