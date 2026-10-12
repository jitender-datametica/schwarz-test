CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem_ac.v_pit_apt_core_item_promotion_medium_2 (client_id, item_sid,
promotion_dt, advertising_medium_cd, advertising_medium_pos, deleted_fg, dwh_load_id, dwh_created, dwh_updated) AS
SELECT *
FROM ldl_p_lew_mart_pit_onprem.v_pit_apt_core_item_promotion_medium_2 AS ACIPM;