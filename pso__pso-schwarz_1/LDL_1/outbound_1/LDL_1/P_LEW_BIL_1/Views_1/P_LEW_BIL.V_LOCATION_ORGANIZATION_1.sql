CREATE OR REPLACE VIEW ldl_p_lew_bil.v_location_organization_1 (client_id, loc_sid_wh, loc_sid_store, sales_manager_id,
sales_manager_name, account_manager_id, account_manager_name, general_manager_id, general_manager_name, organisation_id
, district_cd, active_from_dt, active_to_dt, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_actual_fg, active_fg) AS
SELECT client_id,
 loc_sid_wh,
 loc_sid_store,
 sales_manager_id,
 sales_manager_name,
 account_manager_id,
 account_manager_name,
 general_manager_id,
 general_manager_name,
 organisation_id,
 district_cd,
 active_from_dt,
 active_to_dt,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_actual_fg,
 active_fg
FROM ldl_p_lew_bil.t_location_organization_1;