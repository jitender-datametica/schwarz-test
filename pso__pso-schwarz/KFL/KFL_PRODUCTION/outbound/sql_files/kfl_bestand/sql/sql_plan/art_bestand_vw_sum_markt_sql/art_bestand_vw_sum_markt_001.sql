--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.art_bestand_vw_sum_tmp (
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
    menge_abgang_bme NUMERIC(29, 3)
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_etl.marktbestand_erp_tmp SET
    vw_id = t1.`_vw_id` FROM (SELECT
    mandant_id AS `_mandant_id`,
    wup_id AS `_wup_id`,
    vw_id AS `_vw_id`
FROM dbp_data.wup) AS t1
WHERE marktbestand_erp_tmp.mandant_id = t1.`_mandant_id` AND marktbestand_erp_tmp.wup_id = t1.`_wup_id`;


--[OK] statement is translated correctly-----------------------------------------------------------------


INSERT INTO dbp_etl.art_bestand_vw_sum_tmp (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
    art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme, betrag_vk_netto_qual_bme
)
(
    SELECT
        mandant_id,
        vw_id,
        bezugsweg_id,
        0 AS lagerbestand_fg,
        -1 AS `_nb_id`,
        art_id,
        -1 AS `_wup_id`,
        DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) AS dat,
        gp_id,
        relevant_fg,
        wrg_id,
        SUM(menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
        SUM(menge_lgbest_erp_frei_bme + menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_gesamt_bme,
        SUM(menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
        ROUND(CAST(SUM(CAST(vk_netto * menge_lgbest_erp_frei_bme AS FLOAT64)) AS NUMERIC), 4) AS betrag_vk_netto_frei_bme,
        ROUND(
            CAST(SUM(CAST(vk_netto * (menge_lgbest_erp_frei_bme + menge_lgbest_erp_qual_bme) AS FLOAT64)) AS NUMERIC), 4) AS
        betrag_vk_netto_gesamt_bme,
        ROUND(CAST(SUM(CAST(vk_netto * menge_lgbest_erp_qual_bme AS FLOAT64)) AS NUMERIC), 4) AS betrag_vk_netto_qual_bme
    FROM dbp_etl.marktbestand_erp_tmp
    WHERE
        vw_id IS NOT NULL
        AND mandant_id NOT IN (1)
    GROUP BY
        mandant_id,
        vw_id,
        bezugsweg_id,
        lagerbestand_fg,
        `_nb_id`,
        art_id,
        `_wup_id`,
        dat,
        gp_id,
        relevant_fg,
        wrg_id
);


--[OK] statement is translated correctly-----------------------------------------------------------------


UPDATE dbp_etl.marktbestand_erp_tmp SET
    gp_id = t1.`_gp_id` FROM (
    SELECT DISTINCT
        AG.mandant_id AS `_mandant_id`,
        AG.art_id AS `_art_id`,
        AG.gp_id AS `_gp_id`
    FROM dbp_data.art_gp_zu_per AS AG
    INNER JOIN (
        SELECT
            gp_id,
            einkaufsorganisation_id
        FROM dbp_data.gp
        WHERE mandant_id = 1 -- GROUP BY gp_id

        QUALIFY
            (ROW_NUMBER() OVER (PARTITION BY gp_id ORDER BY einkaufsorganisation_id IS NULL, einkaufsorganisation_id)) =
            1
    ) AS t1 ON AG.gp_id = t1.gp_id AND AG.einkaufsorganisation_id = t1.einkaufsorganisation_id
    WHERE
        DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) BETWEEN AG.dat_von AND AG.dat_bis
        AND AG.mandant_id = 1
) AS t1
WHERE
    marktbestand_erp_tmp.mandant_id = t1.`_mandant_id` AND marktbestand_erp_tmp.art_id = t1.`_art_id` AND
    marktbestand_erp_tmp.mandant_id = 1;


--[OK] statement is translated correctly-----------------------------------------------------------------


INSERT INTO dbp_etl.art_bestand_vw_sum_tmp (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id,
    art_id, wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_gesamt_bme,
    menge_lgbest_erp_qual_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_gesamt_bme, betrag_vk_netto_qual_bme
)
(
    SELECT
        mandant_id,
        COALESCE(vw_id, 6) AS vw_id,
        bezugsweg_id,
        0 AS lagerbestand_fg,
        CASE
            WHEN vz_wup_id = -1
                THEN -1
            ELSE -111
        END AS `_nb_id`,
        art_id,
        vz_wup_id,
        DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY) AS dat,
        gp_id,
        relevant_fg,
        wrg_id,
        SUM(menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
        SUM(menge_lgbest_erp_frei_bme + menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_gesamt_bme,
        SUM(menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
        CAST(SUM(vk_netto * menge_lgbest_erp_frei_bme) AS NUMERIC) AS betrag_vk_netto_frei_bme,
        CAST(SUM(vk_netto * (menge_lgbest_erp_frei_bme + menge_lgbest_erp_qual_bme)) AS NUMERIC) AS betrag_vk_netto_gesamt_bme
        ,
        CAST(SUM(vk_netto * menge_lgbest_erp_qual_bme) AS NUMERIC) AS betrag_vk_netto_qual_bme
    FROM dbp_etl.marktbestand_erp_tmp
    WHERE
        bezugsweg_id IN (1, 4)
        AND mandant_id = 1
    GROUP BY
        mandant_id,
        vw_id,
        bezugsweg_id,
        lagerbestand_fg,
        `_nb_id`,
        art_id,
        vz_wup_id,
        dat,
        gp_id,
        relevant_fg,
        wrg_id
);


CREATE OR REPLACE TABLE dbp_etl.art_bestand_vw_sum_tmp2 AS
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
    SUM(menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
    SUM(menge_lgbest_erp_gesamt_bme) AS menge_lgbest_erp_gesamt_bme,
    SUM(menge_lgbest_erp_qual_bme) AS menge_lgbest_erp_qual_bme,
    SUM(betrag_vk_netto_frei_bme) AS betrag_vk_netto_frei_bme,
    SUM(betrag_vk_netto_gesamt_bme) AS betrag_vk_netto_gesamt_bme,
    SUM(betrag_vk_netto_qual_bme) AS betrag_vk_netto_qual_bme,
    SUM(menge_abgang_bme) AS menge_abgang_bme
FROM dbp_etl.art_bestand_vw_sum_tmp
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
    wrg_id;


UPDATE dbp_etl.art_bestand_vw_sum_tmp2 SET
    menge_abgang_bme = art_bestand_vw_sum.menge_abgang_bme
FROM dbp_data.art_bestand_vw_sum
WHERE
    art_bestand_vw_sum.mandant_id = art_bestand_vw_sum_tmp2.mandant_id AND art_bestand_vw_sum.vw_id =
    art_bestand_vw_sum_tmp2.vw_id AND art_bestand_vw_sum.bezugsweg_id = art_bestand_vw_sum_tmp2.bezugsweg_id AND
    art_bestand_vw_sum.lagerbestand_fg = art_bestand_vw_sum_tmp2.lagerbestand_fg AND art_bestand_vw_sum.nb_id =
    art_bestand_vw_sum_tmp2.nb_id AND art_bestand_vw_sum.art_id = art_bestand_vw_sum_tmp2.art_id AND
    art_bestand_vw_sum.wup_id = art_bestand_vw_sum_tmp2.wup_id AND art_bestand_vw_sum.dat = art_bestand_vw_sum_tmp2.dat
    AND art_bestand_vw_sum.gp_id = art_bestand_vw_sum_tmp2.gp_id AND art_bestand_vw_sum.relevant_fg =
    art_bestand_vw_sum_tmp2.relevant_fg AND art_bestand_vw_sum.wrg_id = art_bestand_vw_sum_tmp2.wrg_id;


--[OK] statement is translated correctly-----------------------------------------------------------------


DELETE FROM dbp_data.art_bestand_vw_sum
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.art_bestand_vw_sum_tmp2
    WHERE
        art_bestand_vw_sum.mandant_id = mandant_id
        AND art_bestand_vw_sum.vw_id = vw_id
        AND art_bestand_vw_sum.bezugsweg_id = bezugsweg_id
        AND art_bestand_vw_sum.lagerbestand_fg = lagerbestand_fg
        AND art_bestand_vw_sum.nb_id = nb_id
        AND art_bestand_vw_sum.art_id = art_id
        AND art_bestand_vw_sum.wup_id = wup_id
        AND art_bestand_vw_sum.dat = dat
        AND art_bestand_vw_sum.gp_id = gp_id -- Herr Ferber 2008.09.26: Loeschen unabhaengig vom relevant_fg

        -- AND DBP_DATA.art_bestand_vw_sum.relevant_fg = DBP_ETL.art_bestand_vw_sum_tmp2.relevant_fg

        AND art_bestand_vw_sum.wrg_id = wrg_id
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_etl.art_bestand_vw_sum_tmp2
WHERE menge_lgbest_erp_frei_bme = 0 AND menge_lgbest_erp_gesamt_bme = 0 AND menge_lgbest_erp_qual_bme = 0 AND COALESCE(
    betrag_vk_netto_frei_bme,
    0
) = 0 AND COALESCE(betrag_vk_netto_gesamt_bme, 0
) = 0 AND COALESCE(betrag_vk_netto_qual_bme, 0
) = 0 AND
COALESCE(menge_abgang_bme, 0) = 0;


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.art_bestand_vw_sum (
    mandant_id, vw_id, bezugsweg_id, lagerbestand_fg, nb_id, art_id,
    wup_id, dat, gp_id, relevant_fg, wrg_id, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesamt_bme, betrag_vk_netto_frei_bme, betrag_vk_netto_qual_bme, betrag_vk_netto_gesamt_bme,
    menge_abgang_bme
)
(SELECT DISTINCT
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
FROM dbp_etl.art_bestand_vw_sum_tmp2);
