/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_item_group
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_spaceman_item_group (
spaceman_item_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key: item group of the item in the space management            spaceman:tblapproducts:EXTDESC28'),
spaceman_item_grp_name STRING(100)
OPTIONS(description='name for the item group of the item in the space management            spaceman:tblapproducts:EXTDESC28'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (spaceman_item_grp_sid) NOT ENFORCED
) OPTIONS(description='table contains the different spaceman item group codes');