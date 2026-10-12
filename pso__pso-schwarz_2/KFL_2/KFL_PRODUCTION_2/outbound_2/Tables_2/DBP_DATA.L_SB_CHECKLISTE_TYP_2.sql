CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_sb_checkliste_typ_2 (
sb_checkliste_typ_id BIGNUMERIC(38,0) NOT NULL,
sb_checkliste_typ_bez STRING(60) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);