CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_stueckliste_det_2 (
stueckliste_id BIGNUMERIC(38,0) NOT NULL,
stueckliste_pos_id BIGNUMERIC(38,0) NOT NULL,
stueckliste_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
flw_art_id BIGNUMERIC(38,0) NOT NULL,
loesch_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
stueckliste_pos_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
komponentenmenge NUMERIC(18,3) NOT NULL,
kalk_rlv_fg BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
komponentenmenge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);