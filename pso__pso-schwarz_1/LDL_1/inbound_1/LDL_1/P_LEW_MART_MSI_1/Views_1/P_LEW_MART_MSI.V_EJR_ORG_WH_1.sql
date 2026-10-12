/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_ORG_WH_1
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  23.10.2017    Proch,Marika             Anpassung der Datenbank von f_msi_data  zu f_lew_mart_msi.t_msi_sys_revision_log_1
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_1 mit V_WAREHOUSE_1 ersetzt
#  1.5  18.06.2021    Wandtke,Andrzej          AP0090657_zkp_transall REP1-14602 20210608_2859_ZKP_TransAll remove table v_wawi_org_wh_act_1, use v_wawi_org_wh_1 mit outer join.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_ORG_WH_1 AS
SELECT	
     wh.client_id
     ,wh.src_wh_id AS wh_id
     ,wh.country_pol_cd AS country_cd
     ,COALESCE(wh.opening_dt, real_opening_dt) AS dat_opening
     ,NULL AS costcenter_cd
     ,NULL AS company
     ,NULL AS order_buying_list_cd
     ,NULL AS vat_region_nr
     ,NULL AS region_cd
     ,NULL AS stock_plain
     ,NULL AS sponsion
     ,NULL AS global_location_nr
     ,wh.loc_name AS wh_desc
     ,NULL AS distribute_wh_fg
     ,NULL AS int_fg
     ,NULL AS hq_fg
     ,NULL AS prop_wh_fg
     ,NULL AS sales_wh_fg
     ,NULL AS supp_wh_fg
     ,NULL AS wawi_data_fg
     ,NULL AS ovis_data_fg
     ,to_varchar(revlog.dat_formdate_from, 'YYYYMMDD') || to_varchar(revlog.dat_formdate_until, 'YYYYMMDD') AS materialize_id
     ,revlog.revision_test_fg	
     ,revlog.revision_fg	
     ,revlog.revision_user	
     ,revlog.revision_reason_cd	
FROM p_lew_bil_ac.v_warehouse_1 AS wh

LEFT OUTER JOIN p_lew_mart_msi.t_msi_sys_revision_log_1 AS revlog
ON  wh.client_id = revlog.client_id
AND wh.loc_sid_wh  =  revlog.wh_loc_sid
AND (revlog.orig_store_nr IS NULL AND revlog.timestamp_delete IS NULL)

LEFT OUTER JOIN p_lew_core_ac.v_client_migration_per_1 mig
ON wh.client_id = mig.client_id

LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_wh_1 wh_wawi
ON   wh.loc_sid_wh = wh_wawi.wh_loc_sid
AND  wh.client_id = wh_wawi.client_id 
AND  Current_Date BETWEEN wh_wawi.dat_rec_start AND wh_wawi.dat_rec_end

WHERE wh.dwh_actual_fg = 1
AND wh.dwh_actual_fg = 1 
AND ( wh_wawi.wawi_data_fg = 1 OR 
(
mig.active_fg = 1 
AND wh.global_loc_id_length = 7
AND wh.global_loc_type_cd = '9' 
AND country_cd IS NOT NULL 
) 
);
