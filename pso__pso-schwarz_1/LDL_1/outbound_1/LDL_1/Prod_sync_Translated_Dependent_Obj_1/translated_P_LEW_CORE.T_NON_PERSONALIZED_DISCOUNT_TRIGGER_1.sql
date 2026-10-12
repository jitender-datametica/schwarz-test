CREATE OR REPLACE TABLE ldl_p_lew_core.t_non_personalized_discount_trigger_1 (
client_id INTEGER NOT NULL OPTIONS(description='Unique identifier of the DWH client / slice'),
np_discount_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key of the non personalized discount.'),
np_discount_action_nr INTEGER NOT NULL
OPTIONS(description='Unique Identifier of the action for a non-personalized discount.'),
np_discount_trigger_nr INTEGER NOT NULL
OPTIONS(description='Unique Identifier of the trigger for a non-personalized discount.'),
np_discount_trigger_type_cd STRING(100) NOT NULL
OPTIONS(description='Code for trigger type of a non-personalized discount.'),
np_discount_trigger_condition_type_cd STRING(100)
OPTIONS(description='Code for trigger condition of a non-personalized discount.( for trigger_type_cd =\'ITEM_1\' OR \'MERCHANDISE_HIERARCHY_GROUP\').'),
trigger_min_cnt INTEGER
OPTIONS(description='The minimum threshold quantity to activate the non-personalized discount.e.g: When the discount is 10+2 gratis, it is activated when 12 items are purchased.(For trigger_type_cd = \'ITEM_1\' OR \'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd = \'QUT\').'),
trigger_max_cnt INTEGER
OPTIONS(description='The maximum threshold quantity up to which the non-personalized discount apllies..e.g:The discount is valid up to 10 units or 10 EUR.( For trigger_type_cd = \'ITEM_1\' OR \'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd = \'QUT\').'),
trigger_interval_cnt INTEGER
OPTIONS(description='It is the interval quantity in which the non-personalized discount  is re_1-activated after the minimum threshold quantity has been reached.e.g: The discount is actovated for every 2 units of an item.( For trigger_type_cd = \'ITEM_1\' OR \'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd = \'QUTI\').'),
trigger_min_val NUMERIC(29,5)
OPTIONS(description='The minimum threshold amount to activate the non-personalized discount.(For trigger_type_cd = \'ITEM_1\' OR \'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd = \'AMT\').'),
trigger_max_val NUMERIC(29,5)
OPTIONS(description='The maximum threshold amount up to which the non-personalized discount apllies.( For trigger_type_cd = \'ITEM_1\' OR \'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd = \'AMT\').'),
trigger_interval_val NUMERIC(29,5)
OPTIONS(description='It is the interval amount  in which the non-personalized discount  is re_1-activated after the minimum threshold amount has been reached.(For trigger_type_cd = \'ITEM_1\' OR \'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd = \'AMTI\').'),
trigger_item_price NUMERIC(29,5)
OPTIONS(description='The non-personalized discount is activated if an item_1 in the item_1 group has the defined retail price.(For trigger_type_cd = \'ITEM_1\' OR \'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd = \'AMTS\').'),
trigger_min_shopping_cart_val NUMERIC(29,5)
OPTIONS(description='The minimum purchase amount the customer must reach to activate the non-personalized discount(For trigger_type_cd = \'MARKET_BASKET_THRESHOLD\').'),
coupon_gtin STRING(14)
OPTIONS(description='It is a 13-digit EAN_1 code for the coupon and begin with a system-validated coupon prefix managed in the Store Manager application.'),
coupon_consumption_type_cd STRING(100)
OPTIONS(description='Code for the coupon\'s usage of a non-personalized discount.'),
curr_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key CURRENCY'),
curr_cd STRING(100) NOT NULL
OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_sid, np_discount_trigger_nr, np_discount_action_nr) NOT ENFORCED
) OPTIONS(description='This table is about the condition that must be met to activate a non-personalized discount.');