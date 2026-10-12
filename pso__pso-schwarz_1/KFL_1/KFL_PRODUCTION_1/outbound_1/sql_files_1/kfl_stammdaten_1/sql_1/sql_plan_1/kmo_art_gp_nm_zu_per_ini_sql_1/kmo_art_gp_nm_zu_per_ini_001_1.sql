DROP TABLE IF EXISTS dbp_etl.art_gp_nm_zu_per_dat_relevant_1;


CREATE TABLE IF NOT EXISTS dbp_etl.art_gp_nm_zu_per_dat_relevant_1 (
    dat_relevant DATE NOT NULL,
    dat_ausstieg DATE NOT NULL
);


DELETE FROM dbp_etl_process.metadata_kmo_bq_findung_1
WHERE ende IS NULL;


INSERT INTO dbp_etl.art_gp_nm_zu_per_dat_relevant_1 (dat_relevant, dat_ausstieg)
(SELECT
    MIN(dat) AS dat_relevant,
    MAX(dat) AS dat_ausstieg
FROM dbp_data.tag_1
WHERE dat BETWEEN (
    SELECT DATE_ADD(MAX(snapshot_datum), INTERVAL 1 DAY)
    FROM dbp_etl_process.metadata_kmo_bq_findung_1
) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
));
