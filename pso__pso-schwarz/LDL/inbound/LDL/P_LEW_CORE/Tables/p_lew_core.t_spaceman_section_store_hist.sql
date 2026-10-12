/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_section_store_hist
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_SPACEMAN_SECTION_STORE_HIST  CLUSTER BY (CLIENT_ID)(
   client_id                           NUMBER(38,0)    COMMENT 'Surrogate Key CLIENT
            spf_section.EXTDESC21',
   spaceman_section_sid                NUMBER(38,0)    NOT NULL COMMENT 'surrogate key: identifies the spaceman section in the space management
            spf_section.SECTIONID
            ',
   loc_sid_store                       NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key LOCATION (eindeutig ueber alle Laender/Mandanten hinweg, hier nur Filialen)
            spaceman:tblapstore:STORE / NAME
            ',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_SPACEMAN_SECTION_STORE_HIST PRIMARY KEY (spaceman_section_sid, loc_sid_store, dwh_valid_from)
       NOT ENFORCED
)
COMMENT = 'relation of store and sections';