CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_wh_masterdata_exp_1 AS SELECT DIM.lidl_country_name,
 DIM.lidl_country_cd,
 DIM.delivery_wh_sid,
 DIM.delivery_wh_nr,
 DIM.delivery_wh_name,
 DIM.street_name,
 DIM.house_nr,
 DIM.city_name,
 ADDR.zip_code AS zip,
 DIM.phone_nr,
 WH.longitude,
 WH.latitude,
 DIM.real_open_dt,
 DIM.delivery_region_sid
FROM ldl_p_lew_bil_ac.v_dim_delivery_warehouse_1 AS DIM
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_wh_geo_1 AS WH ON DIM.delivery_wh_sid = WH.wh_loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS LH ON WH.wh_loc_sid = LH.loc_sid AND WH.client_id = LH.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_address_1 AS ADDR ON LH.addr_sid = ADDR.addr_sid AND LH.client_id = ADDR.client_id
WHERE CURRENT_DATE BETWEEN LH.dwh_valid_from AND LH.dwh_valid_to;