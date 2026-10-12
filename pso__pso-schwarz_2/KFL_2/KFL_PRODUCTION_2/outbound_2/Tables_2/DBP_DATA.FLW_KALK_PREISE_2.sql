CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_preise_2 (
schnittliste_id INTEGER NOT NULL,
flw_art_id BIGNUMERIC(38,0) NOT NULL,
input_material_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
sek_schl_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
sek_schl_id INTEGER NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
menge NUMERIC(18,3) NOT NULL,
menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
menge_dme NUMERIC(18,3) NOT NULL,
dme_einh_id STRING(3) COLLATE 'und:ci' NOT NULL,
preis_kg NUMERIC(18,4) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
gesamt_wert NUMERIC(18,4) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);