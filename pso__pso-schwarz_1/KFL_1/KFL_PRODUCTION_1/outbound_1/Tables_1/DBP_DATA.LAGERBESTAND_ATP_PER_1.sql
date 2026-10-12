--==============================================================
-- Table: lagerbestand_atp_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerbestand_atp_per_1
   generated from Powerdesigner on Dienstag, 28. November 2023 13:51:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerbestand_atp_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1           '),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb'),
art_id STRING(18) NOT NULL OPTIONS(description='Artikelnummer       '),
dat_von DATE NOT NULL OPTIONS(description='Gültig von'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL OPTIONS(description='Gültig bis'),
menge_lgbest_frei NUMERIC(13,3) OPTIONS(description='Frei verw. Bestand'),
menge_lgbest_block_werbung NUMERIC(13,3)
OPTIONS(description='Werbung Blockbestand  (for some coutries this is part or equal to WBS quantities. Depending on what is the WBS rollout status_1 in the country_1)'),
menge_lgbest_block_iwt NUMERIC(13,3) OPTIONS(description='IWT Blockbestand  '),
menge_lgbest_block_nwbs NUMERIC(13,3) OPTIONS(description='Menge Blockbestand non-WBS'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, dat_von, art_id) NOT ENFORCED
)
OPTIONS(description='Stock quantities in distribution center (DC) after availbale-to-promis check (ATP). ATP quantity is <all-items> - <reserved/blocked-items>');