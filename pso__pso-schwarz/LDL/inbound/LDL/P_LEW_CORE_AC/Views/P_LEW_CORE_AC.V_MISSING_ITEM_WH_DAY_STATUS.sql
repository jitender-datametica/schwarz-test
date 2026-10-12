CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MISSING_ITEM_WH_DAY_STATUS

(
    client_id
    , loc_sid
    , pick_area_id
    , item_sid
    , missing_item_event_id
    , missing_status_start_tmsp
    , missing_status_end_tmsp
    , missing_status_cd
    , missing_item_status_cd
    , missing_reason_cd
    , temp_missing_fg
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , loc_sid
    , pick_area_id
    , item_sid
    , missing_item_event_id
    , missing_status_start_tmsp
    , missing_status_end_tmsp
    , missing_status_cd
    , missing_item_status_cd
    , missing_reason_cd
    , temp_missing_fg
    , dwh_cal_dt
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_core.t_missing_item_wh_day_status
;