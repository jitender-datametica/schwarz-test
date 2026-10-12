/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_section_group_level_5_hist_1
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_SPACEMAN_SECTION_GROUP_LEVEL_5_HIST_1 (
   section_group_level_5_nr            NUMBER(38,0)    NOT NULL COMMENT 'identifier of the 5ht level of the org local hierarchy_1 of sections in spaceman',
   section_group_level_4_nr            NUMBER(38,0)    COMMENT 'identifier of the 4ht level of the org local hierarchy_1 of sections in spaceman',
   section_group_level_5_name          VARCHAR(100)    NOT NULL COMMENT 'name of the 5ht level of the org local hierarchy_1 of sections in spaceman',
   int_org_sid                         NUMBER(38,0)    COMMENT 'surrogate key internal organisation',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_SPACEMAN_SECTION_GROUP_LEVEL_5_HIST PRIMARY KEY (section_group_level_5_nr, dwh_valid_from)
       NOT ENFORCED
)
COMMENT = '5ht level of the org local hierarchy_1 of sections in spaceman';