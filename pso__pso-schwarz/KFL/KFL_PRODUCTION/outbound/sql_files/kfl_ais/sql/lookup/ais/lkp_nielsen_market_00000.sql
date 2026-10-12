SELECT
    mandant_id,
    nielsen_market_cluster_id,
    nielsen_market_id,
    SUBSTR(nielsen_market_tag, -40, 40) AS nielsen_market_tag
FROM dbp_data.nielsen_market
WHERE mandant_id IN (1);
