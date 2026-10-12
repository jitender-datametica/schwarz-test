create or replace dynamic table LDL_PRODUCTION.P_LEW_MART_MSI.V_REPORT_FIXED_EXCHANGE_RATE(
	CLIENT_ID,
	SRC_KURST,
	CURR_CD_FROM,
	CURR_CD_TO,
	CURR_SID_FROM,
	CURR_SID_TO,
	EXCHANGE_RATE,
	ACTIVE_FROM_DT,
	ACTIVE_TO_DT,
	DELETED_FG
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_P_DYNAMIC_TABLE_P_LEW_MART_MSI
 as
           SELECT  xr_kn_h.client_id,  
           xrtyp.src_kurst,   
           xr_kn_h.curr_cd_from, 
           xr_kn_h.curr_cd_to,   
           xr_kn_h.curr_sid_from,   
           xr_kn_h.curr_sid_to,  
           xr_kn_h.exchange_rate,   
           xr_kn_h.active_from_dt,  
           xr_kn_h.active_to_dt, 
           xr_kn_h.deleted_fg 
           FROM p_lew_core_ac.v_exchange_rate_known_hist xr_kn_h  
           INNER JOIN p_lew_core_ac.v_exchange_rate_type xrtyp 
           ON xr_kn_h.client_id=xrtyp.client_id 
           AND xr_kn_h.x_rate_type_sid=xrtyp.x_rate_type_sid   
   
WHERE --nur die aktuellste bekannte Kurs-Zeit-Tabelle:   
   CURRENT_DATE BETWEEN xr_kn_h.dwh_valid_from AND xr_kn_h.dwh_valid_to 
   --UND nur die Berichtswesen-Kurse, diese werden extern geliefert als File und gelten als aktiv für einen langen Zeitraum:  
   AND xrtyp.src_kurst='@BEWE';
