/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_assortment_container_item
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_warehouse_assortment_container_item (
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT (client of the warehouse)'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key ITEM (eindeutig ueber alle Laender/Mandanten hinweg)'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key LOCATION (eindeutig ueber alle Laender/Mandanten hinweg)'),
assortment_container_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key container.            WAWI: T1041_ITEMCONTAINER_HEAD.C1041_COUNTRY and             T1041_ITEMCONTAINER_HEAD.C1041_CONT_ID_LOCAL'),
active_from_dt DATE NOT NULL
OPTIONS(description='start day the item is assigned to a container for a certain warehouse            WAWI: C1047_VALID_FROM'),
active_to_dt DATE NOT NULL
OPTIONS(description='end day the item is assigned to a container for a certain warehouse            WAWI: C1047_VALID_TO'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (assortment_container_sid, item_sid, loc_sid_wh, active_from_dt, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. information about which warehouse puts which items into which container             WAWI: T1047_ITEM_CONTAINER_LINK');