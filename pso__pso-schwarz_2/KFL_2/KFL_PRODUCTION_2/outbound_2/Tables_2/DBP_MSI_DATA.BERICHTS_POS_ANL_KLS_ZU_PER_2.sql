CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.berichts_pos_anl_kls_zu_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
anlage_klasse_id STRING(10) COLLATE 'und:ci' NOT NULL,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
ma_ldap STRING(10) COLLATE 'und:ci' NOT NULL,
berichts_position_invest_id BIGNUMERIC(38,0),
berichts_position_it_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);