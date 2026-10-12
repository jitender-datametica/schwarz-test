CREATE TABLE IF NOT EXISTS kfl_production_dbp_dialog.d_gruppe (
gruppe_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
gruppe_bez STRING(80) COLLATE 'und:ci',
loesch_fg BIGNUMERIC(38,0)
);