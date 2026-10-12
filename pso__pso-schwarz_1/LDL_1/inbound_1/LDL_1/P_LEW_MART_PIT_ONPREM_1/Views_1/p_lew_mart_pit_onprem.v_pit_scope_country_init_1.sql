CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_SCOPE_COUNTRY_INIT_1

(
      client_id

    , dwh_valid_from
    , dwh_valid_to


    , deleted_fg
    , dwh_created
    , dwh_upDATEd
)
AS
SELECT DISTINCT

client_id
,dwh_valid_from
,dwh_valid_to
,deleted_fg
,dwh_created
,dwh_upDATEd
FROM p_lew_mart_pit_onprem.t_pit_scope_country_init_1
WHERE
   1=1
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND deleted_fg = 0;