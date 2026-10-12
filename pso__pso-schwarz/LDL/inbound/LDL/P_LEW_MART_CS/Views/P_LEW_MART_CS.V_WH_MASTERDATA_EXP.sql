CREATE OR REPLACE VIEW p_lew_mart_cs.v_wh_masterdata_exp 
AS 
SELECT   
  dim.lidl_country_name
, dim.lidl_country_cd
, dim.delivery_wh_sid
, dim.delivery_wh_nr
, dim.delivery_wh_name
, dim.street_name
, dim.house_nr
, dim.city_name
, addr.zip_code as zip
, dim.phone_nr
, wh.longitude
, wh.latitude
, dim.real_open_dt
, dim.delivery_region_sid
FROM p_lew_bil_ac.v_dim_delivery_warehouse dim

INNER JOIN p_lew_core_ac.v_wawi_ref_wh_geo wh 
 ON wh.wh_loc_sid = dim.delivery_wh_sid

INNER JOIN p_lew_core_ac.v_location_hist AS lh
 ON wh.wh_loc_sid = lh.loc_sid
AND wh.client_id = lh.client_id

LEFT OUTER JOIN  p_lew_core_ac.v_address AS addr
 ON lh.addr_sid = addr.addr_sid
AND lh.client_id = addr.client_id
   
WHERE CURRENT_DATE BETWEEN lh.dwh_valid_from AND lh.dwh_valid_to
;