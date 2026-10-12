--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    COALESCE(A.mandant_id, B.mandant_id) AS var,
    COALESCE(MAX(A.wug_cluster_id), 0) AS wug_cluster_id
FROM dbp_data.mandant AS B
LEFT JOIN dbp_data.l_back_wug_cluster AS A ON B.mandant_id = A.mandant_id
GROUP BY var;
