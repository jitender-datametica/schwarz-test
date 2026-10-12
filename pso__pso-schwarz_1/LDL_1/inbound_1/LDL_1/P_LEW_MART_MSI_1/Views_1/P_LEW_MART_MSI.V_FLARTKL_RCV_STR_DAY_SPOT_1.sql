CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_FLARTKL_RCV_STR_DAY_SPOT_1
   (	
   client_id	
   , wh_id	
   , aspect_id	
   , store_id	
   , currency_iso_cd	
   , business_yr	
   , month_id	
   , week_id	
   , dat_calendar	
   , last_cwd_fg	
   , last_cmd_fg	
   , dup_fg	
   , val_cnt_asis	
   , val_sum_asis	
   , p1y_cwd_val_cnt	
   , p1y_cmd_val_cnt	
   , p1y_cwd_val_sum	
   , p1y_cmd_val_sum	
   )	
   AS	
      SELECT	
      client_id,	
      wh_id,	
      aspect_id,	
      store_id,	
      currency_iso_cd,	
      business_yr,	
      month_id,	
      week_id,	
      dat_calendar,	
      last_cwd_fg,	
      last_cmd_fg,	
      dup_fg,	
      val_cnt_asis,	
      val_sum_asis,	
      p1y_cwd_val_cnt,	
      p1y_cmd_val_cnt,	
      p1y_cwd_val_sum,	
      p1y_cmd_val_sum	
     FROM p_lew_mart_msi.t_flartkl_rcv_str_day_spot_1	
;