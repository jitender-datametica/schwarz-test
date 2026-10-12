/*
#-------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#
#  1.0 2023-04-18 Pawel Wieczorek         AP0157806 Initial version
#  1.1 2023-04-21 Marcin Kikola           Change in the list of pcwo reasons in order to allign with Mstr FE metrics' definitions
#  1.2 2023-10-16 Rafal Rudnik            AP0192878 Change in the list of pcwo reasons to add 'Dauerhaft PV' id=42 and 'Preisgebietsdiff' id=-99
#  1.3 2023-10-27 Pawel Wieczorek         AP0192878 Added condition to pcwo_reason_id 42
#  1.4 2024-04-25 Pawel Wieczorek         INC8314675_BGES_VGES_lidlplus limit to BGES
#  1.5 2024-04-25 Pawel Wieczorek         Changed condition bges.is_btes
#  1.5 2024-10-17 Pawel Wieczorek         INC8678677 Changed source from LDL.p_lew_mart_lead.t_agg_str_day_item_pch_1 to p_lew_mart_lead.v_mat_agg_str_day_item_pch_ldlplus_1
#-------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_str_day_item_pch_ldpl_1 (client_id
OPTIONS(description='The unique identifier for the Lidl country.'), loc_sid_store
OPTIONS(description='surrogate Key for Store.'), item_sid OPTIONS(description='Surrogate Key Item.'), pcwo_reason_id
OPTIONS(description='Unique ID for PV >100 local reasons. Only 41,42,42 and 45 otherwise 0'), sfotype_id
OPTIONS(description='document type.'), pch_bnl_switch_fg OPTIONS(description='1=calculated with new method.'),
dwh_cal_dt OPTIONS(description='Logical Date of Row.'), val_price_change OPTIONS(description='Calculated Aggregation.'),
dwh_updated OPTIONS(description='Last Change Date'))
OPTIONS(DESCRIPTION = `PRICE CHANGE VALUE - SELECTED PCWO_REASON_ID FOR LIDLPLUS - IN LOCAL CURRENCY`) AS
/* limit to BGES data */ SELECT P.client_id,
 P.loc_sid_store,
 P.item_sid,
  CASE
  WHEN P.pcwo_reason_id IN (41, 43, 45, - 99) OR P.pcwo_reason_id IN (42) AND P.sfotype_id IN (134, 144, 180, 190, 186,
      196)
  THEN P.pcwo_reason_id
  ELSE 0
  END AS pcwo_reason_id,
 P.sfotype_id,
 P.pch_bnl_switch_fg,
 P.dwh_cal_dt,
 P.val_price_change,
 P.dwh_updated
FROM ldl_p_lew_mart_lead.v_mat_agg_str_day_item_pch_ldlplus_1 AS P
 INNER JOIN ldl_p_lew_mart_lidl_digital.v_moved_store_ldpl_1 AS BGES ON P.client_id = BGES.client_id AND P.loc_sid_store
    /* is_BGES == Y */ = BGES.store_id AND BGES.move_to_store_id > 0;