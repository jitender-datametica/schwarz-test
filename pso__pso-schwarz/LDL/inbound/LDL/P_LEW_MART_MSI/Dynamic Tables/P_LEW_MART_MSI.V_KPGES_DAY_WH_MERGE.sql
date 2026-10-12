create or replace dynamic table LDL_PRODUCTION.P_LEW_MART_MSI.V_KPGES_DAY_WH_MERGE(
	CLIENT_ID,
	WH_ID,
	ASPECT_ID,
	INDICATOR_ID,
	DAT_FORMDATE,
	VAL_INDICATOR,
	CURRENCY_ISO_CD,
	DAT_DAYEND
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_P_DYNAMIC_TABLE_P_LEW_MART_MSI
 as
   SELECT   
   iday.client_id
   ,iday.org_unit_nr AS wh_id   
   ,CASE WHEN iday.org_type_id = 50 THEN 1 ELSE 2 END AS aspect_id  
   ,iday.indicator_id   
   ,iday.dat_formdate   
   ,CASE WHEN iday.indicator_id IN (117,120,125,126,133,135,136,155,156,157,163,168 
   ,169,170,172,174,177,179,203,204,209,210,212,216,228,229,230,238,240,242,250 
   ,251,255,256,257,258,259,260,261,270,271,272,273,280,281,282,283,284,286)    
   THEN iday.val_indicator / cry.rate_currency_exchange ELSE iday.val_indicator END AS val_indicator    
   ,cry.currency_iso_cd 
   ,iday.dat_dayend 
 FROM p_lew_bil_ac.v_kpi_day AS iday    
 INNER JOIN (
        SELECT
        b.client_id
        , curr_cd_from AS currency_iso_cd
        , curr_cd_to AS to_currency_iso_cd
        , exchange_rate AS rate_currency_exchange
        FROM        p_lew_core_ac.v_exchange_rate_known_hist    AS b
        INNER JOIN  p_lew_core_ac.v_exchange_rate_type          AS c
        ON c.client_id             = b.client_id
        AND c.x_rate_type_sid     = b.x_rate_type_sid
        AND c.src_kurst         = '@BEWE'
        WHERE   CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
        AND     CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
    ) AS cry
 ON  iday.client_id = cry.client_id
 AND iday.indicator_type_id = 1
 AND iday.org_type_id IN (50,60)
 -- für 322 und 325 Landeswährung entfernen und nur in EUR anzeigen
 WHERE iday.indicator_id  NOT IN (322,325) 
    UNION ALL
 SELECT
 iday.client_id
 , iday.org_unit_nr AS wh_id
 , CASE WHEN iday.org_type_id = 50 THEN 1 ELSE 2 END AS aspect_id
 , iday.indicator_id
 , iday.dat_formdate
 , iday.val_indicator  AS val_indicator
 , 'EUR' AS currency_iso_cd
 , iday.dat_dayend
 FROM p_lew_bil_ac.v_kpi_day AS iday
 WHERE iday.indicator_type_id = 1
 AND iday.indicator_id IN (322,325) 
 AND iday.org_type_id IN (50,60)
;
