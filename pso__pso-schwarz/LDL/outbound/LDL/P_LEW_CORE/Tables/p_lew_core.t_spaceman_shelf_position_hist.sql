/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_shelf_position_hist
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_shelf_position_hist (
shelf_position_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key:position of an item on a shelf in the section configuration            spaceman: tblapposition;POSITION, SECTIONID, SHELF'),
spaceman_item_sid BIGNUMERIC(38,0) OPTIONS(description='surrogate key spaceman item'),
item_merchandising_type_cd STRING(100) COLLATE 'und:ci'
OPTIONS(description='Merchandising Type (Case/Hand/DD/EP)            spaceman:tblapposition:MERCHANDISINGTYPE            '),
case_orientation_cd STRING(100) COLLATE 'und:ci'
OPTIONS(description='Ausrichtung (Front End, Side End, End Front, End Side)            spaceman:tblapposition:ORIENTATION            '),
x_case_cnt BIGNUMERIC(38,0)
OPTIONS(description='Fronts: number of cases/items to be positioned side by side in the position            spaceman:tblapposition:XFACINGS            '),
z_case_cnt BIGNUMERIC(38,0)
OPTIONS(description='Fronts: number of cases/items to be positioned one behind the other in the position            spaceman:tblapposition:ZFACINGS            '),
total_piece_qty BIGNUMERIC(38,5)
OPTIONS(description='calculated number of pieces to be stored in the position. this may be different from the product of total_cas_qty and case_size from spaceman_item_hist  due to the usage of a different case_size during the calculation            spaceman:tblapposition:CAPACITY'),
total_case_qty BIGNUMERIC(38,5)
OPTIONS(description='calculated number of cases to be stored in the position (does not have to be an integer value)            spaceman:tblapposition:CASES            '),
position_width_meas BIGNUMERIC(38,5)
OPTIONS(description='width of the position in in the unit given in uom_cd_width            spaceman:tblapposition:LINEAR            '),
uom_cd_width STRING(20)
OPTIONS(description='Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode            here inch for USA, cm for all other countries'),
uom_sid_width BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key UNIT OF MEASUREMENT für die Kontaktstrecke (cm)'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='relation was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (shelf_position_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='representation of the place which is reserved for a certian item in the configuration of a certian section');