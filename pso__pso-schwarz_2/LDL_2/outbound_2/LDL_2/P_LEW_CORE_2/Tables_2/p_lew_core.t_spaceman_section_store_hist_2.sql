/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_section_store_hist_2
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_section_store_hist_2 (
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT            spf_section.EXTDESC21'),
spaceman_section_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key: identifies the spaceman section in the space management            spf_section.SECTIONID            '),
loc_sid_store BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION_2 (eindeutig ueber alle Laender/Mandanten hinweg, hier nur Filialen)            spaceman:tblapstore:STORE / NAME            '),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='relation was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (spaceman_section_sid, loc_sid_store, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='relation of store and sections');