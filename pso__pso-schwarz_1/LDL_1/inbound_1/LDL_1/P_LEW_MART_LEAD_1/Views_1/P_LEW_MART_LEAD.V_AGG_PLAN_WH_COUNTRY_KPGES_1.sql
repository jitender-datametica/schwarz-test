create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_PLAN_WH_COUNTRY_KPGES_1(
	CLIENT_ID,
	WH_ID,
	ASPECT_ID,
	INDICATOR_ID,
	BYR,
	CY_MONTH,
	VAL_INDICATOR,
	CURRENCY_ISO_CD,
	CURR_TOT_ID
) as
 SELECT   
        imon.client_id
       ,imon.org_unit_nr AS wh_id 
       ,CASE 
            WHEN imon.org_type_id = 50 
            THEN 1 
            ELSE 2 
            END AS aspect_id   
       ,imon.indicator_id
       ,cm.busyear AS byr
       ,CAST(CONCAT(imon.cy
       ,CASE 
            WHEN LENGTH(imon.month_id) = 1 
            THEN CAST(LPAD(imon.month_id,2,0) AS VARCHAR(2)) 
            ELSE CAST(imon.month_id AS VARCHAR(2)) END) AS DECIMAL(6)) AS cy_month
       ,CASE 
            WHEN imon.indicator_id IN (105,108,112,117,120,125,126,133,135,136,146,155
   ,156,157,158,161,162,163,168,169,170,172,174,177,179,203,204,209,210,212,216  
   ,225,228,229,230,238,240,242,243,244,250,251,252,256,257,258,259,260,261,270  
   ,271,272,273,276,280,281,282,283,284,286,288,289,151,293,302,304,306,308,310,312,314)   
            THEN imon.val_indicator / cry.rate_currency_exchange 
            ELSE imon.val_indicator 
            END AS val_indicator
        ,cry.currency_iso_cd 
        ,cry.curr_tot_id
   FROM p_lew_core_ac.v_wawi_indicator_month_1 imon
   INNER JOIN p_lew_mart_lead.v_ref_currency_1 AS cry   
   ON  imon.client_id = cry.client_id  
   INNER JOIN p_lew_core_ac.v_cal_month_1 cm
   ON imon.cy = cm.cy
   AND imon.month_id = cm.month_id
   WHERE imon.org_type_id IN (50, 60) 
   AND imon.indicator_type_id = 2   
   UNION
   SELECT   
        imon.client_id
       ,imon.client_id*-1 AS wh_id 
       ,1 AS aspect_id   
       ,imon.indicator_id
       ,cm.busyear AS byr
       ,CAST(CONCAT(imon.cy
       ,CASE 
            WHEN LENGTH(imon.month_id) = 1 
            THEN CAST(LPAD(imon.month_id,2,0) AS VARCHAR(2)) 
            ELSE CAST(imon.month_id AS VARCHAR(2)) END) AS DECIMAL(6)) AS cy_month
       ,CASE 
            WHEN imon.indicator_id IN (105,108,112,117,120,125,126,133,135,136,146,155
   ,156,157,158,161,162,163,168,169,170,172,174,177,179,203,204,209,210,212,216  
   ,225,228,229,230,238,240,242,243,244,250,251,252,256,257,258,259,260,261,270  
   ,271,272,273,276,280,281,282,283,284,286,288,289,151,293,302,304,306,308,310,312,314)   
            THEN imon.val_indicator / cry.rate_currency_exchange 
            ELSE imon.val_indicator 
            END AS val_indicator
        ,cry.currency_iso_cd 
        ,cry.curr_tot_id
   FROM p_lew_core_ac.v_wawi_indicator_month_1 imon
   INNER JOIN p_lew_mart_lead.v_ref_currency_1 AS cry   
   ON  imon.client_id = cry.client_id  
   INNER JOIN p_lew_core_ac.v_cal_month_1 cm
   ON imon.cy = cm.cy
   AND imon.month_id = cm.month_id
   WHERE imon.org_type_id IN (20) 
   AND imon.indicator_type_id = 2   
   ;
