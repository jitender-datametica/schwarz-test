/* RM */ /* RM */ /* MV */ CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_m_cost_center_all AS SELECT CAST(cost_center AS STRING)
 AS cost_center,
 'Gesellschaft' AS classification_1,
 'Filiaal' AS classification_2,
 CAST(wh_name AS STRING) AS classification_3,
 'Filiaal' AS classification_4,
 CAST(account_manager_name AS STRING) AS classification_5,
 CAST(sales_manager_name AS STRING) AS classification_6,
 CAST(move_fg AS STRING) AS move_fg,
 CAST(store_nr AS STRING) AS orig_store_nr
FROM ldl_s_conl_workbench.v_m_cost_center_store AS SCC
WHERE CAST(store_nr AS INTEGER) NOT IN (1, 2, 3, 4, 5, 6)
UNION ALL
SELECT cost_center,
 classification_1,
 classification_2,
 classification_3,
 classification_4,
 CAST(NULL AS STRING) AS classification_5,
 CAST(NULL AS STRING) AS classification_6,
 '0' AS move_fg,
 cost_center AS orig_store_nr
FROM ldl_s_conl_workbench.t_m_cost_center_warehouse AS CC;