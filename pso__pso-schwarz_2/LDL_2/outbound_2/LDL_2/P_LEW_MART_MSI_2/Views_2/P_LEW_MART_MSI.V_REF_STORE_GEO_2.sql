CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_store_geo_2 AS SELECT client_id,
 st_loc_sid AS store_id,
 latitude,
 longitude
FROM ldl_p_lew_core_ac.v_wawi_ref_store_geo_2
GROUP BY client_id,
 store_id,
 latitude,
 longitude;