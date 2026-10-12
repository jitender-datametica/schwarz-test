--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    aktion_id,
    dat_von
FROM dbp_data.aktion_1
ORDER BY
    mandant_id NULLS LAST,
    aktion_id NULLS LAST,
    dat_von NULLS LAST;
