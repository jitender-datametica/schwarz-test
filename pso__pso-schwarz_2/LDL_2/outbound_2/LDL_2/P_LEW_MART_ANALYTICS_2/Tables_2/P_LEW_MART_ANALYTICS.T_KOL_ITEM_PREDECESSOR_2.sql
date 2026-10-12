CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_analytics.t_kol_item_predecessor_2 (
item_ian INTEGER NOT NULL,
pre_item_ian INTEGER NOT NULL,
pre_range_plan_cd STRING(20) COLLATE 'und:ci',
dwh_created DATETIME
);