/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_ORG_WH_2
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  23.10.2017    Proch,Marika             Anpassung der Datenbank von f_msi_data  zu f_lew_mart_msi.t_msi_sys_revision_log_2
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_2 mit V_WAREHOUSE_2 ersetzt
#  1.5  18.06.2021    Wandtke,Andrzej          AP0090657_zkp_transall REP1-14602 20210608_2859_ZKP_TransAll remove table v_wawi_org_wh_act_2, use v_wawi_org_wh_2 mit outer CROSS JOIN.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_org_wh_2 AS SELECT WH.client_id,
 WH.src_wh_id AS wh_id,
 WH.country_pol_cd AS country_cd,
 COALESCE(WH.opening_dt, WH.real_opening_dt) AS dat_opening,
 NULL AS costcenter_cd,
 NULL AS company,
 NULL AS order_buying_list_cd,
 NULL AS vat_region_nr,
 NULL AS region_cd,
 NULL AS stock_plain,
 NULL AS sponsion,
 NULL AS global_location_nr,
 WH.loc_name AS wh_desc,
 NULL AS distribute_wh_fg,
 NULL AS int_fg,
 NULL AS hq_fg,
 NULL AS prop_wh_fg,
 NULL AS sales_wh_fg,
 NULL AS supp_wh_fg,
 NULL AS wawi_data_fg,
 NULL AS ovis_data_fg,
  FORMAT_DATE('%Y%m%d', REVLOG.dat_formdate_from) || FORMAT_DATE('%Y%m%d', REVLOG.dat_formdate_until) AS materialize_id
 ,
 REVLOG.revision_test_fg,
 REVLOG.revision_fg,
 REVLOG.revision_user,
 REVLOG.revision_reason_cd
FROM ldl_p_lew_bil_ac.v_warehouse_2 AS WH
 LEFT JOIN ldl_p_lew_mart_msi.t_msi_sys_revision_log_2 AS REVLOG ON WH.client_id = REVLOG.client_id AND WH.loc_sid_wh =
     REVLOG.wh_loc_sid AND REVLOG.orig_store_nr IS NULL AND REVLOG.timestamp_delete IS NULL
 LEFT JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON WH.client_id = MIG.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_wh_2 AS WH_WAWI ON WH.loc_sid_wh = WH_WAWI.wh_loc_sid AND WH.client_id = WH_WAWI.client_id
     AND CURRENT_DATE BETWEEN WH_WAWI.dat_rec_start AND WH_WAWI.dat_rec_end
WHERE WH.dwh_actual_fg = 1
 AND (WH_WAWI.wawi_data_fg = 1 OR MIG.active_fg = 1 AND WH.global_loc_id_length = 7 AND WH.global_loc_type_cd = '9' AND
    WH_WAWI.country_cd IS NOT NULL);