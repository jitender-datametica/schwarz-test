CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_CURRENCY_1
AS	
SELECT 
	DISTINCT curr.client_id							 AS client_id
	,clients.src_country_lidl_cd        			 AS country_lidl_cd
	,curr.curr_cd_from 								 AS orig_curr_cd
	,curr.curr_cd_to 								 AS target_curr_cd
	,curr.exchange_rate								 AS exchange_rate
FROM p_lew_core.t_exchange_rate_known_hist_1 curr

INNER JOIN p_lew_core.t_exchange_rate_type_1 AS rate
	ON curr.client_id = rate.client_id
	AND curr.x_rate_type_sid = rate.x_rate_type_sid

INNER JOIN p_lew_core_ac.v_client_1 clients 
	ON  curr.client_id = clients.client_id

WHERE CURRENT_DATE BETWEEN curr.dwh_valid_from AND curr.dwh_valid_to
	AND CURRENT_DATE BETWEEN curr.active_from_dt AND curr.active_to_dt
	AND curr.deleted_fg = 0
ORDER BY curr.client_id, curr.curr_cd_from, curr.curr_cd_to
;