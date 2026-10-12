CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_PIT_ADVERT_MEDIUM_GRP_MAP_INPUT_2
AS
   SELECT
     client_id,
   advert_medium_descr,
   adv_medium_disp_order_nbr,
   adv_medium_ignore_fg,
   adv_medium_delete_fg,
   adv_medium_grp_LidlPlus_fg,
   advert_medium_grp_descr,
   adv_medium_grp_disp_order_nbr,
   dwh_created
  FROM p_lew_mart_analytics.t_pit_advert_medium_grp_map_input_2;