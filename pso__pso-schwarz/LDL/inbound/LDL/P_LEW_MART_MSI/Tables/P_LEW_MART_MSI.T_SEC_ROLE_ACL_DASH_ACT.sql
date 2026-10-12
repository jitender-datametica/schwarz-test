CREATE TABLE P_LEW_MART_MSI.T_SEC_ROLE_ACL_DASH_ACT (
dashboard_name VARCHAR(128) COLLATE 'en-ci' NOT NULL,
dashboard_disp_name VARCHAR(200) COLLATE 'en-ci',
dashboard_cat_id INTEGER DEFAULT 0,
dashboard_subcat_id INTEGER DEFAULT 0,
dashboard_active_fg BYTEINT DEFAULT 0 NOT NULL,
load_id INTEGER NOT NULL,
UNIQUE ( dashboard_name)
);


