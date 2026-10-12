
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_KOL_CBX_ITEM
(
      client_id
    , client_id_order
    , client_cd
    , client_block_cd
    , item_ian
    , mdm_item_sid
    , mdm_item_name
    , cy_week_advertise
    , client_order_total_qty
    , item_sid
    , item_name
    , src_orig_item_nr
    , config_item_cd
    , src_matnr
    , range_plan_cd
    , cy_week_range_advertise_from
    , cy_week_range_advertise_to
    , range_advertise_from_dt
    , range_advertise_to_dt
    , pre_item_ian
    , pre_mdm_item_sid
    , pre_mdm_item_name
    , pre_range_plan_cd
    , pre_cy_week_range_advertise_from
    , pre_cy_week_range_advertise_to
    , pre_range_advertise_from_dt
    , pre_range_advertise_to_dt
    , dwh_updated
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
         itm.client_id,
   ico.client_id_order,
   ico.client_cd,
   clblk.client_block_cd,
   itm.item_ian,
   itm.mdm_item_sid,
   itm.mdm_item_name,
   ico_h.cy_week_advertise,
   ico_h.client_order_total_qty,
   dwh_itm.item_sid,
   dwh_itm.item_name,
   dwh_itm.src_orig_item_nr,
   dwh_itm.config_item_cd,
   dwh_itm.src_matnr,
   rangsel.range_plan_cd,
   rangsel_h.cy_week_range_advertise_from,
   rangsel_h.cy_week_range_advertise_to,
   rangcal_from.cal_dt AS range_advertise_from_dt,
   rangcal_to.cal_dt AS range_advertise_to_dt,
   pred_i.item_ian AS pre_item_ian,
   pred.mdm_item_sid_related AS pre_mdm_item_sid,
   pred_i.mdm_item_name AS pre_mdm_item_name,
   pred_rangsel.range_plan_cd AS pre_range_plan_cd,
   pred_rangsel_h.cy_week_range_advertise_from AS pre_cy_week_range_advertise_from,
   pred_rangsel_h.cy_week_range_advertise_to AS pre_cy_week_range_advertise_to,
   pred_rangcal_from.cal_dt AS pre_range_advertise_from_dt,
   pred_rangcal_to.cal_dt AS pre_range_advertise_to_dt,
   itm_h.dwh_updated
  FROM p_lew_core_ac.v_mdm_item AS itm
   INNER JOIN p_lew_core_ac.v_mdm_item_hist AS itm_h
   ON itm_h.client_id = itm.client_id
   AND itm_h.mdm_item_sid = itm.mdm_item_sid
   AND itm_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN itm_h.dwh_valid_from AND itm_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_item_client_order AS ico
   ON ico.client_id = itm.client_id
   AND ico.mdm_item_sid = itm.mdm_item_sid
   INNER JOIN p_lew_core_ac.v_mdm_item_client_order_hist AS ico_h
   ON ico_h.mdm_item_sid = ico.mdm_item_sid
   AND ico_h.client_id_order = ico.client_id_order
   AND ico_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN ico_h.dwh_valid_from AND ico_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_client_block AS clblk
   ON clblk.client_block_id = ico.client_block_id_order
   LEFT JOIN p_lew_core_ac.v_mdm_ad_theme_item_hist AS itm_ad
   ON itm_ad.client_id = itm.client_id
   AND itm_ad.mdm_item_sid = itm.mdm_item_sid
   AND itm_ad.deleted_fg = 0
   AND CURRENT_DATE BETWEEN itm_ad.dwh_valid_from AND itm_ad.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_mdm_advertise_theme_hist AS advt_h
   ON advt_h.client_id = itm_ad.client_id
   AND advt_h.mdm_ad_theme_sid = itm_ad.mdm_ad_theme_sid
   AND advt_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN advt_h.dwh_valid_from AND advt_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_range_selection AS rangsel
   ON rangsel.client_id = advt_h.client_id
   AND rangsel.mdm_range_sel_sid = advt_h.mdm_range_sel_sid
   INNER JOIN p_lew_core_ac.v_mdm_range_selection_hist AS rangsel_h
   ON rangsel_h.client_id = rangsel.client_id
   AND rangsel_h.mdm_range_sel_sid = rangsel.mdm_range_sel_sid
   AND rangsel_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN rangsel_h.dwh_valid_from AND rangsel_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_cal_calendarday AS rangcal_from
   ON rangcal_from.cy_week = rangsel_h.cy_week_range_advertise_from
   AND rangcal_from.day_of_week = 1
   LEFT JOIN p_lew_core_ac.v_cal_calendarday AS rangcal_to
   ON rangcal_to.cy_week = rangsel_h.cy_week_range_advertise_to
   AND rangcal_to.day_of_week = 7
   LEFT JOIN p_lew_core_ac.v_item_mdm_link AS itm_lnk
   ON itm_lnk.client_id = ico.client_id_order
   AND itm_lnk.mdm_item_sid = ico.mdm_item_sid
   LEFT JOIN p_lew_core_ac.v_item AS dwh_itm
   ON dwh_itm.client_id = itm_lnk.client_id
   AND dwh_itm.item_sid = itm_lnk.item_sid
   LEFT JOIN p_lew_core_ac.v_mdm_item_related_item_hist AS pred
   ON pred.client_id = itm.client_id
   AND pred.mdm_item_sid = itm.mdm_item_sid
   AND pred.item_rel_type_cd = 'PRED1'
   AND pred.deleted_fg = 0
   AND CURRENT_DATE BETWEEN pred.dwh_valid_from AND pred.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_item AS pred_i
   ON pred_i.client_id = pred.client_id
   AND pred_i.mdm_item_sid = pred.mdm_item_sid_related
   LEFT JOIN p_lew_core_ac.v_mdm_ad_theme_item_hist AS pred_itm_ad
   ON pred_itm_ad.client_id = pred_i.client_id
   AND pred_itm_ad.mdm_item_sid = pred_i.mdm_item_sid
   AND pred_itm_ad.deleted_fg = 0
   AND CURRENT_DATE BETWEEN pred_itm_ad.dwh_valid_from AND pred_itm_ad.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_advertise_theme_hist AS pred_advt_h
   ON pred_advt_h.client_id = pred_itm_ad.client_id
   AND pred_advt_h.mdm_ad_theme_sid = pred_itm_ad.mdm_ad_theme_sid
   AND pred_advt_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN pred_advt_h.dwh_valid_from AND pred_advt_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_range_selection AS pred_rangsel
   ON pred_rangsel.client_id = pred_advt_h.client_id
   AND pred_rangsel.mdm_range_sel_sid = pred_advt_h.mdm_range_sel_sid
   LEFT JOIN p_lew_core_ac.v_mdm_range_selection_hist AS pred_rangsel_h
   ON pred_rangsel_h.client_id = pred_rangsel.client_id
   AND pred_rangsel_h.mdm_range_sel_sid = pred_rangsel.mdm_range_sel_sid
   AND pred_rangsel_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN pred_rangsel_h.dwh_valid_from AND pred_rangsel_h.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_cal_calendarday AS pred_rangcal_from
   ON pred_rangcal_from.cy_week = pred_rangsel_h.cy_week_range_advertise_from
   AND pred_rangcal_from.day_of_week = 1
   LEFT JOIN p_lew_core_ac.v_cal_calendarday AS pred_rangcal_to
   ON pred_rangcal_to.cy_week = pred_rangsel_h.cy_week_range_advertise_to
   AND pred_rangcal_to.day_of_week = 7
   ;
