CREATE OR REPLACE TEMPORARY TABLE _dedup0 AS
SELECT *
FROM dbp_etl.marktbestand_erp_zbi_mard_1;


CREATE OR REPLACE TEMPORARY TABLE _dedup1 AS
SELECT *
FROM dbp_etl.marktbestand_erp_zbi_mard_1 AS A
WHERE
    mandant_id = 1
    AND dat <> DATE_SUB(DATE(td_insert), INTERVAL 1 DAY)
    AND CAST(td_insert AS TIME) < '06:00:00'
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, art_id, wup_id, nb_id, dat ORDER BY
        mandant_id IS NULL, mandant_id,
        art_id IS NULL, art_id, wup_id IS NULL, wup_id, nb_id IS NULL, nb_id, dat IS NULL, dat, laeda IS NULL DESC,
        laeda DESC, uzeit IS NULL DESC, uzeit DESC, td_insert IS NULL DESC, td_insert DESC, menge_lgbest_erp_frei_bme
        IS NULL, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme IS NULL, menge_lgbest_erp_qual_bme
)) = 1;


DELETE FROM `_dedup0`
WHERE (mandant_id, art_id, wup_id, nb_id, dat, td_insert) IN (SELECT
    (mandant_id, art_id, wup_id, nb_id, dat, td_insert
    )
FROM `_dedup1`);


UPDATE `_dedup1` SET
    dat = DATE_SUB(`_dedup1`.dat, INTERVAL 1 DAY)
WHERE TRUE;


INSERT INTO `_dedup0`
(
    SELECT *
    FROM `_dedup1`
);


CREATE OR REPLACE TEMPORARY TABLE _dedup AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat,
    bestand_id,
    bezugsweg_id,
    relevant_fg,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    fortschreibung_fg,
    td_insert,
    td_update,
    uzeit,
    laeda,
    abi_rec_nr,
    menge_lgbest_erp_gesp_bme,
    (select distinct update_mode from ${TEMP_TABLE}) AS update_mode
FROM `_dedup0` AS A
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, art_id, wup_id, nb_id, dat ORDER BY
        mandant_id IS NULL, mandant_id,
        art_id IS NULL, art_id, wup_id IS NULL, wup_id, nb_id IS NULL, nb_id, dat IS NULL, dat, laeda IS NULL DESC,
        laeda DESC, uzeit IS NULL DESC, uzeit DESC, td_insert IS NULL DESC, td_insert DESC, menge_lgbest_erp_frei_bme
        IS NULL, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme IS NULL, menge_lgbest_erp_qual_bme
)) = 1;


DELETE FROM dbp_data.marktbestand_erp_1
WHERE (
    mandant_id, art_id, wup_id, dat) IN (
    SELECT (mandant_id, art_id, wup_id, dat)
    FROM `_dedup`
);


INSERT INTO dbp_data.marktbestand_erp_1 (
    mandant_id, art_id, wup_id, nb_id, dat, bestand_id, bezugsweg_id,
    relevant_fg, menge_lgbest_erp_frei_bme, menge_lgbest_erp_qual_bme, menge_lgbest_erp_gesp_bme, fortschreibung_fg,
    td_update, td_insert
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat,
    bestand_id,
    bezugsweg_id,
    relevant_fg,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesp_bme,
    fortschreibung_fg,
    td_update,
    td_insert
FROM `_dedup`);


-- copied from previous version of postsql_script


CREATE OR REPLACE TABLE dbp_etl.marktbestand_erp_temp_1 AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat,
    bestand_id,
    bezugsweg_id,
    relevant_fg,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesp_bme,
    fortschreibung_fg,
    td_insert,
    td_update,
    update_mode
FROM `_dedup`;
