CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_feld_auspr_spr_zu (
rpm_feld_id BIGNUMERIC(38,0) NOT NULL,
rpm_feld_auspr_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
rpm_tab_id BIGNUMERIC(38,0) NOT NULL,
rpm_feld_auspr_bez STRING(50),
td_update TIMESTAMP,
td_insert TIMESTAMP
);