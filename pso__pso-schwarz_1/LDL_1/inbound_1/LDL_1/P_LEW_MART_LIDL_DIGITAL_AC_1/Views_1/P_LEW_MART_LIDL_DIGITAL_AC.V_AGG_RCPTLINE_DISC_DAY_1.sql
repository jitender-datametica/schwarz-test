CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_RCPTLINE_DISC_DAY_1
(
   client_id
 , loc_sid
 , dwh_cal_dt
 , lidlplus_disc_fg
 , discount_val
 , load_id
 , dwh_inserted
 , dwh_updated
)
AS
SELECT
client_id,
loc_sid,
dwh_cal_dt,
lidlplus_disc_fg,
discount_val,
load_id,
dwh_inserted,
dwh_updated
FROM p_lew_mart_lidl_digital.t_agg_rcptline_disc_day_1
;


