CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_schnittliste_mat_kosten (
schnittliste_id INTEGER NOT NULL,
flw_art_id BIGNUMERIC(38,0) NOT NULL,
input_material_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
kosten_block_id STRING(3) COLLATE 'und:ci' NOT NULL,
sek_schl_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
sek_schl_id INTEGER NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
intern_var_kosten NUMERIC(18,6) DEFAULT 0 NOT NULL,
betrag_intern_var_kosten NUMERIC(18,4) DEFAULT 0 NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
system_id BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id;