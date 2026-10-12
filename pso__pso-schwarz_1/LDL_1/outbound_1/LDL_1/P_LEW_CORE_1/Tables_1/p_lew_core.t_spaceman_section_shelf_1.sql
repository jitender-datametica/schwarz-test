/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_section_shelf_1
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_section_shelf_1 (
shelf_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key for the shelf in the configuration of a section            spaceman: tblapshelf:SHELF, SECTIONID                        '),
spaceman_section_sid BIGNUMERIC(38,0)
OPTIONS(description='surrogate key: identifies the spaceman section in the space management            spaceman: tblapshelf:SECITONID            '),
src_section_nr STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='identifier of the spaceman section in the source system            SPACEMAN:TBLAPSECTION.SECTIONID            technically sectionid is numeric, but source data type would allow alphanumeric values in the future            '),
src_shelf_nr BIGNUMERIC(38,0)
OPTIONS(description='number of the shelf in the section            spaceman: tblapshelf:SHELF'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (shelf_sid) NOT ENFORCED
) OPTIONS(description='representation of a physical shelf in the configuration of a section');