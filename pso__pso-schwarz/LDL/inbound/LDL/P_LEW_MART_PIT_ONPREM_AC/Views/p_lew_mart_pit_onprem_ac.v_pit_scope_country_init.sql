CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_SCOPE_COUNTRY_INIT
(

      client_id
    
, dwh_valid_from
    
, dwh_valid_to
    
, deleted_fg
    
, dwh_created
    
, dwh_updated
)
AS
SELECT
client_id
,dwh_valid_from
,dwh_valid_to
,deleted_fg
,dwh_created
,dwh_updated
FROM p_lew_mart_pit_onprem.v_pit_scope_country_init;