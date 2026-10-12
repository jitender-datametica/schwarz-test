-- AIS


INSERT INTO dbp_data.artbew_agg_wt_1 (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_data.artbew_1
    WHERE
        dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag_1
            WHERE akt_mo = -13
        ) AND (CURRENT_DATE("Europe/Berlin")
        )
        AND (
            mandant_id, wup_id, nb_id, dat) NOT IN (
            SELECT (mandant_id, wup_id, nb_id, dat)
            FROM dbp_data.artbew_agg_wt_1
        )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);


-- EK-INTEGER


UPDATE dbp_etl_process.fww_gld_zeitraum_1 SET
    akt_mo = -13
WHERE TRUE;
