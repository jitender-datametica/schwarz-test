--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    COALESCE(a.mandant_id, B.mandant_id) AS var,
    COALESCE(MAX(a.art_nielsen_id), 0) AS art_nielsen_id
FROM dbp_data.mandant_2 AS B
LEFT JOIN (
    SELECT *
    FROM dbp_data.art_nielsen_2
    WHERE
        dat_bis = DATE '9999-12-31'
        AND mandant_id NOT IN (1)
) AS a
    ON B.mandant_id = a.mandant_id
WHERE B.mandant_id NOT IN (1)
GROUP BY var;
