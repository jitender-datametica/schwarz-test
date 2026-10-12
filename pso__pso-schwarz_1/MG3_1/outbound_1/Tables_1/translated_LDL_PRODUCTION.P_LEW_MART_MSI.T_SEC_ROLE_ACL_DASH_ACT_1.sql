CREATE OR REPLACE TABLE p_lew_mart_msi.t_sec_role_acl_dash_act_1 (
dashboard_name STRING(128) COLLATE 'und:ci' NOT NULL,
dashboard_disp_name STRING(200) COLLATE 'und:ci',
dashboard_cat_id BIGNUMERIC(38,0) DEFAULT 0,
dashboard_subcat_id BIGNUMERIC(38,0) DEFAULT 0,
dashboard_active_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);