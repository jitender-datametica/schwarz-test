--==============================================================
-- Table: ausnahme_vz_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausnahme_vz_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ausnahme_vz_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2           '),
ausnahme_vz_guid STRING(32) NOT NULL OPTIONS(description='GUID im\'CHAR\' Format in Großschreibung     '),
meldungstyp_id STRING(1) OPTIONS(description='Meldungstyp: S Success, E Error, W Warning, I Info, A Abort '),
nachrichtenhandler_id STRING(21) OPTIONS(description='Nachrichtenhandler'),
arbeitsgebiet_id STRING(20) OPTIONS(description='Nachrichtenklasse      '),
z_arbeitsgebiet_id BIGNUMERIC(38,0) OPTIONS(description='Nachrichtenklasse  '),
nachrichtennummer BIGNUMERIC(38,0) OPTIONS(description='Nachrichtennummer    '),
art_id STRING(18) OPTIONS(description='Artikelnummer       '),
nachrichtenquelle_id STRING(1) OPTIONS(description='Nachrichtenquelle'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Betrieb'),
nb_id BIGNUMERIC(38,0) DEFAULT - 111 OPTIONS(description='Nebenbetrieb'),
gp_id BIGNUMERIC(38,0) OPTIONS(description='Kontonummer des Lieferanten bzw. Kreditors'),
gp_teilsortiment_id STRING(10) OPTIONS(description='Lieferantenteilsortiment       '),
fremd_lagerort_id STRING(4) OPTIONS(description='Vorschlagslagerort für Fremdbeschaffung'),
best_beleg_id INTEGER OPTIONS(description='Belegnummer des Einkaufsbelegs'),
nachrichtenstatus_id STRING(1) OPTIONS(description='Message Status_2'),
dat_plan DATE OPTIONS(description='Planungsdatum       '),
nachrichtenklasse_id STRING(1) OPTIONS(description='Klassifizierung der Nachricht      '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ausnahme_vz_guid) NOT ENFORCED
) OPTIONS(description='Ausnahmen (VZ) = DC-Level Exceptions (e. g. Product stock < reach threshold etc.)');