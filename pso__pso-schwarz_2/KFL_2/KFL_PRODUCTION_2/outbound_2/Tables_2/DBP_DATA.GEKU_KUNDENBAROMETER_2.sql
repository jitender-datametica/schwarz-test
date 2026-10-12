--==============================================================
-- Table: geku_kundenbarometer_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_kundenbarometer_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_kundenbarometer_2 (
geku_ticket_id_kundenbarometer INTEGER NOT NULL OPTIONS(description='Eindeutiger Schlüssel'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id_wup BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum aus Eingangsdatum'),
note_auswahl BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für die Auswahl'),
note_frische BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für die Frische'),
note_qualitaet BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für die Qualität'),
note_beratung BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für die Beratung'),
note_freundlichkeit_allg BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für die Freundlichkeit allgemein'),
note_freundlichkeit_theke BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für die Freundlichkeit an der Theke'),
note_freundlichkeit_kasse BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für die Freundlichkeit an der Kasse'),
note_schnelligkeit_kasse BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für die Schnelligkeit an der Kasse'),
note_schnelligkeit_theke BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für die Schnelligkeit an der Theke'),
note_preis BIGNUMERIC(38,0) OPTIONS(description='Ganzzahlige Note für den Preis'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_ticket_id_kundenbarometer) NOT ENFORCED
) OPTIONS(description='GEKU - Marktbenotungen aus einem Oracle-System');