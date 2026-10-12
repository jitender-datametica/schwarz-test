CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_MONTH_BER_1
(	
 dat_calendar_amd	
 , dat_calendar_pmd	
 , dat_calendar_pyd	
 , dat_calendar_pypm	
 , dat_calendar_ppy
 , dat_calendar_pppy	
 , cy_month	
 , prev_month	
  )	
AS	
   SELECT	
    dat_calendar_amd	
    , dat_calendar_pmd	
    , dat_calendar_pyd	
    , dat_calendar_pypm	
    , dat_calendar_ppy
    , dat_calendar_pppy	
    , cy_month	
    , prev_month	
   FROM p_lew_mart_msi.t_cal_month_ber_1	
;