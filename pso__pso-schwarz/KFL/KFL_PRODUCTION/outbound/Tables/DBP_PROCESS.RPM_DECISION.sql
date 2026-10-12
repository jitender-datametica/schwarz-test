CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.rpm_decision (
rpm_element_id STRING(32) NOT NULL,
rpm_phase_id STRING(20) NOT NULL,
rpm_status_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);