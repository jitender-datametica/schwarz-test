--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_tag_bestand_wg_delta_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_tag_bestand_wg_delta_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    abt_id INTEGER NOT NULL,
    gj INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    kjwo INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    relevant_fg INTEGER NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    anz_artikel_bestand INTEGER NOT NULL,
    anz_artikel_fehlmengen INTEGER NOT NULL,
    anz_artikel_nullbestand INTEGER NOT NULL,
    anz_artikel_minusbestand INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    betrag_vk_netto_frei_bme NUMERIC(29, 4),
    betrag_vk_netto_qual_bme NUMERIC(29, 4),
    betrag_vk_brutto_frei_bme NUMERIC(29, 4),
    betrag_vk_brutto_qual_bme NUMERIC(29, 4),
    betrag_mo_anf_vk_ntto_frei_bme NUMERIC(29, 4),
    betrag_mo_anf_vk_ntto_qual_bme NUMERIC(29, 4),
    betrag_mo_anf_vk_btto_frei_bme NUMERIC(29, 4),
    betrag_mo_anf_vk_btto_qual_bme NUMERIC(29, 4)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_tag_bestand_stamm_lkp_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_tag_bestand_stamm_lkp_2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    abt_id INTEGER,
    arthiertyp_id INTEGER NOT NULL
);


--      mwst NUMBER(29,2) NOT NULL,
--      mwst_dat_von DATE NOT NULL,
--      mwst_dat_bis DATE NOT NULL, UNIQUE ( art_id ,mandant_id  ));

--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_tag_bestand_tag_lkp_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_tag_bestand_tag_lkp_2 (
    dat DATE NOT NULL,
    gj INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    kjwo INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_tag_bestand_tag_lkp_2 (dat, gj, kjmo, kjwo)
(
    SELECT
        dat,
        gj,
        kjmo,
        kjwo
    FROM dbp_data.tag_2
    WHERE
        akt_tag <= 0
        AND dat > (
            SELECT MAX(dat)
            FROM dbp_msi_data.vis_tag_bestand_wg_2
        )
);


--[OK] statement is translated correctly (syntax and type checks are fine)


/* LEFT OUTER JOIN DBP_DATA.mwst_per_2 mp
 ON  a.mandant_id = mp.mandant_id
 AND a.mwst_id    = mp.mwst_id */
/* ,mwst
     ,mwst_dat_von
     ,mwst_dat_bis */ INSERT INTO dbp_etl.vis_tag_bestand_stamm_lkp_2 (
    art_id,
    mandant_id, wg_id, abt_id, arthiertyp_id
)
(
    SELECT
        A.art_id,
        A.mandant_id,
        AWZP.wg_id,
        WP.abt_id,
        AWZP.arthiertyp_id
    /* ,COALESCE (mp.mwst, 0.)
     ,COALESCE (mp.dat_von, to_date('1900-01-01','YYYY-MM_2-DD'))
     ,COALESCE (mp.dat_bis, CURRENT_DATE("Europe/Berlin") '9999-12-31') */

    FROM dbp_data.art_2 AS A
    INNER JOIN dbp_data.art_wg_zu_per_2 AS AWZP
        ON
            A.mandant_id = AWZP.mandant_id AND A.art_id = AWZP.art_id
            AND AWZP.arthiertyp_id = 2 AND AWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.wg_per_2 AS WP ON AWZP.mandant_id = WP.mandant_id AND AWZP.wg_id = WP.wg_id AND AWZP.arthiertyp_id = WP.arthiertyp_id AND WP.dat_bis = PARSE_DATE('%F', '9999-12-31')
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_tag_bestand_wg_delta_2 (
    mandant_id, wup_id, wg_id, dat, abt_id, gj, kjmo, kjwo,
    arthiertyp_id, nb_id, relevant_fg, bezugsweg_id, wrg_id, anz_artikel_bestand, anz_artikel_fehlmengen,
    anz_artikel_nullbestand, anz_artikel_minusbestand, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme
)
(
    SELECT
        T2.mandant_id,
        T2.wup_id,
        T4.wg_id,
        T1.dat,
        T4.abt_id,
        T1.gj,
        T1.kjmo,
        T1.kjwo,
        T4.arthiertyp_id,
        T2.nb_id,
        T2.relevant_fg,
        T2.bezugsweg_id,
        T3.wrg_id,
        COUNT(T2.art_id) AS anz_artikel_bestand,
        SUM(CASE
            WHEN T2.menge_lgbest_erp_frei_bme <= 0
                THEN 1
            ELSE 0
        END) AS anz_artikel_fehlmenge,
        SUM(CASE
            WHEN T2.menge_lgbest_erp_frei_bme = 0
                THEN 1
            ELSE 0
        END) AS anz_artikel_nullbestand,
        SUM(CASE
            WHEN T2.menge_lgbest_erp_frei_bme < 0
                THEN 1
            ELSE 0
        END) AS anz_artikel_minusbestand,
        SUM(T2.menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
        SUM(T2.menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
        SUM(ROUND(CAST(T3.vk_netto * T2.menge_lgbest_erp_frei_bme AS NUMERIC), 4)) AS betrag_vk_netto_frei_bme,
        SUM(ROUND(CAST(T3.vk_netto * T2.menge_lgbest_erp_qual_bme AS NUMERIC), 4)) AS betrag_vk_netto_qual_bme,
        SUM(ROUND(CAST(COALESCE(T5.vk_brutto, 0) * T2.menge_lgbest_erp_frei_bme AS NUMERIC), 4)) AS betrag_vk_brutto_frei_bme
        ,
        SUM(ROUND(CAST(COALESCE(T5.vk_brutto, 0) * T2.menge_lgbest_erp_qual_bme AS NUMERIC), 4)) AS betrag_vk_brutto_qual_bme
    FROM dbp_etl.vis_tag_bestand_tag_lkp_2 AS T1_2
    INNER JOIN dbp_data.marktbestand_erp_2 AS T2 ON T1.dat = T2.dat
    INNER JOIN dbp_data.marktbestand_erp_zu_2 AS T3 ON T2.bestand_id = T3.bestand_id AND T2.mandant_id = T3.mandant_id

    INNER JOIN dbp_etl.vis_tag_bestand_stamm_lkp_2 AS T4 ON T2.mandant_id = T4.mandant_id AND T2.art_id = T4.art_id -- AND t1.dat BETWEEN t4.mwst_dat_von AND t4.mwst_dat_bis

    LEFT JOIN dbp_data.art_wup_zu_per_2 AS T5
        ON
            T2.mandant_id = T5.mandant_id AND T2.art_id = T5.art_id AND
            T2.wup_id = T5.wup_id AND T2.nb_id = T5.nb_id AND T2.dat BETWEEN T5.dat_von AND T5.dat_bis
    GROUP BY
        T2.mandant_id,
        T2.wup_id,
        T4.wg_id,
        T1.dat,
        T4.abt_id,
        T1.gj,
        T1.kjmo,
        T1.kjwo,
        T4.arthiertyp_id,
        T2.nb_id,
        T2.relevant_fg,
        T2.bezugsweg_id,
        T3.wrg_id
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T1_2' does not exist or not authorized.


UPDATE dbp_etl.vis_tag_bestand_wg_delta_2 AS T1_2 SET
    betrag_mo_anf_vk_ntto_frei_bme = tmp.betrag_vk_netto_frei_bme,
    betrag_mo_anf_vk_ntto_qual_bme = tmp.betrag_vk_netto_qual_bme,
    betrag_mo_anf_vk_btto_frei_bme = tmp.betrag_vk_brutto_frei_bme,
    betrag_mo_anf_vk_btto_qual_bme = tmp.betrag_vk_brutto_qual_bme FROM (SELECT
    VTBW.mandant_id,
    VTBW.wup_id,
    VTBW.wg_id,
    VTBW.abt_id,
    VTBW.gj,
    M.kjmo,
    VTBW.arthiertyp_id,
    VTBW.nb_id,
    VTBW.relevant_fg,
    VTBW.bezugsweg_id,
    VTBW.wrg_id,
    VTBW.betrag_vk_netto_frei_bme,
    VTBW.betrag_vk_netto_qual_bme,
    VTBW.betrag_vk_brutto_frei_bme,
    VTBW.betrag_vk_brutto_qual_bme
FROM dbp_msi_data.vis_tag_bestand_wg_2 AS VTBW
INNER JOIN dbp_data.monat_2 AS M ON DATE_SUB(M.min_dat, INTERVAL 1 DAY) = VTBW.dat AND M.akt_mo = 0)
    AS
    tmp
WHERE
    T1.mandant_id = tmp.mandant_id AND T1.wup_id = tmp.wup_id AND T1.wg_id = tmp.wg_id AND T1.abt_id = tmp.abt_id AND
    T1.gj = tmp.gj AND T1.kjmo = tmp.kjmo AND T1.arthiertyp_id = tmp.arthiertyp_id AND T1.nb_id = tmp.nb_id AND T1.relevant_fg
    = tmp.relevant_fg AND T1.bezugsweg_id = tmp.bezugsweg_id AND T1.wrg_id = tmp.wrg_id;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_tag_bestand_wg_delta_2 (
    mandant_id, wup_id, wg_id, dat, abt_id, gj, kjmo, kjwo,
    arthiertyp_id, nb_id, relevant_fg, bezugsweg_id, wrg_id, anz_artikel_bestand, anz_artikel_fehlmengen,
    anz_artikel_nullbestand, anz_artikel_minusbestand, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme,
    betrag_mo_anf_vk_ntto_frei_bme, betrag_mo_anf_vk_ntto_qual_bme, betrag_mo_anf_vk_btto_frei_bme,
    betrag_mo_anf_vk_btto_qual_bme
)
(
    SELECT
        T1.mandant_id,
        T1.wup_id,
        T1.wg_id,
        T1.dat,
        T1.abt_id,
        T1.gj,
        T1.kjmo,
        T1.kjwo,
        T1.arthiertyp_id,
        T1.nb_id,
        T1.relevant_fg,
        T1.bezugsweg_id,
        K.nach_wrg_id,
        0 AS anz_artikel_bestand,
        0 AS anz_artikel_fehlmenge,
        0 AS anz_artikel_nullbestand,
        0 AS anz_artikel_minusbestand,
        T1.menge_lgbest_erp_frei_bme,
        T1.menge_lgbest_erp_qual_bme,
        T1.betrag_vk_netto_frei_bme * K.umrechnungskurs AS betrag_vk_netto_frei_bme,
        T1.betrag_vk_netto_qual_bme * K.umrechnungskurs AS betrag_vk_netto_qual_bme,
        T1.betrag_vk_brutto_frei_bme * K.umrechnungskurs AS betrag_vk_brutto_frei_bme,
        T1.betrag_vk_brutto_qual_bme * K.umrechnungskurs AS betrag_vk_brutto_qual_bme,
        T1.betrag_mo_anf_vk_ntto_frei_bme * K.umrechnungskurs AS betrag_mo_anf_vk_ntto_frei_bme,
        T1.betrag_mo_anf_vk_ntto_qual_bme * K.umrechnungskurs AS betrag_mo_anf_vk_ntto_qual_bme,
        T1.betrag_mo_anf_vk_btto_frei_bme * K.umrechnungskurs AS betrag_mo_anf_vk_btto_frei_bme,
        T1.betrag_mo_anf_vk_btto_qual_bme * K.umrechnungskurs AS betrag_mo_anf_vk_btto_qual_bme
    FROM dbp_etl.vis_tag_bestand_wg_delta_2 AS T1_2
    INNER JOIN dbp_data.kurs_2 AS K
        ON
            T1.wrg_id = K.von_wrg_id AND K.dat_bis = PARSE_DATE('%F', '9999-12-31'
            ) AND K.nach_wrg_id = 'EUR' AND K.kurstyp_id = 3
    WHERE T1.wrg_id <> 'EUR'
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_msi_data.vis_tag_bestand_wg_2
WHERE dat IN (
    SELECT dat
    FROM dbp_etl.vis_tag_bestand_tag_lkp_2
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_msi_data.vis_tag_bestand_wg_2 (
    mandant_id, wup_id, wg_id, dat, relevant_fg, bezugsweg_id,
    arthiertyp_id, wrg_id, abt_id, gj, kjmo, kjwo, nb_id, anz_artikel_bestand, anz_artikel_fehlmengen,
    anz_artikel_nullbestand, anz_artikel_minusbestand, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_brutto_frei_bme, betrag_vk_brutto_qual_bme,
    betrag_mo_anf_vk_ntto_frei_bme, betrag_mo_anf_vk_ntto_qual_bme, betrag_mo_anf_vk_btto_frei_bme,
    betrag_mo_anf_vk_btto_qual_bme
)
(SELECT
    mandant_id,
    wup_id,
    wg_id,
    dat,
    relevant_fg,
    bezugsweg_id,
    arthiertyp_id,
    wrg_id,
    abt_id,
    gj,
    kjmo,
    kjwo,
    nb_id,
    anz_artikel_bestand,
    anz_artikel_fehlmengen,
    anz_artikel_nullbestand,
    anz_artikel_minusbestand,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    betrag_vk_netto_frei_bme,
    betrag_vk_netto_qual_bme,
    betrag_vk_brutto_frei_bme,
    betrag_vk_brutto_qual_bme,
    betrag_mo_anf_vk_ntto_frei_bme,
    betrag_mo_anf_vk_ntto_qual_bme,
    betrag_mo_anf_vk_btto_frei_bme,
    betrag_mo_anf_vk_btto_qual_bme
FROM dbp_etl.vis_tag_bestand_wg_delta_2);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T1_2' does not exist or not authorized.


UPDATE dbp_msi_data.vis_tag_bestand_wg_2 AS T1_2 SET
    betrag_d_vmo_vk_ntto_frei_bme = tmp.d_betrag_vk_netto_frei_bme,
    betrag_d_vmo_vk_ntto_qual_bme = tmp.d_betrag_vk_netto_qual_bme,
    betrag_d_vmo_vk_btto_frei_bme = tmp.d_betrag_vk_brutto_frei_bme,
    betrag_d_vmo_vk_btto_qual_bme = tmp.d_betrag_vk_brutto_qual_bme FROM (SELECT
    mandant_id,
    wup_id,
    wg_id,
    abt_id,
    dat,
    kjmo,
    arthiertyp_id,
    nb_id,
    relevant_fg,
    bezugsweg_id,
    wrg_id,
    (SUM(betrag_vk_netto_frei_bme) OVER (PARTITION BY
        mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg,
        bezugsweg_id, kjmo, wrg_id
    ORDER BY dat IS NULL, dat
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
    EXTRACT(DAY FROM dat) AS d_betrag_vk_netto_frei_bme,
    (SUM(betrag_vk_netto_qual_bme) OVER (PARTITION BY
        mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg,
        bezugsweg_id, kjmo, wrg_id
    ORDER BY dat IS NULL, dat
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
    EXTRACT(DAY FROM dat) AS d_betrag_vk_netto_qual_bme,
    (SUM(betrag_vk_brutto_frei_bme) OVER (PARTITION BY
        mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg,
        bezugsweg_id, kjmo, wrg_id
    ORDER BY dat IS NULL, dat
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
    EXTRACT(DAY FROM dat) AS d_betrag_vk_brutto_frei_bme,
    (SUM(betrag_vk_brutto_qual_bme) OVER (PARTITION BY
        mandant_id, wup_id, nb_id, wg_id, abt_id, relevant_fg,
        bezugsweg_id, kjmo, wrg_id
    ORDER BY dat IS NULL, dat
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) /
    EXTRACT(DAY FROM dat) AS d_betrag_vk_brutto_qual_bme
FROM dbp_msi_data.vis_tag_bestand_wg_2
WHERE kjmo IN (
    SELECT kjmo
    FROM dbp_etl.vis_tag_bestand_tag_lkp_2
)) AS tmp
WHERE
    T1.mandant_id = tmp.mandant_id AND T1.wup_id = tmp.wup_id AND T1.wg_id = tmp.wg_id AND T1.abt_id = tmp.abt_id AND
    T1.dat = tmp.dat AND T1.arthiertyp_id = tmp.arthiertyp_id AND T1.nb_id = tmp.nb_id AND T1.relevant_fg = tmp.relevant_fg
    AND T1.bezugsweg_id = tmp.bezugsweg_id AND T1.wrg_id = tmp.wrg_id;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_MSI_DATA}.vis_tag_bestand_wg_2
--WHERE kjmo IN
--(SELECT kjmo
-- FROM ${DWH_COMMON_DBX_DATA}.monat_2
-- WHERE akt_mo < vis_bestand_akt_mo_von__dm
--)
--;
--
--Comment from validation checker
--error line 3 at position 1 unexpected 'SELECT'.
--( ^^^> SELECT kjmo
--translated statement


DELETE FROM dbp_msi_data.vis_tag_bestand_wg_2
WHERE kjmo IN (
    SELECT kjmo
    FROM dbp_data.monat_2
    WHERE akt_mo < ${VIS_BESTAND_AKT_MO_VON}
);
