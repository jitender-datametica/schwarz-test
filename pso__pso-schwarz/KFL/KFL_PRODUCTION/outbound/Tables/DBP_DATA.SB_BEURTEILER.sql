CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sb_beurteiler (
beurteiler_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
ma_id BIGNUMERIC(38,0) NOT NULL,
anz_sb_soll BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
anz_sb_rot_bis NUMERIC(9,2) DEFAULT 0 NOT NULL,
anz_sb_gelb_bis NUMERIC(9,2) DEFAULT 0 NOT NULL,
operativ_fg BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);