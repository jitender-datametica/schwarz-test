CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_zeitfenster_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
zeitfenster_id BIGNUMERIC(38,0) NOT NULL,
zeit_von TIME NOT NULL,
zeit_bis TIME NOT NULL,
report_zeit_von TIME NOT NULL,
report_zeit_bis TIME NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);