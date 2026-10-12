--==============================================================
-- Table: ts_lagerort_ewm_dat_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_lagerort_ewm_dat_1
   generated from Powerdesigner on Wednesday, June 8, 2022 11:12:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dieses Feld referenziert die DWH Tabelle Lagerort.'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - hoechste Ebene der Lagerhierarchie.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID, wird verwendet fuer Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4. Stelle der Marktnummer, die Nebenbetriebskennziffer.'),
dat DATE NOT NULL OPTIONS(description='Datum des EWM-GoLive.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
)
OPTIONS(description='EWM-GoLive Date per Lagerort (starting with this date, data should be excluded from LIS reporting).');