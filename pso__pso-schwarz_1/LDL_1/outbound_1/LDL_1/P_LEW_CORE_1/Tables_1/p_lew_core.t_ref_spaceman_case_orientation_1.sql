/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_case_orientation_1
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_spaceman_case_orientation_1 (
case_orientation_cd STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ausrichtung (Front End, Side End, End Front, End Side)            spaceman:tblapposition:ORIENTATION'),
case_orientation_descr STRING(100) OPTIONS(description='description of the orientation'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')
) OPTIONS(description='table contains the different orientation codes for items/cases in positions');