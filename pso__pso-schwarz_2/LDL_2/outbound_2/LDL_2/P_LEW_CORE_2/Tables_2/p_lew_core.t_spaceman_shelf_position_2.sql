/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_shelf_position_2
   generated from Powerdesigner on Freitag, 21. Oktober 2022 22:30:16
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_shelf_position_2 (
shelf_position_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key:position of an item_2 on a shelf in the section configuration            spaceman: tblapposition;POSITION, SECTIONID, SHELF            '),
shelf_sid BIGNUMERIC(38,0)
OPTIONS(description='surrogate key for the shelf in the configuration of a section            spaceman: tblapposition:SECTIONID, SHELF'),
src_section_nr STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='identifier of the spaceman section in the source system            SPACEMAN:TBLAPSECTION.SECTIONID            technically sectionid is numeric, but source data type would allow alphanumeric values in the future            '),
src_shelf_nr BIGNUMERIC(38,0)
OPTIONS(description='number of the shelf in the section            spaceman: tblapshelf:SHELF'),
src_position_nr BIGNUMERIC(38,0)
OPTIONS(description='logical position of an item_2 on a shelf            spaceman: tblapposition;POSITION'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (shelf_position_sid) NOT ENFORCED
)
OPTIONS(description='representation of the place which is reserved for a certian item_2 in the configuration of a certian section');