CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_PIT_ADVERT_MEDIUM_GRP_2
AS
   SELECT
     amg.client_id,
   DATE'1900-01-01'                                                                      AS date_valid_from,
   DATE'9999-12-31'                                                                      AS date_valid_to,
   amg.adv_medium_grp_sid,
   amg.adv_medium_grp_descr                                                              AS advert_medium_grp_descr,
   amg.adv_medium_grp_sort_val                                                           AS adv_medium_grp_disp_order_nbr,
   0                                                                                     AS adv_medium_ignore_fg,
   0                                                                                     AS adv_medium_delete_fg,
   0                                                                                     AS adv_medium_grp_LidlPlus_fg,
   amg.dwh_created,
   CAST(amg.adv_medium_grp_sid *100 + amg.client_id AS INTEGER)                          AS adv_medium_grp_mstr_sid
  FROM p_lew_mart_analytics.t_advert_medium_group_2 AS amg
;