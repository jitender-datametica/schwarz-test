CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_store_masterdata_exp AS SELECT C.country_name AS lidl_country_name,
 C.src_country_lidl_cd AS lidl_country_cd,
 S.loc_sid AS store_sid,
 S.src_orig_store_nr AS store_nr,
 S.loc_name AS store_name,
 A.street_name,
 A.house_nr,
 A.city_name,
 A.zip,
 A.phone_nr,
 A.longitude,
 A.latitude,
 BH.opening_dt AS real_open_dt,
 BH.closing_dt AS close_dt,
 COALESCE(ROUND(CAST(TRIM(SUBSTR(CAST(delivery_gl_region.client_id AS STRING), 1, 39)) || TRIM(SUBSTR(CAST(delivery_gl_region.gl_region_id AS STRING), 1, 39)) AS BIGNUMERIC)
   , 0), - 1 * S.client_id) AS delivery_region_sid,
 COALESCE(WOSA.mis_store_active_fg, 1) AS store_active_fg,
 SH.test_store_fg
FROM ldl_p_lew_core.t_location AS S
 INNER JOIN ldl_p_lew_core.t_location_hist AS SH ON S.client_id = SH.client_id AND S.loc_sid = SH.loc_sid AND
    CURRENT_DATE BETWEEN SH.dwh_valid_from AND SH.dwh_valid_to AND SH.deleted_fg = 0
 INNER JOIN ldl_p_lew_core.t_client AS L ON S.client_id = L.client_id
 INNER JOIN ldl_p_lew_core.t_country AS C ON L.src_country_lidl_cd = C.src_country_lidl_cd
 INNER JOIN ldl_p_lew_core_ac.v_location_building_hist AS LBH ON S.client_id = LBH.client_id AND S.loc_sid = LBH.loc_sid
      AND CURRENT_DATE BETWEEN LBH.dwh_valid_from AND LBH.dwh_valid_to AND LBH.deleted_fg = 0
 INNER JOIN ldl_p_lew_core_ac.v_building_hist AS BH ON LBH.client_id = BH.client_id AND LBH.building_sid = BH.building_sid
       AND CURRENT_DATE BETWEEN BH.dwh_valid_from AND BH.dwh_valid_to AND BH.deleted_fg = 0 AND (CURRENT_DATE BETWEEN BH
      .opening_dt AND BH.closing_dt OR CURRENT_DATE >= BH.opening_dt AND BH.closing_dt IS NULL OR CURRENT_DATE <= BH.closing_dt
       AND BH.opening_dt IS NULL)
 LEFT JOIN ldl_p_lew_core_ac.v_address AS A ON BH.client_id = A.client_id AND BH.addr_sid = A.addr_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_act AS WOSA ON S.loc_sid = WOSA.st_loc_sid AND S.client_id = WOSA.client_id
   
 LEFT JOIN (SELECT OWSK.client_id,
   OWSK.wh_loc_sid,
   RGR.gl_region_id,
   RGR.gl_region_desc AS delivery_region_manager_name
  FROM ldl_p_lew_core_ac.v_wawi_org_wh_skey AS OWSK
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_gl_region AS RGR ON OWSK.client_id = RGR.client_id AND OWSK.gl_region_id =
     RGR.gl_region_id
  WHERE OWSK.aspect_id = 1) AS delivery_gl_region ON WOSA.wh_loc_sid = delivery_gl_region.wh_loc_sid AND WOSA.client_id
   = delivery_gl_region.client_id
WHERE A.longitude IS NOT NULL
 AND A.latitude IS NOT NULL;