CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_PLT_WA_WH_DAY_SPOT(	
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
, plt_rcv	
, plt_time_wa	
, p1y_cwd_plt_rcv	
, p1y_cwd_plt_time_wa	
, p1y_cmd_plt_rcv	
, p1y_cmd_plt_time_wa	
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
   plt_rcv,	
   plt_time_wa,	
   p1y_cwd_plt_rcv,	
   p1y_cwd_plt_time_wa,	
   p1y_cmd_plt_rcv,	
   p1y_cmd_plt_time_wa	
  FROM p_lew_mart_msi.t_plt_wa_wh_day_spot	
;