--==============================================================
-- Table: flw_pruefmerkmal_vorgabe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_pruefmerkmal_vorgabe_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_pruefmerkmal_vorgabe_1 (
prueflos_id INTEGER NOT NULL OPTIONS(description='Eindeutige Prüflosnummer aus prueflos'),
merkmal_lfd_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Prüfmerkmalsnummer aus merknr'),
knoten_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Knotenummer aus Auftragszähler APLZL aus vorglfnr. Aussage über den Arbeitsplatz: 1= Wareneingang, 2 = Labor'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
stp_merkmal_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Stammprüfmerkmal aus verwmerkm. Entspricht mkmnr aus Tabelle qpmk'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
katalogart_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Katalogart aus katalgart1'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (prueflos_id, merkmal_lfd_nr, knoten_lfd_nr, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Prüfmerkmal-Vorgaben aus qamv');