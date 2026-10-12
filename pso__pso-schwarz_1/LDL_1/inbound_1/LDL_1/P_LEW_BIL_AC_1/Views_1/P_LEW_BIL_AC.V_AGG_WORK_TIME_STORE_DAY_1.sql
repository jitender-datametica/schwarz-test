CREATE OR REPLACE VIEW p_lew_bil_ac.v_agg_work_time_store_day_1 (
    client_id
    , loc_sid_store
    , dwh_cal_dt
    , work_time_gross_hr
    , work_time_net_hr
    , break_hr
    , perform_relev_absence_hr
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
   client_id,
   loc_sid_store,
   dwh_cal_dt,
   work_time_gross_hr,
   work_time_net_hr,
   break_hr,
   perform_relev_absence_hr,
   dwh_load_id,
   dwh_created,
   dwh_updated
   FROM p_lew_bil.t_agg_work_time_store_day_1
   ;


