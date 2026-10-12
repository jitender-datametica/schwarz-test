/* --------------------------------------------------------------------------------
   DDL for table: t_ref_household_type_2
   generated from Powerdesigner on Donnerstag, 25. Januar 2024 15:22:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_household_type_2 (
household_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID of the household type in which the customer lives.'),
household_type_descr STRING(250) NOT NULL
OPTIONS(description='Description of the household type in which the customer lives.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (household_type_id) NOT ENFORCED
) OPTIONS(description='This minor entity defines the various IDs for the type of the household.');