
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_ANALYTICS.V_PIT_ADVERT_MEDIUM_2
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_ANALYTICS
AS
   SELECT
     amd.client_id,
   amh.dwh_valid_from                                                                    AS date_valid_from,
   amh.dwh_valid_to                                                                      AS date_valid_to,
   amd.adv_medium_sid,
   amh.adv_medium_grp_sid,
   amd.adv_medium_descr                                                                  AS advert_medium_descr,
   amh.adv_medium_ignore_fg,
   amh.adv_medium_delete_fg,
   CAST(0 AS BYTEINT)                                                                    AS adv_medium_grp_LidlPlus_fg,
   amh.dwh_created,
   CAST(amd.adv_medium_sid * 100 + amd.client_id AS INTEGER)                             AS adv_medium_mstr_sid,
   CAST(amh.adv_medium_grp_sid * 100 + amh.client_id AS INTEGER)                         AS adv_medium_grp_mstr_sid,
   amd.adv_medium_sort_val                                                               AS adv_medium_disp_order_nbr
  FROM p_lew_mart_analytics.t_advert_medium_2 AS amd
   INNER JOIN p_lew_mart_analytics.t_advert_medium_hist_2 AS amh
   ON  amd.client_id      = amh.client_id
   AND amd.adv_medium_sid = amh.adv_medium_sid
   AND CURRENT_DATE BETWEEN amh.dwh_valid_from AND amh.dwh_valid_to
   AND amh.adv_medium_delete_fg = 0
   UNION ALL
   SELECT
     amg.client_id,
   DATE'1900-01-01'                                                                      AS date_valid_from,
   DATE'9999-12-31'                                                                      AS date_valid_to,
   CAST(-2 * amg.adv_medium_grp_sid * amg.client_id AS INTEGER)                          AS adv_medium_sid,
   amg.adv_medium_grp_sid,
   'TOT - ' || amg.adv_medium_grp_descr                                                  AS advert_medium_descr,
   0                                                                                     AS adv_medium_ignore_fg,
   0                                                                                     AS adv_medium_delete_fg,
   0                                                                                     AS adv_medium_grp_LidlPlus_fg,
   amg.dwh_created,
   CAST(-2 * amg.adv_medium_grp_sid * amg.client_id * 100 + amg.client_id AS INTEGER)    AS adv_medium_mstr_sid,
   CAST(amg.adv_medium_grp_sid *100 + amg.client_id AS INTEGER)                          AS adv_medium_grp_mstr_sid,
   amg.adv_medium_grp_sort_val                                                           AS adv_medium_disp_order_nbr
  FROM p_lew_mart_analytics.t_advert_medium_group_2 AS amg
   ;
