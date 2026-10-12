CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_PALLET_RCV_WH_DAY_SPOT_2(	
client_id	
, wh_id	
, aspect_id	
, currency_iso_cd	
, business_yr	
, month_id	
, week_id	
, cy_partial_week	
, dat_calendar	
, cy_month_sequence	
, last_cwd_fg	
, last_cmd_fg	
, record_type	
, dup_fg	
, pallet_rcv	
, pallet_time	
, p1y_cwd_pallet_rcv	
, p1y_cwd_pallet_time	
, p1y_cmd_pallet_rcv	
, p1y_cmd_pallet_time	
)	
AS	
   SELECT	
   client_id,	
   wh_id,	
   aspect_id,	
   currency_iso_cd,	
   business_yr,	
   month_id,	
   week_id,	
   cy_partial_week,	
   dat_calendar,	
   cy_month_sequence,	
   last_cwd_fg,	
   last_cmd_fg,	
   record_type,	
   dup_fg,	
   pallet_rcv,	
   pallet_time,	
   p1y_cwd_pallet_rcv,	
   p1y_cwd_pallet_time,	
   p1y_cmd_pallet_rcv,	
   p1y_cmd_pallet_time	
  FROM p_lew_mart_msi.t_pallet_rcv_wh_day_spot_2	
;