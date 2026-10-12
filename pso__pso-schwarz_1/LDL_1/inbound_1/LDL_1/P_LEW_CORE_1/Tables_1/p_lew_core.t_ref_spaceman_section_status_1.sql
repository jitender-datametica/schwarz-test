/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_section_status_1
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_REF_SPACEMAN_SECTION_STATUS_1 (
   section_status_cd                   VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'code for the section status_1 (WIP=work in progress,REL=released,ARC=archived,UNK=unknown)',
   section_status_name                 VARCHAR(100)    COMMENT 'name of the section status_1
            spaceman: tblapsection.PLOTDESC1
            ',
   section_status_descr                VARCHAR(100)    COMMENT 'description of the section status_1',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_REF_SPACEMAN_SECTION_STATUS PRIMARY KEY (section_status_cd)
       NOT ENFORCED
)
COMMENT = 'table contains the different statuus for sections in the section lifecycle';