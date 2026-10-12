CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_SCOPE_COUNTRY_PARAM
AS
SELECT 
      client_id
    
, param_id

    
, dwh_valid_from
    
, dwh_valid_to
    
, version_nr

    
, param_name
    
, param_value
    
, param_descr
    
, param_column_datatype
    
, param_value_char

    
, deleted_fg
    
, current_fg
    
, dwh_created
    
, dwh_updated

FROM p_lew_mart_pit_onprem.v_pit_scope_country_param;