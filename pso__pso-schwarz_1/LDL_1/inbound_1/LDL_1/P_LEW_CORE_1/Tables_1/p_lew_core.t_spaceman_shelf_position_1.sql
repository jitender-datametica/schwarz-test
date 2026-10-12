/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_shelf_position_1
   generated from Powerdesigner on Freitag, 21. Oktober 2022 22:30:16
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_SPACEMAN_SHELF_POSITION_1 (
   shelf_position_sid                  NUMBER(38,0)    NOT NULL COMMENT 'surrogate key:position of an item_1 on a shelf in the section configuration
            spaceman: tblapposition;POSITION, SECTIONID, SHELF
            ',
   shelf_sid                           NUMBER(38,0)    COMMENT 'surrogate key for the shelf in the configuration of a section
            spaceman: tblapposition:SECTIONID, SHELF',
   src_section_nr                      VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'identifier of the spaceman section in the source system
            SPACEMAN:TBLAPSECTION.SECTIONID
            technically sectionid is numeric, but source data type would allow alphanumeric values in the future
            ',
   src_shelf_nr                        NUMBER(38,0)    COMMENT 'number of the shelf in the section
            spaceman: tblapshelf:SHELF',
   src_position_nr                     NUMBER(38,0)    COMMENT 'logical position of an item_1 on a shelf
            spaceman: tblapposition;POSITION',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_SPACEMAN_SHELF_POSITION PRIMARY KEY (shelf_position_sid)
       NOT ENFORCED
)
COMMENT = 'representation of the place which is reserved for a certian item_1 in the configuration of a certian section';