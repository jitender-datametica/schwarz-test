--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    verkaufsorganisation_id
FROM dbp_data.l_verkaufsorganisation_1
ORDER BY
    mandant_id NULLS LAST,
    verkaufsorganisation_id NULLS LAST;
