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

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_WAREHOUSES_2
AS
SELECT DISTINCT
    clnt.src_country_lidl_cd                      AS country_lidl_cd
  , COALESCE(org_wh.int_fg     , 0)               AS int_fg
  , COALESCE(org_wh.hq_fg      , 0)               AS hq_fg
  , COALESCE(org_wh.prop_wh_fg , 0)               AS prop_wh_fg
  , COALESCE(org_wh.sales_wh_fg, 0)               AS sales_wh_fg
  , COALESCE(org_wh.supp_wh_fg , 0)               AS supp_wh_fg
  , loc.src_wh_id                                 AS wh_id
  , org_wh.dat_opening                            AS dat_opening
  , TRIM(COALESCE(loc.loc_name2, loc.loc_name))   AS wh_desc
  , org_wh.costcenter_cd                          AS costcenter_cd
  , org_wh.company                                AS company
  , org_wh.global_location_nr                     AS global_location_nr
  
FROM p_lew_core_ac.v_location_2                             AS loc 

INNER JOIN p_lew_core_ac.v_client_2                         AS clnt 
  ON loc.client_id = clnt.client_id

INNER JOIN p_lew_core_ac.v_wawi_org_wh_2                    AS org_wh 
  ON loc.client_id = org_wh.client_id
  AND loc.loc_sid = org_wh.wh_loc_sid

LEFT OUTER JOIN p_lew_core_ac.v_client_migration_per_2      AS mig_sap
  ON loc.client_id = mig_sap.client_id
  AND CURRENT_DATE BETWEEN mig_sap.migration_dat_valid_from AND mig_sap.migration_dat_valid_to

LEFT OUTER JOIN p_lew_core_ac.v_client_migration_per_2      AS mig_wawi
  ON loc.client_id = mig_wawi.client_id
  AND ( CURRENT_DATE < mig_wawi.migration_dat_valid_from
        OR CURRENT_DATE > mig_wawi.migration_dat_valid_to
     )
INNER JOIN p_lew_bil_ac.v_store_to_warehouse_2              AS stwh
  ON org_wh.wh_loc_sid = stwh.loc_sid_wh
  AND org_wh.client_id = stwh.client_id
  AND CURRENT_DATE BETWEEN stwh.dwh_valid_from AND stwh.dwh_valid_to
  AND ((mig_wawi.client_id IS NOT NULL AND stwh.orig_store_nr <> stwh.orig_wh_nr) 
        OR mig_sap.client_id IS NOT NULL) 

WHERE loc.wh_store_mark  ='B'
  AND(( mig_sap.client_id IS NOT NULL AND loc.global_loc_ctry_cd IS NOT NULL AND loc.global_loc_ctry_cd <> 'ZV' 
        AND (CURRENT_DATE BETWEEN COALESCE(loc.opening_dt, org_wh.dat_opening) 
        AND COALESCE(loc.closing_dt, CAST('9999-12-31' AS DATE)) 
          OR COALESCE(loc.opening_dt, org_wh.dat_opening) BETWEEN CURRENT_DATE AND CURRENT_DATE +30))
        OR (mig_wawi.client_id IS NOT NULL 
          AND ((CURRENT_DATE BETWEEN COALESCE(loc.opening_dt, org_wh.dat_opening) AND COALESCE(loc.closing_dt, CAST('9999-12-31' AS DATE))) 
            OR COALESCE(loc.opening_dt, org_wh.dat_opening) BETWEEN CURRENT_DATE AND CURRENT_DATE+30))) 
  AND CURRENT_DATE BETWEEN org_wh.dat_rec_start AND org_wh.dat_rec_end
;