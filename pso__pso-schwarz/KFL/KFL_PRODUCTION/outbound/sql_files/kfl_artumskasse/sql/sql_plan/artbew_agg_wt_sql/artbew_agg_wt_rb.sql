-- AIS


INSERT INTO dbp_data.artbew_agg_wt (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_data.artbew
    WHERE
        dat BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag
            WHERE akt_mo = -13
        ) AND (CURRENT_DATE("Europe/Berlin")
        )
        AND (
            mandant_id, wup_id, nb_id, dat) NOT IN (
            SELECT (mandant_id, wup_id, nb_id, dat)
            FROM dbp_data.artbew_agg_wt
        )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);


-- EK-INTEGER


UPDATE dbp_etl_process.fww_gld_zeitraum SET
    akt_mo = -13
WHERE TRUE;
