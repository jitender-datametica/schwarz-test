CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_SCOPE_COUNTRY_PARAM_REF_2
AS
SELECT
      param_id
    , param_name
    , param_descr
    , param_column_datatype
    , pit_initial_fg
    , pit_reagg_fg
    , dwh_created
    , dwh_upDATEd
FROM p_lew_mart_pit_onprem.t_pit_scope_country_param_ref_2;