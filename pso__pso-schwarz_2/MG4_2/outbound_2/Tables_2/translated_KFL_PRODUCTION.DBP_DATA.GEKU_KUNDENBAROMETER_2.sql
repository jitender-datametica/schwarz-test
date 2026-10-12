CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_kundenbarometer_2 (
geku_ticket_id_kundenbarometer INTEGER NOT NULL OPTIONS(description='Eindeutiger Schlüssel'),
wup_id INTEGER NOT NULL OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id INTEGER NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
mandant_id_wup INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum aus Eingangsdatum'),
note_auswahl INTEGER OPTIONS(description='Ganzzahlige Note für die Auswahl'),
note_frische INTEGER OPTIONS(description='Ganzzahlige Note für die Frische'),
note_qualitaet INTEGER OPTIONS(description='Ganzzahlige Note für die Qualität'),
note_beratung INTEGER OPTIONS(description='Ganzzahlige Note für die Beratung'),
note_freundlichkeit_allg INTEGER OPTIONS(description='Ganzzahlige Note für die Freundlichkeit allgemein'),
note_freundlichkeit_theke INTEGER OPTIONS(description='Ganzzahlige Note für die Freundlichkeit an der Theke'),
note_freundlichkeit_kasse INTEGER OPTIONS(description='Ganzzahlige Note für die Freundlichkeit an der Kasse'),
note_schnelligkeit_kasse INTEGER OPTIONS(description='Ganzzahlige Note für die Schnelligkeit an der Kasse'),
note_schnelligkeit_theke INTEGER OPTIONS(description='Ganzzahlige Note für die Schnelligkeit an der Theke'),
note_preis INTEGER OPTIONS(description='Ganzzahlige Note für den Preis'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_ticket_id_kundenbarometer) NOT ENFORCED
) OPTIONS(description='GEKU - Marktbenotungen aus einem Oracle-System');