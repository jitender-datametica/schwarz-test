CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_LDPL_CLIENT_ID_2
( client_id
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     client_id,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_mart_lead.t_ldpl_client_id_2
;