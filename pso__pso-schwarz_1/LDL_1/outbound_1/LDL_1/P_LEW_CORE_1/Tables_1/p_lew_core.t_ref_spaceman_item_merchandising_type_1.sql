/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_item_merchandising_type_1
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_spaceman_item_merchandising_type_1 (
item_merchandising_type_cd STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Merchandising Type (Case/Hand/DD/EP)            spaceman:tblapposition:MERCHANDISINGTYPE'),
item_merchandising_type_descr STRING(100) OPTIONS(description='Description of the Merchandising Type.'),
shelf_capacity_type_cd BIGNUMERIC(38,0)
OPTIONS(description='The numeric code of the shelf capacity type mapped to the merchandising type.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH.')
) OPTIONS(description='This table contains the different merchandising type codes for items/cases in positions.');