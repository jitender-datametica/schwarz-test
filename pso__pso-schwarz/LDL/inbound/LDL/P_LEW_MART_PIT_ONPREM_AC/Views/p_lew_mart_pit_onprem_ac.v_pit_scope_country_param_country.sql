CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_SCOPE_COUNTRY_PARAM_COUNTRY
(
      client_id
    
, country_name
    
, country_ISO2

    
, lang_sid

    
, dwh_valid_from
    
, dwh_valid_to

    
, wawi_fg
    
, pv_fg

    
, deleted_fg

    
, dwh_created
    
, dwh_updated
)
AS
SELECT

client_id
,country_name
,country_ISO2
,lang_sid
,dwh_valid_from
,dwh_valid_to
,wawi_fg
,pv_fg
,deleted_fg
,dwh_created
,dwh_updated
FROM p_lew_mart_pit_onprem.v_pit_scope_country_param_country
WHERE
TRUE;