CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ADVERT_THEME_2

AS
SELECT
client_id
,adv_theme_sid
,CAST ( ( adv_theme_sid *100::INTEGER ) +  client_id AS INTEGER )            AS adv_theme_mstr_sid
,adv_theme_descr                                                              AS advert_theme
,dwh_created
FROM p_lew_mart_pit_onprem.t_advert_theme_2
WHERE adv_theme_sid >= 0

UNION ALL

--          Kein Werbethema definiert  ( AND 'empty' but no cases at the moment )            
SELECT
client_id
,adv_theme_sid
,CAST ( ( adv_theme_sid *100::INTEGER ) - client_id AS INTEGER )                AS adv_theme_mstr_sid    --   - client for -ve adv_theme_sid
,adv_theme_descr                                                               AS advert_theme
,dwh_created                    
FROM p_lew_mart_pit_onprem.t_advert_theme_2                    
WHERE adv_theme_sid < 0                    
                    
UNION ALL                    
SELECT DISTINCT                    
client_id                                                                     AS client_id
,-2000::INTEGER - client_id                                                     AS adv_theme_sid                       --  note: have made the sid 
,CAST(((-2000::INTEGER -client_id)*100::INTEGER ) - client_id AS INTEGER )      AS adv_theme_mstr_sid
,'TOT'                                                                         AS advert_theme
,try_to_timestamp('1900-01-01 00:00:00','YYYY-MM_2-DD H24:MI:SS')              AS dwh_created
FROM p_lew_mart_pit_onprem.t_pit_scope_country_param_country_2
WHERE pv_fg = 1     -- only the countries, which are planned to be included in PIT
-- only the countries, which are planned to be included in PIT
;