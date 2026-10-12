CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_we_anlieferbereich_2 (client_id
OPTIONS(description='Indicator of country_2'), wh_id OPTIONS(description='Warehouse number'), wh_staging_area_cd
OPTIONS(description='Warehouse area number'), wh_staging_area_descr OPTIONS(description='Warehouse area description'))
AS SELECT STA.client_id,
 W.src_wh_id AS wh_id,
 STA.wh_staging_area_cd,
 STA.wh_staging_area_descr
FROM ldl_p_lew_core_ac.v_ref_warehouse_staging_area_2 AS STA
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS W ON STA.client_id = W.client_id AND STA.wh_loc_sid = W.loc_sid_wh AND W.dwh_actual_fg
     = 1 AND CURRENT_DATE BETWEEN W.dwh_valid_from AND W.dwh_valid_to;