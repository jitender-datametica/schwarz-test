/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_section
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_section (
spaceman_section_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key: identifies the spaceman section in the space management            SPACEMAN:TBLAPSECTION.SECTIONID'),
int_org_sid BIGNUMERIC(38,0) OPTIONS(description='surrogate key internal organisation'),
src_section_nr STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='identifier of the spaceman section in the source system            SPACEMAN:TBLAPSECTION.SECTIONID            technically sectionid is numeric, but source data type would allow alphanumeric values in the future            '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (spaceman_section_sid) NOT ENFORCED
) OPTIONS(description='logical part of the available shelf space in a store');