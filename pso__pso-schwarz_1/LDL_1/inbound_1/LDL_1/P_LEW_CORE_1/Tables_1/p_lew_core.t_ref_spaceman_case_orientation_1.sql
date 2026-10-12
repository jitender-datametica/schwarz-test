/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_case_orientation_1
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_REF_SPACEMAN_CASE_ORIENTATION_1 (
   case_orientation_cd                 VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Ausrichtung (Front End, Side End, End Front, End Side)
            spaceman:tblapposition:ORIENTATION',
   case_orientation_descr              VARCHAR(100)    COMMENT 'description of the orientation',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_REF_SPACEMAN_CASE_ORIENTATION PRIMARY KEY (case_orientation_cd)
       NOT enforced
)
COMMENT = 'table contains the different orientation codes for items/cases in positions';