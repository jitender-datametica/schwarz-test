CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_LIDLPLUS_CORRECTION_RECEIPTHEADER_LOG_2

(
    client_id
      , yearmonth
      , wh_id
      , orig_store_nr
      , dwh_cal_dt
      , number_of_updated_rows
      , dwh_created

)
AS
SELECT
client_id,
yearmonth,
wh_id,
orig_store_nr,
dwh_cal_dt,
number_of_updated_rows,
dwh_created
FROM p_lew_process.t_lidlplus_correction_receiptheader_log_2
;