/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_item_2
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_spaceman_item_2 (
int_org_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key internal organisation'),
spaceman_item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key spaceman item_2'),
spaceman_item_nr STRING(100) NOT NULL
OPTIONS(description='identifier of the spaceman item_2 in the source system together with activer_from_dt            spaceman: UPC'),
active_from_dt DATE NOT NULL OPTIONS(description='item_2 validity_2 start date within spaceman'),
active_to_dt DATE
OPTIONS(description='item_2 validity_2 end date within spaceman (means item_2 is no longer available in the current spaceman data)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (spaceman_item_sid) NOT ENFORCED
)
OPTIONS(description='this table contains the set of items defined in the spaceman database. a surrogate key is necessary due to the fact that the WAWI-item_2-number based key can be reused if the item_2 number is reused in WAWI.');