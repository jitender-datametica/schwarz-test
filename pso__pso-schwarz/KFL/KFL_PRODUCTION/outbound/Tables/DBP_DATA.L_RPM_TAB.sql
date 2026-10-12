CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_rpm_tab (
rpm_tab_id BIGNUMERIC(38,0) NOT NULL,
rpm_tab_bez STRING(20) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);