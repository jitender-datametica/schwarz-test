CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_MSTR_ATRIB_GUID_2
( atrib_id
, atrib_nm
, guid_id
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     atrib_id,
   atrib_nm,
   guid_id,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.t_ref_mstr_atrib_guid_2
;