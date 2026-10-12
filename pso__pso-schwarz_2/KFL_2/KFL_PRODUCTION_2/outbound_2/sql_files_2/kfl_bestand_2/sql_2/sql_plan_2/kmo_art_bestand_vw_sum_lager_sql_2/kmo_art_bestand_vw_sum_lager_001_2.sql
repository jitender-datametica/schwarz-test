CREATE OR REPLACE TABLE dbp_etl.lagerbest_erp_per_tag_kmo_tmp_2 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesamt_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    dat DATE NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.lagerbest_erp_per_tag_kmo_tmp2_2 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesamt_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    dat DATE NOT NULL,
    vw_id INTEGER,
    gp_id INTEGER,
    vk_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.art_bestand_vw_sum_kmo_tmp_2 (
    mandant_id INTEGER NOT NULL,
    vw_id INTEGER NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    lagerbestand_fg INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    gp_id INTEGER NOT NULL,
    relevant_fg INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_gesamt_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    betrag_vk_netto_frei_bme NUMERIC(29, 4),
    betrag_vk_netto_gesamt_bme NUMERIC(29, 4),
    betrag_vk_netto_qual_bme NUMERIC(29, 4),
    menge_abgang_bme NUMERIC(29, 3),
    betrag_vk_netto_abgang NUMERIC(29, 4)
);


CREATE OR REPLACE TABLE dbp_etl.lager_process_tag_kmo_2 (
    mandant_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    verarbeitet_fg INTEGER
);


INSERT INTO dbp_etl.lager_process_tag_kmo_2 (mandant_id, dat, verarbeitet_fg)
(
    SELECT
        mandant_id,
        dat,
        1 AS verarbeitet_fg
    FROM dbp_data.art_bestand_vw_sum_2
    WHERE
        lagerbestand_fg = 1
        AND mandant_id IN (${MIDKMO})
    GROUP BY
        mandant_id,
        dat,
        verarbeitet_fg
);


INSERT INTO dbp_etl.lagerbest_erp_per_tag_kmo_tmp_2 (
    wup_id, mandant_id, nb_id, art_id,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme, menge_lgbest_erp_qual_bme, wrg_id, dat
)
(
    SELECT
        wup_id,
        mandant_id,
        nb_id,
        art_id,
        menge_lgbest_erp_frei_bme,
        CAST(menge_lgbest_erp_frei_bme + menge_lgbest_erp_umlag_bme + menge_lgbest_erp_qual_bme + menge_lgbest_erp_nf_charge_bme + menge_lgbest_erp_gesp_bme + menge_lgbest_erp_ret_gesp_bme AS NUMERIC)
            AS menge_lgbest_erp_gesamt_bme,
        menge_lgbest_erp_qual_bme,
        wrg_id,
        DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) AS dat
    FROM dbp_data.lagerbestand_erp_per_2 AS P
    WHERE
        mandant_id IN (${MIDKMO})
        AND nb_id IN (99, -111) -- nur echte Laeger

        AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) BETWEEN dat_von AND dat_bis
);


INSERT INTO dbp_etl.lagerbest_erp_per_tag_kmo_tmp2_2 (
    wup_id, mandant_id, nb_id, art_id,
    menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme, menge_lgbest_erp_qual_bme, wrg_id, dat, vw_id, gp_id, vk_netto
)
(
    SELECT
        TMP.wup_id,
        TMP.mandant_id,
        TMP.nb_id,
        TMP.art_id,
        TMP.menge_lgbest_erp_frei_bme,
        TMP.menge_lgbest_erp_gesamt_bme,
        TMP.menge_lgbest_erp_qual_bme,
        TMP.wrg_id,
        TMP.dat,
        W.vw_id,
        COALESCE(AGN.gp_id, -1) AS agn_gp_id,
        CAST(ap.`_vk_brutto` / COALESCE(1 + MWST.mwst / 100, 1) AS NUMERIC) AS vk_netto
    FROM dbp_etl.lagerbest_erp_per_tag_kmo_tmp_2 AS TMP
    INNER JOIN dbp_data.wup_2 AS W
        ON
            TMP.mandant_id = W.mandant_id AND TMP.wup_id = W.wup_id AND TMP.nb_id =
            W.nb_id
    INNER JOIN dbp_data.art_2 AS A ON TMP.mandant_id = A.mandant_id AND TMP.art_id = A.art_id
    LEFT JOIN dbp_data.mwst_per_2 AS MWST
        ON
            TMP.mandant_id = MWST.mandant_id AND A.mwst_id = MWST.mwst_id
            AND TMP.dat BETWEEN MWST.dat_von AND MWST.dat_bis
    -- Inhaltlich gleiche Logik wie bei lagerbestand_erp_per_2 fuer KMO (s. kmo_mard.btq)

    LEFT JOIN (SELECT
        mandant_id AS `_mandant_id`,
        art_id AS `_art_id`,
        DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) AS `_dat`,
        vk_brutto AS `_vk_brutto`
    FROM dbp_data.art_pm_vw_zu_per_2 AS APV
    WHERE
        preistyp_id = 0
        AND pm_id = 1
        AND vw_id IN (10, 90)
        AND DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) BETWEEN dat_von AND dat_bis
    QUALIFY (COUNT(*) OVER (PARTITION BY
        mandant_id, art_id, DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) ORDER BY ABS(vk_brutto
    ) IS NULL DESC, ABS(vk_brutto) DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) = 1) AS ap
        ON
            TMP.art_id
            = ap.`_art_id` AND TMP.dat = ap.`_dat` AND TMP.mandant_id = ap.`_mandant_id`
    LEFT JOIN
        dbp_data.art_gp_nm_zu_per_2
            AS AGN
        ON
            TMP.mandant_id = AGN.mandant_id AND TMP.art_id = AGN.art_id
            AND TMP.wup_id = AGN.wup_id AND TMP.nb_id = AGN.nb_id AND TMP.dat BETWEEN AGN.dat_von AND AGN.dat_bis
);


INSERT INTO dbp_etl.art_bestand_vw_sum_kmo_tmp_2 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
    art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme, betrag_vk_netto_qual_bme,
    menge_abgang_bme, betrag_vk_netto_abgang
)
(
    SELECT
        t01.mandant_id,
        t01.vw_id,
        t01.bezugsweg_id,
        t01.lagerbestand_fg,
        t01.nb_id,
        t01.art_id,
        t01.wup_id,
        t01.dat,
        t01.gp_id,
        t01.relevant_fg,
        t01.wrg_id,
        t01.menge_lgbest_erp_frei_bme,
        t01.menge_lgbest_erp_gesamt_bme,
        t01.menge_lgbest_erp_qual_bme,
        CAST(t01.betrag_vk_netto_frei_bme AS NUMERIC) AS betrag_vk_netto_frei_bme,
        CAST(t01.betrag_vk_netto_gesamt_bme AS NUMERIC) AS betrag_vk_netto_gesamt_bme,
        CAST(t01.betrag_vk_netto_qual_bme AS NUMERIC) AS betrag_vk_netto_qual_bme,
        T02.menge_abgang_bme,
        T02.betrag_vk_netto_abgang
    FROM (
        SELECT
            mandant_id,
            vw_id,
            4 AS bezugsweg_id,
            1 AS lagerbestand_fg,
            nb_id,
            art_id,
            wup_id,
            dat,
            gp_id,
            1 AS relevant_fg,
            wrg_id,
            SUM(menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
            SUM(menge_lgbest_erp_gesamt_bme) AS menge_lgbest_erp_gesamt_bme,
            SUM(menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
            SUM(vk_netto * menge_lgbest_erp_frei_bme) AS betrag_vk_netto_frei_bme,
            SUM(vk_netto * menge_lgbest_erp_gesamt_bme) AS betrag_vk_netto_gesamt_bme,
            SUM(vk_netto * menge_lgbest_erp_qual_bme) AS betrag_vk_netto_qual_bme
        FROM dbp_etl.lagerbest_erp_per_tag_kmo_tmp2_2
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
    ) AS t01
    LEFT JOIN
        dbp_data.art_bestand_vw_sum_2
            AS T02
        ON
            t01.mandant_id = T02.mandant_id AND t01.wup_id = T02.wup_id
            AND t01.nb_id = T02.nb_id AND t01.art_id = T02.art_id AND t01.dat = T02.dat AND t01.lagerbestand_fg = T02.lagerbestand_fg
            AND t01.bezugsweg_id = T02.bezugsweg_id AND t01.vw_id = T02.vw_id AND t01.gp_id = T02.gp_id AND t01.wrg_id =
            T02.wrg_id
);


DROP TABLE IF EXISTS dbp_etl.lagerbest_erp_per_tag_kmo_tmp2_2;


DELETE FROM dbp_data.art_bestand_vw_sum_2
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.art_bestand_vw_sum_kmo_tmp_2
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
        AND art_bestand_vw_sum.wrg_id = wrg_id
);


DELETE FROM dbp_etl.art_bestand_vw_sum_kmo_tmp_2
WHERE menge_lgbest_erp_frei_bme = 0 AND menge_lgbest_erp_gesamt_bme = 0 AND menge_lgbest_erp_qual_bme = 0 AND COALESCE(
    betrag_vk_netto_frei_bme,
    0
) = 0 AND COALESCE(betrag_vk_netto_gesamt_bme, 0
) = 0 AND COALESCE(betrag_vk_netto_qual_bme, 0
) = 0 AND
COALESCE(menge_abgang_bme, 0) = 0 AND COALESCE(betrag_vk_netto_abgang, 0) = 0;


INSERT INTO dbp_data.art_bestand_vw_sum_2 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id,
    wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_netto_gesamt_bme,
    menge_abgang_bme, betrag_vk_netto_abgang, td_insert, td_update
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
    COALESCE(menge_abgang_bme, 0) AS menge_abgang_bme,
    COALESCE(betrag_vk_netto_abgang, 0) AS betrag_vk_netto_abgang,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_etl.art_bestand_vw_sum_kmo_tmp_2);


INSERT INTO dbp_etl.lager_process_tag_kmo_2 (mandant_id, dat, verarbeitet_fg)
(
    SELECT
        mandant_id,
        dat,
        1 AS verarbeitet_fg
    FROM dbp_etl.art_bestand_vw_sum_kmo_tmp_2
    WHERE (
        mandant_id, dat, 1) NOT IN (
        SELECT (mandant_id, dat, verarbeitet_fg)
        FROM dbp_etl.lager_process_tag_kmo_2
    )
    GROUP BY
        mandant_id,
        dat,
        verarbeitet_fg
);


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_kmo_tmp_2;


-- noch nicht in lager_process_tag_kmo_2 Tabelle
INSERT INTO dbp_etl.lager_process_tag_kmo_2 (
    mandant_id,
    dat, verarbeitet_fg
)
(
    SELECT
        l.mandant_id,
        T.dat,
        0 AS verarbeitet_fg
    FROM dbp_data.tag_2 AS T
    INNER JOIN (SELECT
        mandant_id,
        MIN(dat) AS min_dat
    FROM dbp_etl.lager_process_tag_kmo_2
    WHERE verarbeitet_fg = 1
    GROUP BY mandant_id) AS l ON TRUE
    WHERE
        T.dat < CURRENT_DATE("Europe/Berlin") -- maximal bis zum Vortag

        AND T.dat > l.min_dat
        AND (
            l.mandant_id, T.dat) NOT IN (
            SELECT (mandant_id, dat)
            FROM dbp_etl.lager_process_tag_kmo_2
        )
);


-- Ermittlung des maximalen bereits verarbeiteten Tag_2,
-- der kleiner ist als der noch zu verarbeitende Tag.

INSERT INTO dbp_data.art_bestand_vw_sum_2 (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id,
    wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_netto_gesamt_bme, td_insert,
    td_update
)
(
    SELECT
        A.mandant_id,
        A.vw_id,
        A.bezugsweg_id,
        A.lagerbestand_fg,
        A.nb_id,
        A.art_id,
        A.wup_id,
        l.dat,
        A.gp_id,
        A.relevant_fg,
        A.wrg_id,
        A.menge_lgbest_erp_frei_bme,
        A.menge_lgbest_erp_qual_bme,
        A.menge_lgbest_erp_gesamt_bme,
        A.betrag_vk_netto_frei_bme,
        A.betrag_vk_netto_qual_bme,
        A.betrag_vk_netto_gesamt_bme,
        CURRENT_TIMESTAMP(),
        CURRENT_TIMESTAMP()
    FROM dbp_data.art_bestand_vw_sum_2 AS A
    INNER JOIN (SELECT
        t1.mandant_id,
        t1.dat,
        t1.max_verarbeitet_dat
    FROM (
        SELECT
            L.mandant_id,
            L.dat,
            V.dat AS max_verarbeitet_dat,
            V.dat AS dat0
        FROM dbp_etl.lager_process_tag_kmo_2 AS L
        INNER JOIN dbp_etl.lager_process_tag_kmo_2 AS V
            ON
                L.mandant_id = V.mandant_id AND V.verarbeitet_fg =
                1 -- bereits verarbeitet
                AND L.dat > V.dat
        WHERE L.verarbeitet_fg = 0 -- noch nicht verarbeitet

        QUALIFY (COUNT(*) OVER (
            PARTITION BY L.mandant_id, L.dat ORDER BY dat0 IS NULL DESC, dat0 DESC ROWS BETWEEN
            UNBOUNDED PRECEDING AND CURRENT ROW
        )) = 1
    ) AS t1_2) AS l ON A.dat <= l.dat AND A.mandant_id = l.mandant_id
    WHERE
        A.lagerbestand_fg = 1
        AND A.mandant_id IN (${MIDKMO})
        AND A.dat = l.max_verarbeitet_dat
);


DROP TABLE IF EXISTS dbp_etl.lager_process_tag_kmo_2;
