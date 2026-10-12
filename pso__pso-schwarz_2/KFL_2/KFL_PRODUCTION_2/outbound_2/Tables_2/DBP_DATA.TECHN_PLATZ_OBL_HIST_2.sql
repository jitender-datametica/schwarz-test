CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.techn_platz_obl_hist_2 (
techn_platz_id STRING(30) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
tech_platz_bez STRING(40) COLLATE 'und:ci',
tp_vl_name STRING(40) COLLATE 'und:ci',
tp_vkl_name STRING(40) COLLATE 'und:ci',
tp_ol_vermietung STRING(40) COLLATE 'und:ci',
tp_bl_kbl_name STRING(40) COLLATE 'und:ci',
tp_betreuer_kbl_name STRING(40) COLLATE 'und:ci',
tp_bl_projekt_name STRING(40) COLLATE 'und:ci',
tp_pl_kbl STRING(40) COLLATE 'und:ci',
dat_extrakt DATE NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);