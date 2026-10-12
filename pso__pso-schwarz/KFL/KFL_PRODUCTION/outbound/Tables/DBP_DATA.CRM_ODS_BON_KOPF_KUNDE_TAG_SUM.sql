CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_ods_bon_kopf_kunde_tag_sum (
crm_kunde_id STRING(36) COLLATE 'und:ci' NOT NULL,
crm_loyaltyaccount_id STRING(36) COLLATE 'und:ci' NOT NULL,
kundenkarte_id STRING(255) COLLATE 'und:ci' NOT NULL,
crm_kundenkarte_art_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
dat DATE NOT NULL,
anz_bons BIGNUMERIC(38,0) NOT NULL,
ums_brutto NUMERIC(18,4) NOT NULL,
ums_netto NUMERIC(18,4) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);