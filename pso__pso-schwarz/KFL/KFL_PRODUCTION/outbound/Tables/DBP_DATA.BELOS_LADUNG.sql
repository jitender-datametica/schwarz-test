--==============================================================
-- Table: belos_ladung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_ladung
   generated from Powerdesigner on Dienstag, 22. März 2022 09:54:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_ladung (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
belos_ladung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel für die Ladung eines Belos Vorgangs.'),
spedition_hub_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID eines Speditions-Hubs. Wird im DWH generiert'),
gewicht_gesamt NUMERIC(18,3) NOT NULL OPTIONS(description='Gesamtgewicht der Ladung'),
anzahl_auftrag BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl der Auftraege fuer diese Ladung.'),
zusatz_spot STRING(500) OPTIONS(description='Zusatzfeld für Spotaufträge (Umnutzung des Felds FAHRER in der SST)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, belos_ladung_id) NOT ENFORCED
)
OPTIONS(description='LIS - Die Tabelle belos_ladung enthaelt die Informationen zu den Ladungen die im Rahmen der Transportauftraege angelegt werden.');