/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logos_lager_export
Description		|	Logos table
====================================================================================================
*/

CREATE TABLE DATA.t_logos_lager_export (
client_id 					NUMBER(38,0) 	NOT NULL	COMMENT 'Client id - calculated based on the country code',
datum 						DATE 			NOT NULL	COMMENT 'Extraction date',
lagerort 					VARCHAR(200) 	NULL		COMMENT 'Warehouse abbreviation',
lagerplatz 					VARCHAR(200) 	NULL		COMMENT 'Location',
zonencode 					VARCHAR(200) 	NULL		COMMENT 'Zonecode',
status 						VARCHAR(200) 	NULL		COMMENT 'Status B (proven) | F (free) | X (blocked) | V blocked by virtual location',
lp_zusammengefasst 			VARCHAR(200) 	NULL		COMMENT 'Locations summarized',
maximale_kapazitaet_eh3 	NUMBER(38,5) 	NULL		COMMENT 'Maximum capacity EH3',
eh3_genutzt 				NUMBER(38,5) 	NULL		COMMENT 'EH3 used',
anzahl_buchungen 			NUMBER(38,5) 	NULL		COMMENT 'Number of bookings',
artikel_nr 					VARCHAR(200) 	NULL		COMMENT 'Article no.',
auslieferbarkeit 			VARCHAR(300) 	NULL		COMMENT 'Deliverability',
datenfeld_7 				VARCHAR(200) 	NULL		COMMENT 'Customs status (Zoll)',
datenfeld_8 				VARCHAR(200) 	NULL		COMMENT 'Customs number (Zollnummer)',
datenfeld_9 				VARCHAR(200) 	NULL		COMMENT 'Datenfeld 9 - no description',
datenfeld_10				VARCHAR(200) 	NULL		COMMENT 'Customs number 2 (Zollnummer 2)',
datenfeld_1 				VARCHAR(200) 	NULL		COMMENT 'Data field 1 is the E-number or delivery number. This consists of a combination of numbers and letters, but can also consist of only numbers',
warengruppe					NUMBER(38,2) 	NULL		COMMENT 'The product group consists of numbers in any case, but can also be separated by a dot.',
dwh_load_id 				NUMBER(38,0) 	NOT NULL	COMMENT 'Load id',
dwh_created		 			TIMESTAMP 		NOT NULL	COMMENT 'Record created at',
dwh_updated		 			TIMESTAMP 		NOT NULL	COMMENT 'Record updated at',
PRIMARY KEY (client_id, datum)
) COMMENT = 'Logos - LAGERAUSLASTUNG - Shows us how much space is left in the warehouse to store new goods';