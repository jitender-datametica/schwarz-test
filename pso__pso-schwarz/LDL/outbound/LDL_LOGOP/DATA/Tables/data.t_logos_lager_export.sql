/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logos_lager_export
Description		|	Logos table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_logos_lager_export (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
datum DATE NOT NULL OPTIONS(description='Extraction date'),
lagerort STRING(200) OPTIONS(description='Warehouse abbreviation'),
lagerplatz STRING(200) OPTIONS(description='Location'),
zonencode STRING(200) OPTIONS(description='Zonecode'),
status STRING(200) OPTIONS(description='Status B (proven) | F (free) | X (blocked) | V blocked by virtual location'),
lp_zusammengefasst STRING(200) OPTIONS(description='Locations summarized'),
maximale_kapazitaet_eh3 BIGNUMERIC(38,5) OPTIONS(description='Maximum capacity EH3'),
eh3_genutzt BIGNUMERIC(38,5) OPTIONS(description='EH3 used'),
anzahl_buchungen BIGNUMERIC(38,5) OPTIONS(description='Number of bookings'),
artikel_nr STRING(200) OPTIONS(description='Article no.'),
auslieferbarkeit STRING(300) OPTIONS(description='Deliverability'),
datenfeld_7 STRING(200) OPTIONS(description='Customs status (Zoll)'),
datenfeld_8 STRING(200) OPTIONS(description='Customs number (Zollnummer)'),
datenfeld_9 STRING(200) OPTIONS(description='Datenfeld 9 - no description'),
datenfeld_10 STRING(200) OPTIONS(description='Customs number 2 (Zollnummer 2)'),
datenfeld_1 STRING(200)
OPTIONS(description='Data field 1 is the E-number or delivery number. This consists of a combination of numbers and letters, but can also consist of only numbers'),
warengruppe BIGNUMERIC(38,2)
OPTIONS(description='The product group consists of numbers in any case, but can also be separated by a dot.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, datum) NOT ENFORCED
) OPTIONS(description='Logos - LAGERAUSLASTUNG - Shows us how much space is left in the warehouse to store new goods');