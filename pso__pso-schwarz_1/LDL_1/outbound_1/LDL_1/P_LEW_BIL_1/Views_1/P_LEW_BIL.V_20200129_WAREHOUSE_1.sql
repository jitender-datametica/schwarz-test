

CREATE OR REPLACE VIEW ldl_p_lew_bil.v_20200129_warehouse_1 AS SELECT LCTN.client_id,
 LCTN.loc_sid AS loc_sid_wh,
 LCTN.src_werks,
 LCTN.src_wh_id,
 LCTN.loc_name,
 LCTN.loc_name2,
 LCTN.loc_sid_successor_act,
 LCTN.country_pol_sid,
 LCTN.country_pol_cd,
 LCTN.customer_cd,
 LCTN.global_loc_ctry_cd,
 LCTN.global_loc_id,
 LCTN.global_loc_id_length,
 LCTN.global_loc_type_cd,
 LCTN.closing_dt,
 LCTN.opening_dt,
 LCTN.real_opening_dt,
 LCTN_H.sales_org_sid,
 LCTN_H.pur_org_sid,
 LCTN_H.addr_sid,
 LCTN_H.loc_sid_successor,
 LCTN_H.bus_cal_cd,
 LCTN_H.customer_district_cd,
 LCTN_H.region_cd,
 LCTN_H.archive_fg,
 LCTN_H.demand_plan_active_fg,
 LCTN_H.distribution_channel_cd,
 LCTN_H.assessment_area_cd,
 LCTN_H.division_cd,
 LCTN_H.deleted_fg,
 LCTN_H.dwh_valid_from,
 LCTN_H.dwh_valid_to,
  CASE
  WHEN CURRENT_DATE BETWEEN LCTN_H.dwh_valid_from AND LCTN_H.dwh_valid_to
  THEN 1
  ELSE 0
  END AS dwh_actual_fg,
  CASE
  WHEN LCTN_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN COALESCE(LCTN.real_opening_dt, LCTN.opening_dt, LCTN.sap_creation_wrf1_dt
     ) AND (COALESCE(LCTN.closing_dt, snowconvert_public.int_to_date_udf(80991231)))
  THEN 1
  ELSE 0
  END AS active_fg,
  CASE
  WHEN COALESCE(LCTN.real_opening_dt, LCTN.opening_dt, LCTN.sap_creation_wrf1_dt) > CURRENT_DATE AND (LCTN.closing_dt >
      COALESCE(LCTN.real_opening_dt, LCTN.opening_dt, LCTN.sap_creation_wrf1_dt) OR LCTN.closing_dt IS NULL)
  THEN 1
  ELSE 0
  END AS active_future_fg,
  CASE
  WHEN LCTN.global_loc_id_length = 7 AND LCTN.global_loc_ctry_cd <> 'ZV' AND LCTN.global_loc_type_cd = '9' AND M.migration_dat_valid_from
       <= CURRENT_DATE AND LCTN.country_pol_cd IS NOT NULL OR WO.client_id IS NOT NULL AND M.migration_dat_valid_from >
     CURRENT_DATE
  THEN 1
  ELSE 0
  END AS bges_active_fg
FROM ldl_p_lew_core_ac.v_location_1 AS LCTN
 INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS LCTN_H ON LCTN.loc_sid = LCTN_H.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS M ON LCTN.client_id = M.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_wh_1 AS WO ON LCTN.client_id = WO.client_id AND LCTN.loc_sid = WO.wh_loc_sid AND
     CURRENT_DATE BETWEEN WO.dat_rec_start AND WO.dat_rec_end AND WO.wawi_data_fg = 1 AND COALESCE(LCTN.src_wh_id, - 1)
   > 0
WHERE UPPER(LCTN.wh_store_mark) = 'B';

