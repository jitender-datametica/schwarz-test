CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ADVERT_MEDIUM
AS 
SELECT
  client_id
, date_valid_from
, date_valid_to
, adv_medium_sid 
, adv_medium_grp_sid
, advert_medium_descr 
, adv_medium_ignore_fg 
, adv_medium_delete_fg 
, adv_medium_grp_LidlPlus_fg 
, dwh_created
, adv_medium_mstr_sid
, adv_medium_grp_mstr_sid
, adv_medium_disp_order_nbr
FROM p_lew_mart_analytics.v_pit_advert_medium;