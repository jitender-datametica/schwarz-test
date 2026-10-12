/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_shelf_position_hist_1
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_SPACEMAN_SHELF_POSITION_HIST_1 (
   shelf_position_sid                  NUMBER(38,0)    NOT NULL COMMENT 'surrogate key:position of an item_1 on a shelf in the section configuration
            spaceman: tblapposition;POSITION, SECTIONID, SHELF',
   spaceman_item_sid                   NUMBER(38,0)    COMMENT 'surrogate key spaceman item_1',
   item_merchandising_type_cd          VARCHAR(100)    COLLATE 'en-ci' COMMENT 'Merchandising Type (Case/Hand/DD/EP)
            spaceman:tblapposition:MERCHANDISINGTYPE
            ',
   case_orientation_cd                 VARCHAR(100)    COLLATE 'en-ci' COMMENT 'Ausrichtung (Front End, Side End, End Front, End Side)
            spaceman:tblapposition:ORIENTATION
            ',
   x_case_cnt                          NUMBER(38,0)    COMMENT 'Fronts: number of cases/items to be positioned side by side in the position
            spaceman:tblapposition:XFACINGS
            ',
   z_case_cnt                          NUMBER(38,0)    COMMENT 'Fronts: number of cases/items to be positioned one behind the other in the position
            spaceman:tblapposition:ZFACINGS
            ',
   total_piece_qty                     NUMBER(38,5)    COMMENT 'calculated number of pieces to be stored in the position. this may be different from the product of total_cas_qty and case_size from spaceman_item_hist  due to the usage of a different case_size during the calculation
            spaceman:tblapposition:CAPACITY',
   total_case_qty                      NUMBER(38,5)    COMMENT 'calculated number of cases to be stored in the position (does not have to be an integer value)
            spaceman:tblapposition:CASES
            ',
   position_width_meas                 NUMBER(38,5)    COMMENT 'width of the position in in the unit_1 given in uom_cd_width
            spaceman:tblapposition:LINEAR
            ',
   uom_cd_width                        VARCHAR(20)     COMMENT 'Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode
            here inch for USA, cm for all other countries',
   uom_sid_width                       NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key UNIT_1 OF MEASUREMENT für die Kontaktstrecke (cm)',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_SPACEMAN_SHELF_POSITION_HIST PRIMARY KEY (shelf_position_sid, dwh_valid_from)
       NOT ENFORCED
)
COMMENT = 'representation of the place which is reserved for a certian item_1 in the configuration of a certian section';