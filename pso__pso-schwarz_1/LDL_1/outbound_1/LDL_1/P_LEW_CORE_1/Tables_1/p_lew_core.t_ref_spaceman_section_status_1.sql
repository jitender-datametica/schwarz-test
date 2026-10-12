/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_section_status_1
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_spaceman_section_status_1 (
section_status_cd STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='code for the section status_1 (WIP=work in progress,REL=released,ARC=archived,UNK=unknown)'),
section_status_name STRING(100)
OPTIONS(description='name of the section status_1            spaceman: tblapsection.PLOTDESC1            '),
section_status_descr STRING(100) OPTIONS(description='description of the section status_1'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')
) OPTIONS(description='table contains the different statuus for sections in the section lifecycle');