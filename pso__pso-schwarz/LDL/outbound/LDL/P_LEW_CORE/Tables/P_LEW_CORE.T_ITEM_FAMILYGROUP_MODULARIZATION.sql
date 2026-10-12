/* --------------------------------------------------------------------------------
   DDL for table: t_item_familygroup_modularization
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_familygroup_modularization (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CLIENT'),
item_fam_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM FAMILYGROUP;            CBX: Item.ldlArticleGroup.custText1;            ESB: cbxItem.itemFamilyGroup.code;            '),
buying_list_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelart WAWI'),
active_from_dt DATE NOT NULL
OPTIONS(description='start day the assortment container is assigned to a store            WAWI: C1045_VALID_FROM'),
active_to_dt DATE
OPTIONS(description='end day the item is assigned to a container for a certain warehouse            WAWI: C1045_VALID_TO'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_fam_grp_sid, buying_list_type_id, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='information about which item family group is mandatory to be maintained in a container             WAWI: T1043_CONTAINER_GROUPS');