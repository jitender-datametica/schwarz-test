CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_MEAS_FMT
( meas_fmt_id
, meas_fmt_colr_desc
, meas_fmt_dec
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     meas_fmt_id,
   meas_fmt_colr_desc,
   meas_fmt_dec,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.t_ref_meas_fmt
;