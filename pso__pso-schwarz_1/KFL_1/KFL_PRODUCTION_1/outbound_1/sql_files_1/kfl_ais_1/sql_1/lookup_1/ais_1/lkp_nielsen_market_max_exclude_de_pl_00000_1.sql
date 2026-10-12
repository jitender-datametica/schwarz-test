--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    COALESCE(a.mandant_id, B.mandant_id) AS var,
    COALESCE(MAX(a.nielsen_market_id), 0) AS nielsen_market_id
FROM dbp_data.mandant_1 AS B
LEFT JOIN (
    SELECT *
    FROM dbp_data.nielsen_market_1
    WHERE mandant_id NOT IN (1)
) AS a
    ON B.mandant_id = a.mandant_id
WHERE B.mandant_id NOT IN (1)
GROUP BY var;
