--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.l_kjmo_sort_1 (mandant_id, kjmo, kjwo_update)
(
    SELECT
        mandant_id,
        kjmo,
        kjwo_update
    FROM dbp_data.sortiment_leistung_1
    WHERE (
        mandant_id, kjmo, kjwo_update) NOT IN (
        SELECT (mandant_id, kjmo, kjwo_update)
        FROM dbp_data.l_kjmo_sort_1
    )
    GROUP BY
        mandant_id,
        kjmo,
        kjwo_update
);
