CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_non_personalized_discount_trigger (client_id
OPTIONS(description='Unique identifier of the DWH client / slice'), np_discount_sid
OPTIONS(description='Surrogate Key of the non personalized discount.'), np_discount_action_nr
OPTIONS(description='Unique Identifier of the action for a non-personalized discount.'), np_discount_trigger_nr
OPTIONS(description='Unique Identifier of the trigger for a non-personalized discount.'), np_discount_trigger_type_cd
OPTIONS(description='Code for trigger type of a non-personalized discount.'), np_discount_trigger_condition_type_cd
OPTIONS(description='Code for trigger condition of a non-personalized discount.( for trigger_type_cd =\'ITEM\' OR\'MERCHANDISE_HIERARCHY_GROUP\').'),
trigger_min_cnt
OPTIONS(description='The minimum threshold quantity to activate the non-personalized discount.e.g: When the discount is 10+2 gratis, it is activated when 12 items are purchased.(For trigger_type_cd =\'ITEM\' OR\'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd =\'QUT\').'),
trigger_max_cnt
OPTIONS(description='The maximum threshold quantity up to which the non-personalized discount apllies..e.g:The discount is valid up to 10 units or 10 EUR.( For trigger_type_cd =\'ITEM\' OR\'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd =\'QUT\').'),
trigger_interval_cnt
OPTIONS(description='It is the interval quantity in which the non-personalized discount  is re-activated after the minimum threshold quantity has been reached.e.g: The discount is actovated for every 2 units of an item.( For trigger_type_cd =\'ITEM\' OR\'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd =\'QUTI\').'),
trigger_min_val
OPTIONS(description='The minimum threshold amount to activate the non-personalized discount.(For trigger_type_cd =\'ITEM\' OR\'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd =\'AMT\').'),
trigger_max_val
OPTIONS(description='The maximum threshold amount up to which the non-personalized discount apllies.( For trigger_type_cd =\'ITEM\' OR\'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd =\'AMT\').'),
trigger_interval_val
OPTIONS(description='It is the interval amount  in which the non-personalized discount  is re-activated after the minimum threshold amount has been reached.(For trigger_type_cd =\'ITEM\' OR\'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd =\'AMTI\').'),
trigger_item_price
OPTIONS(description='The non-personalized discount is activated if an item in the item group has the defined retail price.(For trigger_type_cd =\'ITEM\' OR\'MERCHANDISE_HIERARCHY_GROUP\' and  trigger_condition_type_cd =\'AMTS\').'),
trigger_min_shopping_cart_val
OPTIONS(description='The minimum purchase amount the customer must reach to activate the non-personalized discount(For trigger_type_cd =\'MARKET_BASKET_THRESHOLD\').'),
coupon_gtin
OPTIONS(description='It is a 13-digit EAN code for the coupon and begin with a system-validated coupon prefix managed in the Store Manager application.'),
coupon_consumption_type_cd OPTIONS(description='Code for the coupon\'s usage of a non-personalized discount.'), curr_sid
OPTIONS(description='Surrogate Key CURRENCY'), curr_cd
OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'), dwh_created
OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_updated OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table is about the condition that must be met to activate a non-personalized discount.`) AS
SELECT client_id,
 np_discount_sid,
 np_discount_action_nr,
 np_discount_trigger_nr,
 np_discount_trigger_type_cd,
 np_discount_trigger_condition_type_cd,
 trigger_min_cnt,
 trigger_max_cnt,
 trigger_interval_cnt,
 trigger_min_val,
 trigger_max_val,
 trigger_interval_val,
 trigger_item_price,
 trigger_min_shopping_cart_val,
 coupon_gtin,
 coupon_consumption_type_cd,
 curr_sid,
 curr_cd,
 dwh_created,
 dwh_load_id,
 dwh_updated
FROM ldl_p_lew_core.t_non_personalized_discount_trigger;