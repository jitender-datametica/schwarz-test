CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_non_personalized_discount_action_itemgroup (client_id
OPTIONS(description='unique identifier of the DWH client / slice.'), np_discount_sid
OPTIONS(description='Surrogate Key of the non personalized discount.'), np_discount_action_nr
OPTIONS(description='Unique Identifier of the action for a non personalized discount.'), item_grp_int_sid
OPTIONS(description='Surrogate Key ITEMGROUP INTERNATIONAL'), itemgroup_np_discount_method_cd
OPTIONS(description='Code of the calculation method of a non personalized discount for the new itemgroup price.( For action_type_cd =\'MIX_AND_MATCH\' and itemgroup in MatchingItemSet).'),
discount_pct
OPTIONS(description='The percentage discount is deducted from the valid retail price of the itemgroup.( For action_type_cd =\'MIX_AND_MATCH\'  and discount_method_cd =\'RP\' and itemgroup in MatchingItemSet).'),
discount_val
OPTIONS(description='The value is deducted from the itemgroup\'s current retail price.( For action_type_cd =\'MIX_AND_MATCH\' and discount_method_cd =\'RS\' and itemgroup in MatchingItemSet).'),
discount_price
OPTIONS(description='This price represents the new price for the itemgroup.( For action_type_cd =\'MIX_AND_MATCH\' and discount_method_cd =\'PS\' and itemgroup in MatchingItemSet ).'),
set_price_share_pct
OPTIONS(description='The percentage share assigned to an individual itemgroup within a promotional set price. e.g Promotion offers Itemgroup A and Itemgroup B for a fixed price of 10 €, the percenrage might be set to 70% for Itemgroup A and 30% for Itemgroup B, so 7 € in revenue for Itemgroup A and 3 € for Itemgroup B.(For action_type_cd =\'SET\').'),
curr_sid OPTIONS(description='Surrogate Key CURRENCY'), curr_cd
OPTIONS(description='Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains the item group(s) on which the non personalized discount action is applied.`)
AS SELECT client_id,
 np_discount_sid,
 np_discount_action_nr,
 item_grp_int_sid,
 itemgroup_np_discount_method_cd,
 discount_pct,
 discount_val,
 discount_price,
 set_price_share_pct,
 curr_sid,
 curr_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_non_personalized_discount_action_itemgroup;