CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_sec_role_acl_dash_act_1 (
dashboard_name STRING(128) COLLATE 'und:ci' NOT NULL,
dashboard_disp_name STRING(200) COLLATE 'und:ci',
dashboard_cat_id INTEGER DEFAULT 0,
dashboard_subcat_id INTEGER DEFAULT 0,
dashboard_active_fg INTEGER DEFAULT 0 NOT NULL,
load_id INTEGER NOT NULL
);