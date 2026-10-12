/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_section_group_level_5_hist_2
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_section_group_level_5_hist_2 (
section_group_level_5_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the 5ht level of the org local hierarchy_2 of sections in spaceman'),
section_group_level_4_nr BIGNUMERIC(38,0)
OPTIONS(description='identifier of the 4ht level of the org local hierarchy_2 of sections in spaceman'),
section_group_level_5_name STRING(100) NOT NULL
OPTIONS(description='name of the 5ht level of the org local hierarchy_2 of sections in spaceman'),
int_org_sid BIGNUMERIC(38,0) OPTIONS(description='surrogate key internal organisation'),
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
PRIMARY KEY (section_group_level_5_nr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='5ht level of the org local hierarchy_2 of sections in spaceman');