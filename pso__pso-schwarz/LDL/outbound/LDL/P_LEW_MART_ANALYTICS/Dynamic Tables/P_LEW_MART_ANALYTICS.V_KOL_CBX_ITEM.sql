CREATE OR REPLACE TABLE ldl_p_lew_mart_analytics.v_kol_cbx_item (
client_id BIGNUMERIC(38,0),
client_id_order BIGNUMERIC(38,0),
client_cd STRING(20),
client_block_cd STRING(20),
item_ian BIGNUMERIC(38,0),
mdm_item_sid BIGNUMERIC(38,0),
mdm_item_name STRING(100),
cy_week_advertise BIGNUMERIC(38,0),
client_order_total_qty BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0),
item_name STRING(100),
src_orig_item_nr STRING(20),
config_item_cd STRING(20),
src_matnr STRING(20),
range_plan_cd STRING(20),
cy_week_range_advertise_from BIGNUMERIC(38,0),
cy_week_range_advertise_to BIGNUMERIC(38,0),
range_advertise_from_dt DATE,
range_advertise_to_dt DATE,
pre_item_ian BIGNUMERIC(38,0),
pre_mdm_item_sid BIGNUMERIC(38,0),
pre_mdm_item_name STRING(100),
pre_range_plan_cd STRING(20),
pre_cy_week_range_advertise_from BIGNUMERIC(38,0),
pre_cy_week_range_advertise_to BIGNUMERIC(38,0),
pre_range_advertise_from_dt DATE,
pre_range_advertise_to_dt DATE,
dwh_updated DATETIME
) AS
SELECT ITM.client_id,
 ICO.client_id_order,
 ICO.client_cd,
 CLBLK.client_block_cd,
 ITM.item_ian,
 ITM.mdm_item_sid,
 ITM.mdm_item_name,
 ICO_H.cy_week_advertise,
 ICO_H.client_order_total_qty,
 DWH_ITM.item_sid,
 DWH_ITM.item_name,
 DWH_ITM.src_orig_item_nr,
 DWH_ITM.config_item_cd,
 DWH_ITM.src_matnr,
 RANGSEL.range_plan_cd,
 RANGSEL_H.cy_week_range_advertise_from,
 RANGSEL_H.cy_week_range_advertise_to,
 RANGCAL_FROM.cal_dt AS range_advertise_from_dt,
 RANGCAL_TO.cal_dt AS range_advertise_to_dt,
 PRED_I.item_ian AS pre_item_ian,
 PRED.mdm_item_sid_related AS pre_mdm_item_sid,
 PRED_I.mdm_item_name AS pre_mdm_item_name,
 PRED_RANGSEL.range_plan_cd AS pre_range_plan_cd,
 PRED_RANGSEL_H.cy_week_range_advertise_from AS pre_cy_week_range_advertise_from,
 PRED_RANGSEL_H.cy_week_range_advertise_to AS pre_cy_week_range_advertise_to,
 PRED_RANGCAL_FROM.cal_dt AS pre_range_advertise_from_dt,
 PRED_RANGCAL_TO.cal_dt AS pre_range_advertise_to_dt,
 ITM_H.dwh_updated
FROM ldl_p_lew_core_ac.v_mdm_item AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_mdm_item_hist AS ITM_H ON ITM.client_id = ITM_H.client_id AND ITM.mdm_item_sid = ITM_H.mdm_item_sid
      AND ITM_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN ITM_H.dwh_valid_from AND ITM_H.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_client_order AS ICO ON ITM.client_id = ICO.client_id AND ITM.mdm_item_sid = ICO
   .mdm_item_sid
 INNER JOIN ldl_p_lew_core_ac.v_mdm_item_client_order_hist AS ICO_H ON ICO.mdm_item_sid = ICO_H.mdm_item_sid AND ICO.client_id_order
      = ICO_H.client_id_order AND ICO_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN ICO_H.dwh_valid_from AND ICO_H.dwh_valid_to
   
 LEFT JOIN ldl_p_lew_core_ac.v_client_block AS CLBLK ON ICO.client_block_id_order = CLBLK.client_block_id
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_ad_theme_item_hist AS ITM_AD ON ITM.client_id = ITM_AD.client_id AND ITM.mdm_item_sid
      = ITM_AD.mdm_item_sid AND ITM_AD.deleted_fg = 0 AND CURRENT_DATE BETWEEN ITM_AD.dwh_valid_from AND ITM_AD.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_mdm_advertise_theme_hist AS ADVT_H ON ITM_AD.client_id = ADVT_H.client_id AND ITM_AD.mdm_ad_theme_sid
      = ADVT_H.mdm_ad_theme_sid AND ADVT_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN ADVT_H.dwh_valid_from AND ADVT_H.dwh_valid_to
   
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_range_selection AS RANGSEL ON ADVT_H.client_id = RANGSEL.client_id AND ADVT_H.mdm_range_sel_sid
    = RANGSEL.mdm_range_sel_sid
 INNER JOIN ldl_p_lew_core_ac.v_mdm_range_selection_hist AS RANGSEL_H ON RANGSEL.client_id = RANGSEL_H.client_id AND
     RANGSEL.mdm_range_sel_sid = RANGSEL_H.mdm_range_sel_sid AND RANGSEL_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN
   RANGSEL_H.dwh_valid_from AND RANGSEL_H.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday AS RANGCAL_FROM ON RANGSEL_H.cy_week_range_advertise_from = RANGCAL_FROM
   .cy_week AND RANGCAL_FROM.day_of_week = 1
 LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday AS RANGCAL_TO ON RANGSEL_H.cy_week_range_advertise_to = RANGCAL_TO.cy_week
    AND RANGCAL_TO.day_of_week = 7
 LEFT JOIN ldl_p_lew_core_ac.v_item_mdm_link AS ITM_LNK ON ICO.client_id_order = ITM_LNK.client_id AND ICO.mdm_item_sid
   = ITM_LNK.mdm_item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item AS DWH_ITM ON ITM_LNK.client_id = DWH_ITM.client_id AND ITM_LNK.item_sid = DWH_ITM.item_sid
   
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_related_item_hist AS PRED ON ITM.client_id = PRED.client_id AND ITM.mdm_item_sid
       = PRED.mdm_item_sid AND PRED.item_rel_type_cd = 'PRED1' AND PRED.deleted_fg = 0 AND CURRENT_DATE BETWEEN PRED.dwh_valid_from
   AND PRED.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_item AS PRED_I ON PRED.client_id = PRED_I.client_id AND PRED.mdm_item_sid_related =
   PRED_I.mdm_item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_ad_theme_item_hist AS PRED_ITM_AD ON PRED_I.client_id = PRED_ITM_AD.client_id AND
     PRED_I.mdm_item_sid = PRED_ITM_AD.mdm_item_sid AND PRED_ITM_AD.deleted_fg = 0 AND CURRENT_DATE BETWEEN PRED_ITM_AD
   .dwh_valid_from AND PRED_ITM_AD.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_advertise_theme_hist AS PRED_ADVT_H ON PRED_ITM_AD.client_id = PRED_ADVT_H.client_id
    AND PRED_ITM_AD.mdm_ad_theme_sid = PRED_ADVT_H.mdm_ad_theme_sid AND PRED_ADVT_H.deleted_fg = 0 AND CURRENT_DATE
   BETWEEN PRED_ADVT_H.dwh_valid_from AND PRED_ADVT_H.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_range_selection AS PRED_RANGSEL ON PRED_ADVT_H.client_id = PRED_RANGSEL.client_id AND
   PRED_ADVT_H.mdm_range_sel_sid = PRED_RANGSEL.mdm_range_sel_sid
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_range_selection_hist AS PRED_RANGSEL_H ON PRED_RANGSEL.client_id = PRED_RANGSEL_H.client_id
      AND PRED_RANGSEL.mdm_range_sel_sid = PRED_RANGSEL_H.mdm_range_sel_sid AND PRED_RANGSEL_H.deleted_fg = 0 AND
   CURRENT_DATE BETWEEN PRED_RANGSEL_H.dwh_valid_from AND PRED_RANGSEL_H.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday AS PRED_RANGCAL_FROM ON PRED_RANGSEL_H.cy_week_range_advertise_from =
   PRED_RANGCAL_FROM.cy_week AND PRED_RANGCAL_FROM.day_of_week = 1
 LEFT JOIN ldl_p_lew_core_ac.v_cal_calendarday AS PRED_RANGCAL_TO ON PRED_RANGSEL_H.cy_week_range_advertise_to =
   PRED_RANGCAL_TO.cy_week AND PRED_RANGCAL_TO.day_of_week = 7;