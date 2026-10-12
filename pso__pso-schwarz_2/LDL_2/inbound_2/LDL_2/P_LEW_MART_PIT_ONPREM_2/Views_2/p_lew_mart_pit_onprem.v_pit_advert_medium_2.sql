CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ADVERT_MEDIUM_2

AS
   SELECT
   amd.client_id                                                                         AS client_id
,   TO_DATE('1900-01-01','YYYY-MM_2-DD')                                                    AS DATE_valid_from
,   TO_DATE('9999-12-31','YYYY-MM_2-DD')                                                    AS DATE_valid_to
,   amd.advert_medium_sid                                                                 AS adv_medium_sid
,   amd.advert_medium_group_sid                                                           AS adv_medium_grp_sid
,   amd.advert_medium                                                                     AS advert_medium_descr
,   amd.advert_medium_ignore_fg                                                           AS adv_medium_ignore_fg
,   amd.advert_medium_delete_fg                                                           AS adv_medium_delete_fg
,   0::SMALLINT                                                                             AS adv_medium_grp_LidlPlus_fg
,   amd.dwh_created                                                                       AS dwh_created
,   CAST ( ( amd.advert_medium_sid * 100::INTEGER ) +  amd.client_id AS INTEGER )         AS adv_medium_mstr_sid
,   CAST ( ( amd.advert_medium_group_sid * 100::INTEGER ) +  amd.client_id AS INTEGER )   AS adv_medium_grp_mstr_sid
,   amd.advert_medium_sort_val                                                            AS adv_medium_disp_order_nr

   --   MJD 20200430
   --   FROM p_lew_mart_pit_onprem.t_advert_medium_2 AS amd
   --   INNER JOIN p_lew_mart_pit_onprem.t_advert_medium_hist_2 AS amh
   --   ON  amd.client_id      = amh.client_id
   --   AND amd.adv_medium_sid = amh.adv_medium_sid
   --   AND CURRENT_DATE BETWEEN amh.dwh_valid_from AND amh.dwh_valid_to
   --   AND amh.adv_medium_delete_fg = 0
   FROM p_lew_mart_pit_onprem.t_pit_apt_advert_medium_client_2    amd
   WHERE amd.advert_medium_delete_fg = 0

   UNION ALL

   --   MJD 20200430: eventually would be good to replace this but sids AND descriptions should be the same AS in t_pit_apt_advert_medium_client_2
   SELECT
   amg.client_id
,   TO_DATE('1900-01-01','YYYY-MM_2-DD')                                                    AS DATE_valid_from
,   TO_DATE('9999-12-31','YYYY-MM_2-DD')                                                    AS DATE_valid_to
,   CAST(-2 * amg.adv_medium_grp_sid * amg.client_id AS INTEGER )                         AS adv_medium_sid
,   amg.adv_medium_grp_sid
,   'TOT - ' || amg.adv_medium_grp_descr                                                  AS advert_medium_descr
,   0::SMALLINT                                                                           AS adv_medium_ignore_fg
,   0::SMALLINT                                                                           AS adv_medium_delete_fg
,   0::SMALLINT                                                                           AS adv_medium_grp_LidlPlus_fg
,   amg.dwh_created
,   CAST( (-2::INTEGER * amg.adv_medium_grp_sid * amg.client_id * 100::INTEGER ) +  amg.client_id AS INTEGER )   
                                                                                            AS adv_medium_mstr_sid
,   CAST( ( amg.adv_medium_grp_sid *100::INTEGER ) +  amg.client_id AS INTEGER )          AS adv_medium_grp_mstr_sid
,   amg.adv_medium_grp_sort_val                                                           AS adv_medium_disp_order_nr
   FROM p_lew_mart_pit_onprem.t_advert_medium_group_2 amg;