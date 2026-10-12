/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_section
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_SPACEMAN_SECTION (
   spaceman_section_sid                NUMBER(38,0)    NOT NULL COMMENT 'surrogate key: identifies the spaceman section in the space management
            SPACEMAN:TBLAPSECTION.SECTIONID',
   int_org_sid                         NUMBER(38,0)    COMMENT 'surrogate key internal organisation',
   src_section_nr                      VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'identifier of the spaceman section in the source system
            SPACEMAN:TBLAPSECTION.SECTIONID
            technically sectionid is numeric, but source data type would allow alphanumeric values in the future
            ',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_SPACEMAN_SECTION PRIMARY KEY (spaceman_section_sid)
       NOT ENFORCED
)
COMMENT = 'logical part of the available shelf space in a store';