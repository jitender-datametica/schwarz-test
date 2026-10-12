CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_geku_team_1 (
geku_team_id INTEGER NOT NULL,
geku_team_name STRING(60) COLLATE 'und:ci',
geku_teamleiter_id INTEGER,
geku_team_typ_uid INTEGER,
geku_vorgesetzter_id INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
);