CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_feld_auspr_zu_2 (
rpm_feld_id BIGNUMERIC(38,0) NOT NULL,
rpm_feld_auspr_id BIGNUMERIC(38,0) NOT NULL,
rpm_tab_id BIGNUMERIC(38,0) NOT NULL,
auspr_format_bez STRING(20),
td_update TIMESTAMP,
td_insert TIMESTAMP
);