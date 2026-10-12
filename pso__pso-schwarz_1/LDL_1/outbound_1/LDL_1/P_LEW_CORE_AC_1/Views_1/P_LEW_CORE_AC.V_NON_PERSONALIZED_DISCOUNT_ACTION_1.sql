CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_non_personalized_discount_action_1 (client_id
OPTIONS(description='unique identifier of the DWH client / slice'), np_discount_sid
OPTIONS(description='Surrogate Key of the non personalized discount.'), np_discount_action_nr
OPTIONS(description='Unique Identifier of the action for a non-personalized discount.'), np_discount_action_type_cd
OPTIONS(description='Code of the action type for the non personalized discount.'), np_discount_benefit_type_cd
OPTIONS(description='Code of the benefit type for the non personalized discount.'), np_discount_action_order_seq
OPTIONS(description='It determines the non personalized discount action application order (in ascending order starting from 0).'),
np_discount_action_prio_seq
OPTIONS(description='It determines the priority of non personalized discount action with identical sequences.'),
receipt_calc_method_cd OPTIONS(description='Code of receipt calculation method for a non personalized discount.'),
item_to_be_paid_cnt
OPTIONS(description='The minimun quantity of  item_1 or item_1 group  to buy to get the discount. e.g: For an action 10+2 gratis, then the quantity of item_1 to buy is 10.( For action_type_cd =\'TO_BE_PAID_QUANTITY\').'),
max_item_to_be_discounted_cnt
OPTIONS(description='It is the maximum number of items from the assigned product list ( MatchingItems) that are eligible to receive the discount, once the non personalized discount conditions are met..( For action_type_cd =\'MIX_AND_MATCH\').'),
np_discount_trigger_logical_operator_cd
OPTIONS(description='Code of  item_1/itemgroup_1 combination type for a non personalized discount.( For action_type_cd =\'MIX_AND_MATCH\').'),
np_discount_method_cd
OPTIONS(description='Code of the calculation method of a non personalized discount for the new price.(For action_type_cd =\'SIMPLE\'),'),
discount_pct
OPTIONS(description='The percentage discount is deducted from the valid retail price of the item.(For action_type_cd =\'SIMPLE\' and discount_method_cd =\'RP\').'),
discount_val
OPTIONS(description='Depending on the discount method type, the value is either deducted from the item_1\'s current retail price (RS_1) or distributed pro-rata across all line items, ensuring a proportional discount for every position on the receipt(RT).(For action_type_cd =\'SIMPLE\').'),
discount_price
OPTIONS(description='The promotional price, which varies by action type. For SET actions, it is the bundle price. For SIMPLE actions, it represents depending on the discount method type either the new unit_1 price (PS) or the total price of an interval (PT) defined by the minimum quantity.'),
curr_sid OPTIONS(description='Surrogate Key CURRENCY'), curr_cd
OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table is about the price adjustment mechanisms associated with a non-personalized discount, which is applied when the trigger condition in a specified defined time period are met.`)
AS SELECT client_id,
 np_discount_sid,
 np_discount_action_nr,
 np_discount_action_type_cd,
 np_discount_benefit_type_cd,
 np_discount_action_order_seq,
 np_discount_action_prio_seq,
 receipt_calc_method_cd,
 item_to_be_paid_cnt,
 max_item_to_be_discounted_cnt,
 np_discount_trigger_logical_operator_cd,
 np_discount_method_cd,
 discount_pct,
 discount_val,
 discount_price,
 curr_sid,
 curr_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_non_personalized_discount_action_1;