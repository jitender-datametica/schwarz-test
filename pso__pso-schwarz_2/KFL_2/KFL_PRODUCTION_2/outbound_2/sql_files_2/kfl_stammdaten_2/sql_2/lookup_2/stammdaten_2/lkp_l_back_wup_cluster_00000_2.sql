--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    wup_cluster_id,
    TRIM(wup_cluster_bez) AS wup_cluster_bez
FROM dbp_data.l_back_wup_cluster_2;
