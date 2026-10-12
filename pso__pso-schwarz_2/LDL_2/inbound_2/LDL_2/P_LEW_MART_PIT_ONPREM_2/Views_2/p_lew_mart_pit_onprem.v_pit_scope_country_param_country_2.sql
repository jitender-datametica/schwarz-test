CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_SCOPE_COUNTRY_PARAM_COUNTRY_2

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
    , dwh_upDATEd
)
AS
   SELECT

   client_id
,   country_name
,   country_ISO2
,   lang_sid
,   dwh_valid_from
,   dwh_valid_to
,   wawi_fg
,   pv_fg
,   deleted_fg
,   dwh_created
,   dwh_upDATEd
   FROM p_lew_mart_pit_onprem.t_pit_scope_country_param_country_2
  WHERE
      1=1
      AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
      AND pv_fg               = 1
      AND deleted_fg          = 0;