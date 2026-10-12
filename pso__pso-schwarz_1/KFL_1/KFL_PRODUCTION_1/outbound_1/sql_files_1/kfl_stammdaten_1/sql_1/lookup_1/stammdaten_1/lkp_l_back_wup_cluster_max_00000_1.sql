--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    COALESCE(A.mandant_id, B.mandant_id) AS var,
    COALESCE(MAX(A.wup_cluster_id), 0) AS wup_cluster_id
FROM dbp_data.mandant_1 AS B
LEFT JOIN dbp_data.l_back_wup_cluster_1 AS A ON B.mandant_id = A.mandant_id
GROUP BY var;
