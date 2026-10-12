CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ZKP_ETL_SYS_REVISION_LOAD_DAY_WRK as
   SELECT	
      dat_calendar,	
   load_in_progress_fg	
   FROM p_lew_mart_msi.t_msi_sys_revision_load_day_wrk	
;