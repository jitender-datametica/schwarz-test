CREATE OR REPLACE TABLE ldl_p_lew_core.t_non_personalized_discount_action_2 (
client_id INTEGER NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
np_discount_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key of the non personalized discount.'),
np_discount_action_nr INTEGER NOT NULL
OPTIONS(description='Unique Identifier of the action for a non-personalized discount.'),
np_discount_action_type_cd STRING(100) NOT NULL
OPTIONS(description='Code of the action type for the non personalized discount.'),
np_discount_benefit_type_cd STRING(100) NOT NULL
OPTIONS(description='Code of the benefit type for the non personalized discount.'),
np_discount_action_order_seq INTEGER
OPTIONS(description='It determines the non personalized discount action application order (in ascending order starting from 0).'),
np_discount_action_prio_seq INTEGER NOT NULL
OPTIONS(description='It determines the priority of non personalized discount action with identical sequences.'),
receipt_calc_method_cd STRING(100) NOT NULL
OPTIONS(description='Code of receipt calculation method for a non personalized discount.'),
item_to_be_paid_cnt INTEGER
OPTIONS(description='The minimun quantity of  item_2 or item_2 group  to buy to get the discount. e.g: For an action 10+2 gratis, then the quantity of item_2 to buy is 10.( For action_type_cd = \'TO_BE_PAID_QUANTITY\').'),
max_item_to_be_discounted_cnt INTEGER
OPTIONS(description='It is the maximum number of items from the assigned product list ( MatchingItems) that are eligible to receive the discount, once the non personalized discount conditions are met..( For action_type_cd = \'MIX_AND_MATCH\').'),
np_discount_trigger_logical_operator_cd STRING(100)
OPTIONS(description='Code of  item_2/itemgroup_2 combination type for a non personalized discount.( For action_type_cd = \'MIX_AND_MATCH\').'),
np_discount_method_cd STRING(100)
OPTIONS(description='Code of the calculation method of a non personalized discount for the new price.(For action_type_cd = \'SIMPLE\'),'),
discount_pct NUMERIC(29,5)
OPTIONS(description='The percentage discount is deducted from the valid retail price of the item.(For action_type_cd = \'SIMPLE\' and discount_method_cd = \'RP\').'),
discount_val NUMERIC(29,5)
OPTIONS(description='Depending on the discount method type, the value is either deducted from the item_2\'s current retail price (RS_2) or distributed pro-rata across all line items, ensuring a proportional discount for every position on the receipt(RT).(For action_type_cd = \'SIMPLE\').'),
discount_price NUMERIC(29,5)
OPTIONS(description='The promotional price, which varies by action type. For SET actions, it is the bundle price. For SIMPLE actions, it represents depending on the discount method type either the new unit_2 price (PS) or the total price of an interval (PT) defined by the minimum quantity.'),
curr_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key CURRENCY'),
curr_cd STRING(100) NOT NULL
OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'),
PRIMARY KEY (np_discount_sid, np_discount_action_nr) NOT ENFORCED
)
OPTIONS(description='This table is about the price adjustment mechanisms associated with a non-personalized discount, which is applied when the trigger condition in a specified defined time period are met.');