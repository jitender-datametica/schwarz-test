--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.l_preis_aenderung_2 (mandant_id, preis_aend_grund_id)
(SELECT
    mandant_id,
    0 AS preis_aend_grund_id
FROM (
    SELECT mandant_id
    FROM dbp_data.l_preis_aenderung_2
    GROUP BY mandant_id
) AS dt
WHERE (
    mandant_id, 0) NOT IN (
    SELECT (mandant_id, preis_aend_grund_id)
    FROM dbp_data.l_preis_aenderung_2
    WHERE preis_aend_grund_id = 0
));
