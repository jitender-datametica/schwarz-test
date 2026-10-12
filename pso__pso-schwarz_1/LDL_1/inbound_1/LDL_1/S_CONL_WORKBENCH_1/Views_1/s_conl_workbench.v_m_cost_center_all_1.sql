CREATE OR REPLACE VIEW s_conl_workbench.v_m_cost_center_all_1
AS
(SELECT
CAST(scc.cost_center AS VARCHAR(25)) as cost_center,
'Gesellschaft' as classification_1,
'Filiaal' as classification_2,
CAST (scc.wh_name as VARCHAR(31)) as classification_3,
'Filiaal' as classification_4,
CAST (scc.account_manager_name as VARCHAR(50)) as  classification_5,
/* MV*/
CAST (scc.sales_manager_name as VARCHAR(50))  as  classification_6,
/* RM*/
CAST (scc.move_fg as VARCHAR(10)) as move_fg,
CAST (scc.store_nr as VARCHAR(25)) as  orig_store_nr
FROM s_conl_workbench.v_m_cost_center_store_1 as scc
WHERE orig_store_nr not in (1,2,3,4,5,6)

UNION ALL
SELECT
cc.cost_center,
classification_1,
classification_2,
classification_3,
classification_4,
CAST (null as VARCHAR(50)) as  classification_5,
/* MV*/
CAST (null as VARCHAR(50)) as  classification_6,
/* RM*/
CAST(0 AS VARCHAR(10)) as  move_fg,
cost_center as  orig_store_nr
FROM s_conl_workbench.t_m_cost_center_warehouse_1 as cc

);


