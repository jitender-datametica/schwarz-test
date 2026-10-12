CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_SCOPE_COUNTRY_PARAM_LOG_1

AS
SELECT
      pa.param_id
    , pa.client_id
    , pa.param_value_char::VARCHAR(50)           AS param_value
    , par.param_name
    , par.param_descr
    , par.param_column_datatype

FROM p_lew_mart_pit_onprem.t_pit_scope_country_param_1 AS pa

INNER JOIN p_lew_mart_pit_onprem.t_pit_scope_country_param_ref_1 AS par
        ON pa.param_id = par.param_id

WHERE pa.current_fg = 1
  AND pa.deleted_fg = 0
  AND Current_Date BETWEEN pa.dwh_valid_from AND pa.dwh_valid_to;