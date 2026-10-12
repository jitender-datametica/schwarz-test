CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.load_log_recipient_2 (
recipient_mail STRING(50) COLLATE 'und:ci',
recipient_grp_id BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);