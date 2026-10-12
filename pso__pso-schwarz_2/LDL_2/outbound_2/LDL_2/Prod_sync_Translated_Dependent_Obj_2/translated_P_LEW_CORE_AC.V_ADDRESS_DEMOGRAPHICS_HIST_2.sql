CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_address_demographics_hist_2 (client_id, addr_sid, inhabitants_10min_by_car_cnt
, inhabitants_5min_by_car_cnt, inhabitants_500m_cnt, inhabitants_1000m_cnt, inhabitants_city_cnt,
inhabitants_catchment_area_cnt, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT *
FROM ldl_p_lew_core.t_address_demographics_hist_2;