create or replace dynamic table LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_MSI.V_KPGES_PLAN_DAY_COUNTRY_2(
	CLIENT_ID,
	INDICATOR_ID,
	DAT_FORMDATE,
	VAL_INDICATOR,
	CURRENCY_ISO_CD,
	DAT_DAYEND
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_D_DYNAMIC_TABLE_P_LEW_MART_MSI
 as
   /* 
   #DescStart# 
   #$Revision: 10800 $, $LastChangedBy: ekun $  
   #SubjectAreas#: KPGES Views   
   #DescEnd#   
   */ 
   SELECT   
   iday.client_id,   
   iday.indicator_id,   
   iday.dat_formdate,   
   CASE WHEN iday.indicator_id IN (105,108,112,117,120,125,126,133,135,136,146,155, 
      156,157,158,161,162,163,168,169,170,172,174,177,179,203,204,209,210,212,216,  
      225,228,229,230,238,240,242,243,244,250,251,252,256,257,258,259,260,261,270,  
      271,272,273,276,280,281,282,283,284,286,288,289,151,293,302,304,306,308,310,312,314,373,374,375,376,377)   
     THEN iday.val_indicator / cry.rate_currency_exchange ELSE iday.val_indicator END  
   AS val_indicator, 
   cry.currency_iso_cd, 
   iday.dat_dayend   
   
   FROM p_lew_bil_ac.v_kpi_day_2 AS iday 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry   
   ON  iday.client_id = cry.client_id  
   AND iday.org_type_id = 20  
   AND iday.indicator_type_id = 2   
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end 
;
