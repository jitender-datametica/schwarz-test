CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_art_col (
mandant_id BIGNUMERIC(38,0) NOT NULL,
flw_art_col_id BIGNUMERIC(38,0) NOT NULL,
art_col_auspr STRING(5) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);