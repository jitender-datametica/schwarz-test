CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_building_hist_1 (client_id, building_sid, addr_sid, building_status_id,
building_status_dt, precontract_dt, contract_dt, construction_start_dt, planned_opening_dt, opening_dt,
planned_closing_dt, closing_dt, closing_reason_id, closing_reason_txt, final_completion_dt, canceling_dt,
canceling_reason_id, temp_closing_fg, reconstruction_fg, purchase_type_id, ownership_type_id, leasing_fg,
own_acquisition_fg, curr_sid, curr_cd, lease_per_year_val, lease_income_per_year_val, sales_area_in_meas, unit_1,
parking_place_cnt, owned_parking_place_cnt, garage_parking_place_cnt, deleted_fg, dwh_valid_from, dwh_valid_to,
dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core.t_building_hist_1 AS V;