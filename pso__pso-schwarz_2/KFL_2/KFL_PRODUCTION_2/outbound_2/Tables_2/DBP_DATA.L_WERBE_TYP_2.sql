CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbe_typ_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
werbe_typ_id BIGNUMERIC(38,0) NOT NULL,
wtag_id_start BIGNUMERIC(38,0),
wtag_id_ende BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);