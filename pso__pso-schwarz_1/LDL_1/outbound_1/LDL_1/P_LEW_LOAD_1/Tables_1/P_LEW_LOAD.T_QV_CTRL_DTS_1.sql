CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_qv_ctrl_dts_1 (
sap_cluster_cd STRING(100) NOT NULL,
dat_calendar DATE NOT NULL,
history_reference_cd STRING(10) NOT NULL,
dwh_load_id BIGNUMERIC NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) OPTIONS(description='QuickView load table : Control dates');