CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_aktion_wme_ame_status_einholung_markt (
mandant_id BIGNUMERIC(38,0) NOT NULL,
status_einholung_markt_kz STRING(1) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);