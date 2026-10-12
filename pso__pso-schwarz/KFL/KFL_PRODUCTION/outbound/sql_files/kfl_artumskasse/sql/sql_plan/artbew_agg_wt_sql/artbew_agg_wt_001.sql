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
            WHERE akt_mo = -1
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
