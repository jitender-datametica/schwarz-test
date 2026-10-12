--==============================================================
-- Table: banf_forecast_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_forecast_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.banf_forecast_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
banf_beleg_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bestellanforderungsnummer - kann alphanumerische Werte enthalten'),
banf_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Positionsnummer der Bestellanforderung'),
gp_id BIGNUMERIC(38,0) OPTIONS(description='Kontonummer des Lieferanten bzw. Kreditors'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Betriebsbezogene Kundennummer'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) OPTIONS(description='Artikelnummer'),
dat_plan DATE OPTIONS(description='Planungstag'),
dat_bestell DATE OPTIONS(description='Bestelldatum'),
forecast_menge_kolli NUMERIC(18,3) OPTIONS(description='Bestellmenge'),
forecast_menge_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Bestellmengeneinheit'),
dat_lief_soll DATE OPTIONS(description='Lieferdatum'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, banf_beleg_pos_id) NOT ENFORCED
) OPTIONS(description='FLW - Bestellanforderung Forecast (PHIT BANF Order Forecast) - SAP RET - ZPHIT_BANF_OF');