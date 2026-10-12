CREATE OR REPLACE TABLE ldl_p_lew_core.t_non_personalized_discount_trigger_itemgroup (
client_id INTEGER NOT NULL OPTIONS(description='unique identifier of the DWH client / slice.'),
np_discount_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key of the non personalized discount.'),
np_discount_trigger_nr INTEGER NOT NULL
OPTIONS(description='Unique Identifier of the trigger for a non-personalized discount.'),
np_discount_action_nr INTEGER NOT NULL
OPTIONS(description='Unique Identifier of the action for a non-personalized discount.'),
item_grp_int_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key ITEMGROUP INTERNATIONAL'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_sid, np_discount_trigger_nr, np_discount_action_nr, item_grp_int_sid) NOT ENFORCED
)
OPTIONS(description='This table contains the item group(s)required to trigger the non personalized discount, which may differ from the item group(s) to which the discount is applied.');