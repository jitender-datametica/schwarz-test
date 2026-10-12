CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_phase_spr_zu_1 (
rpm_phase_id STRING(20) COLLATE 'und:ci' NOT NULL,
rpm_projekt_typ_id STRING(20) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
rpm_phase_bez STRING(20) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);