CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_hier_eb_fkt_wup_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ma_hierarchie_typ_id BIGNUMERIC(38,0) NOT NULL,
ma_hierarchie_id BIGNUMERIC(38,0) NOT NULL,
dat_von DATE NOT NULL,
ma_funktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
ma_hierarchie_ebene_id STRING(4) COLLATE 'und:ci' NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);