--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    nielsen_market_cluster_id,
    nielsen_market_id,
    nielsen_market_tag
FROM dbp_data.nielsen_market_1
WHERE mandant_id NOT IN (1);
