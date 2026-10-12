--==============================================================
-- Table: banf_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_det
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.banf_det (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
banf_beleg_id INTEGER NOT NULL OPTIONS(description='Bestellanforderungsnummer'),
banf_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Positionsnummer der Bestellanforderung'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
banf_menge NUMERIC(18,3) NOT NULL OPTIONS(description='Bestellanforderungsmenge'),
banf_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Mengeneinheit der Bestellanforderung'),
dat_banf_beleg DATE NOT NULL OPTIONS(description='Anforderungsdatum'),
dat_lief_soll DATE NOT NULL OPTIONS(description='Lieferdatum der Position'),
dat_freigabe DATE NOT NULL OPTIONS(description='Freigabedatum der Bestellanforderung'),
banf_preis NUMERIC(18,2) NOT NULL OPTIONS(description='Preis in der Bestellanforderung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, banf_beleg_id, banf_beleg_pos_id) NOT ENFORCED
) OPTIONS(description='FLW - Bestellanforderungen - SAP RET - EBAN');