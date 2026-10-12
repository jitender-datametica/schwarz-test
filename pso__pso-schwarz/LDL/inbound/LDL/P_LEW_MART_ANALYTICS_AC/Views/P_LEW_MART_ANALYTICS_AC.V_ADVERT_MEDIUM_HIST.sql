CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_ADVERT_MEDIUM_HIST
AS
   SELECT
     client_id,
   adv_medium_sid,
   adv_medium_grp_sid,
   adv_medium_ignore_fg,
   adv_medium_delete_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_created,
   dwh_updated
  FROM p_lew_mart_analytics.t_advert_medium_hist;