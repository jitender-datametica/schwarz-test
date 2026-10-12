/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_section_shelf_hist_2
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_SPACEMAN_SECTION_SHELF_HIST_2 (
   shelf_sid                           NUMBER(38,0)    NOT NULL COMMENT 'surrogate key for the shelf in the configuration of a section
            spaceman: tblapshelf:SHELF, SECTIONID
            ',
   shelf_width_meas                    NUMBER(38,5)    COMMENT 'width of the shelf in the unit_2 given in uom_cd_size
            spaceman: Tblapshelf:WIDTH
            ',
   shelf_depth_meas                    NUMBER(38,5)    COMMENT 'depth of the shelf in the unit_2 given in uom_cd_size
            spaceman: Tblapshelf:DEPTH',
   shelf_thickness_meas                NUMBER(38,5)    COMMENT 'thickness of the shelf in the unit_2 given in uom_cd_size
            spaceman: Tblapshelf:THICKNESS',
   shelf_start_high_meas               NUMBER(38,5)    NOT NULL COMMENT 'high of the shelf from the bottom of the store in the unit_2 given in uom_cd_size
            spaceman: Tblapshelf:YPOS',
   shelf_start_width_meas              NUMBER(38,5)    COMMENT 'distance of the left end of the shelf from the left end of the section in the unit_2 given in uom_cd_size
            spaceman: Tblapshelf:XPOS',
   uom_cd_size                         VARCHAR(20)     COMMENT 'Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode
            here inch for USA, cm for all other countries',
   uom_sid_size                        NUMBER(38,0)    COMMENT 'Surrogate Key UNIT_2 OF MEASUREMENT',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_SPACEMAN_SECTION_SHELF_HIST PRIMARY KEY (shelf_sid, dwh_valid_from)
       NOT ENFORCED
)
COMMENT = 'representation of a physical shelf in the configuration of a section';