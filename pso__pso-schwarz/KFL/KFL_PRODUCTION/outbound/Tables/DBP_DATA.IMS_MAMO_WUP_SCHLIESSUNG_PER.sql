--==============================================================
-- Table: ims_mamo_wup_schliessung_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_mamo_wup_schliessung_per
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_mamo_wup_schliessung_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_schliessung_von DATE NOT NULL
OPTIONS(description='Datum von dem ab der Markt für die Marktmodernisierungsmaßnahme geschlossen ist (können mehrere Schließungen pro Massnahme sein - mehrere Einträge in Tabelle)'),
dat_schliessung_bis DATE
OPTIONS(description='Datum bis zu dem der Markt für die Marktmodernisierungsmaßnahme geschlossen ist (können mehrere Schließungen pro Massnahme sein - mehrere Einträge in Tabelle)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, dat_schliessung_von) NOT ENFORCED
)
OPTIONS(description='IMS - Schließungen (Verkaufsunterbrechungen) aufgrund von Marktmodernisierungsmassnahmen (Modernisierung oder Facelift) - manueller Upload via Sharepoint');