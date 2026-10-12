/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for <schema name>.<table or view name>
#----------------------------------------------------------------------------
# History:
#   1.0            29.08.2023        Ulrich Roß         Add COALESCE(loc.opening_dt, org_wh.dat_opening) for missing WH
#                                                       User Story 519295
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_warehouses AS SELECT DISTINCT CLNT.src_country_lidl_cd AS country_lidl_cd,
 COALESCE(ORG_WH.int_fg, 0) AS int_fg,
 COALESCE(ORG_WH.hq_fg, 0) AS hq_fg,
 COALESCE(ORG_WH.prop_wh_fg, 0) AS prop_wh_fg,
 COALESCE(ORG_WH.sales_wh_fg, 0) AS sales_wh_fg,
 COALESCE(ORG_WH.supp_wh_fg, 0) AS supp_wh_fg,
 LOC.src_wh_id AS wh_id,
 ORG_WH.dat_opening,
 TRIM(COALESCE(LOC.loc_name2, LOC.loc_name)) AS wh_desc,
 ORG_WH.costcenter_cd,
 ORG_WH.company,
 ORG_WH.global_location_nr
FROM ldl_p_lew_core_ac.v_location AS LOC
 INNER JOIN ldl_p_lew_core_ac.v_client AS CLNT ON LOC.client_id = CLNT.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh AS ORG_WH ON LOC.client_id = ORG_WH.client_id AND LOC.loc_sid = ORG_WH.wh_loc_sid
   
 LEFT JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG_SAP ON LOC.client_id = MIG_SAP.client_id AND CURRENT_DATE
   BETWEEN MIG_SAP.migration_dat_valid_from AND MIG_SAP.migration_dat_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_client_migration_per AS MIG_WAWI ON LOC.client_id = MIG_WAWI.client_id AND (CURRENT_DATE
     < MIG_WAWI.migration_dat_valid_from OR CURRENT_DATE > MIG_WAWI.migration_dat_valid_to)
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse AS STWH ON ORG_WH.wh_loc_sid = STWH.loc_sid_wh AND ORG_WH.client_id =
     STWH.client_id AND CURRENT_DATE BETWEEN STWH.dwh_valid_from AND STWH.dwh_valid_to AND (MIG_WAWI.client_id
     IS NOT NULL AND STWH.orig_store_nr <> STWH.orig_wh_nr OR MIG_SAP.client_id IS NOT NULL)
WHERE LOC.wh_store_mark = 'B'
 AND (LOC.global_loc_ctry_cd <> 'ZV' AND (CURRENT_DATE BETWEEN COALESCE(LOC.opening_dt, ORG_WH.dat_opening) AND (COALESCE(LOC
          .closing_dt, DATE('9999-12-31'))) OR COALESCE(LOC.opening_dt, ORG_WH.dat_opening) BETWEEN CURRENT_DATE AND (DATE_ADD(CURRENT_DATE
          ,INTERVAL 30 DAY))) AND MIG_SAP.client_id IS NOT NULL OR MIG_WAWI.client_id IS NOT NULL AND (CURRENT_DATE
       BETWEEN COALESCE(LOC.opening_dt, ORG_WH.dat_opening) AND (COALESCE(LOC.closing_dt, DATE('9999-12-31'))) OR
       COALESCE(LOC.opening_dt, ORG_WH.dat_opening) BETWEEN CURRENT_DATE AND (DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY)))
  )
 AND CURRENT_DATE BETWEEN ORG_WH.dat_rec_start AND ORG_WH.dat_rec_end;