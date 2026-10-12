--[OK] statement is translated correctly (syntax and type checks are fine)


-- begin subquery
-- end subquery
SELECT COUNT(*)
FROM (
    SELECT matnr
    FROM dbp_etl.kmo_marm_1
    LIMIT 1
) AS t0;
