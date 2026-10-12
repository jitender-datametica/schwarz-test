CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.sort_soll_listung (
mandant_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
sm_id BIGNUMERIC(38,0),
anzahl BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY art_id;