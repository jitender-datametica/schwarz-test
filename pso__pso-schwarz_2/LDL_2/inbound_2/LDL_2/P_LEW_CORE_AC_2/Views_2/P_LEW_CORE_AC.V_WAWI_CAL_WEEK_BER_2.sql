CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAWI_CAL_WEEK_BER_2
(
  dat_calendar
, prev_cy_dat_calendar_swd_ber
, prev_cy_dat_calendar_swd_ber_cum
)
AS
   SELECT
     dat_calendar,
   prev_cy_dat_calendar_swd_ber,
   prev_cy_dat_calendar_swd_ber_cum
  FROM p_lew_core.t_wawi_cal_week_ber_2
;