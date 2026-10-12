CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_shelf_capacity_2 (
client_id BIGNUMERIC(38,0) OPTIONS(description='Surrogate Key CLIENT            spf_section.EXTDESC21'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEM.'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key STORE LOCATION.'),
active_from_dt DATE NOT NULL OPTIONS(description='The begin date of the validity_2 period of the shelf capacity.'),
active_to_dt DATE OPTIONS(description='The end date of the validity_2 period of the shelf capacity.'),
pos_nr BIGNUMERIC(38,0) OPTIONS(description='The position number in the OUTDAT type 24.'),
price_label_type_cd BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The code of the price label type (see also t_ref_price_label_type).'),
item_merchandising_type_cd STRING(100) COLLATE 'und:ci'
OPTIONS(description='A reference to the table t_item_merchandising_type containing the capacity unit_2 that describes the shelf capacity amount.'),
shelf_capacity_meas BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='The number of items regarding to their capacity unit_2 that the shelf can contain.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (item_sid, loc_sid_store, active_from_dt) NOT ENFORCED
)
OPTIONS(description='Contains the historized shelf quantities of items per store. This quantity differs from the planned quantities stored in the spaceman tables.');