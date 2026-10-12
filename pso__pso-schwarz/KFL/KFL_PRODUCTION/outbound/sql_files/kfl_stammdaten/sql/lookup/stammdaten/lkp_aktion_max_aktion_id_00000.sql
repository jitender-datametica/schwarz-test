--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    MAX(aktion_id) AS max_aktion_id
FROM dbp_data.aktion
GROUP BY mandant_id
ORDER BY mandant_id NULLS LAST;
