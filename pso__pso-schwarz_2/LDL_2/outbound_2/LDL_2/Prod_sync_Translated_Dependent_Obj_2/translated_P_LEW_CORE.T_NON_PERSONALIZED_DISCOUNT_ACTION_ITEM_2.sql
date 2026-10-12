CREATE OR REPLACE TABLE ldl_p_lew_core.t_non_personalized_discount_action_item_2 (
client_id INTEGER NOT NULL OPTIONS(description='unique identifier of the DWH client / slice.'),
np_discount_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key of the non personalized discount.'),
np_discount_action_nr INTEGER NOT NULL
OPTIONS(description='Unique Identifier of the action for a non personalized discount.'),
item_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg).'),
item_np_discount_method_cd STRING(100)
OPTIONS(description='Code of the calculation method of a non personalized discount for the new item_2 price.( For action_type_cd = \'MIX_AND_MATCH\' and item_2 in MatchingItemSet).'),
discount_pct NUMERIC(29,5)
OPTIONS(description='The percentage discount is deducted from the valid retail price of the item.( For action_type_cd = \'MIX_AND_MATCH\'  and discount_method_cd = \'RP\' and item_2 in MatchingItemSet).'),
discount_val NUMERIC(29,5)
OPTIONS(description='The value is deducted from the item_2\'s current retail price.( For action_type_cd = \'MIX_AND_MATCH\' and discount_method_cd = \'RS_2\' and item_2 in MatchingItemSet).'),
discount_price NUMERIC(29,5)
OPTIONS(description='This price represents the new price for the item.( For action_type_cd = \'MIX_AND_MATCH\' and discount_method_cd = \'PS\' and item_2 in MatchingItemSet ).'),
set_price_share_pct NUMERIC(29,5)
OPTIONS(description='The percentage share assigned to an individual item_2 within a promotional set price. e.g Promotion offers Item_2 A and Item_2 B for a fixed price of 10 €, the percenrage might be set to 70% for Item_2 A and 30% for Item_2 B, so 7 € in revenue for Item_2 A and 3 € for Item_2 B.(For action_type_cd = \'SET\').'),
curr_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key CURRENCY'),
curr_cd STRING(100) NOT NULL
OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_sid, np_discount_action_nr, item_sid) NOT ENFORCED
) OPTIONS(description='This table contains the item_2(s) on which the non personalized discount action is applied.');