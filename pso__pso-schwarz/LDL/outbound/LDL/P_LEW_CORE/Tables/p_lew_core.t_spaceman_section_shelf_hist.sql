/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_section_shelf_hist
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_section_shelf_hist (
shelf_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key for the shelf in the configuration of a section            spaceman: tblapshelf:SHELF, SECTIONID            '),
shelf_width_meas BIGNUMERIC(38,5)
OPTIONS(description='width of the shelf in the unit given in uom_cd_size            spaceman: Tblapshelf:WIDTH            '),
shelf_depth_meas BIGNUMERIC(38,5)
OPTIONS(description='depth of the shelf in the unit given in uom_cd_size            spaceman: Tblapshelf:DEPTH'),
shelf_thickness_meas BIGNUMERIC(38,5)
OPTIONS(description='thickness of the shelf in the unit given in uom_cd_size            spaceman: Tblapshelf:THICKNESS'),
shelf_start_high_meas BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='high of the shelf from the bottom of the store in the unit given in uom_cd_size            spaceman: Tblapshelf:YPOS'),
shelf_start_width_meas BIGNUMERIC(38,5)
OPTIONS(description='distance of the left end of the shelf from the left end of the section in the unit given in uom_cd_size            spaceman: Tblapshelf:XPOS'),
uom_cd_size STRING(20)
OPTIONS(description='Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode            here inch for USA, cm for all other countries'),
uom_sid_size BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key UNIT OF MEASUREMENT'),
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
PRIMARY KEY (shelf_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='representation of a physical shelf in the configuration of a section');