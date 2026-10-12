CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_mitbew_prio (
mitbew_prio_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mitbewerber Priorit\u2030t ID'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant ID'),
td_insert TIMESTAMP,
td_update TIMESTAMP
);