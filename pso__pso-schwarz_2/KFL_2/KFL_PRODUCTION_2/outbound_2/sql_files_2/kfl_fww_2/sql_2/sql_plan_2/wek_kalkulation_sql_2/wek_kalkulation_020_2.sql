CREATE OR REPLACE TEMPORARY TABLE _tage_art_gp_nm_zu_per AS
SELECT dat
FROM dbp_data.tag_2
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_2) AND (
    SELECT MAX(dat)
    FROM dbp_etl.zeitraum_fww_kmo_gld_2
);


CREATE OR REPLACE TABLE dbp_etl.art_gp_nm_zu_per_fww_2 AS
SELECT
    a.mandant_id,
    B.dat,
    a.wup_id,
    a.nb_id,
    a.art_id,
    a.gp_id
FROM (
    SELECT *
    FROM dbp_data.art_gp_nm_zu_per_2
    WHERE dat_bis >= (
        SELECT MIN(dat)
        FROM dbp_etl.zeitraum_fww_kmo_gld_2
    )
) AS a
INNER JOIN
    `_tage_art_gp_nm_zu_per` AS B
    ON B.dat BETWEEN a.dat_von AND a.dat_bis;
