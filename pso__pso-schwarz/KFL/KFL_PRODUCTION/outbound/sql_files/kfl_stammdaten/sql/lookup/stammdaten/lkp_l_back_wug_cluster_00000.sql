--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    wug_cluster_id,
    TRIM(wug_cluster_bez) AS wug_cluster_bez
FROM dbp_data.l_back_wug_cluster;
