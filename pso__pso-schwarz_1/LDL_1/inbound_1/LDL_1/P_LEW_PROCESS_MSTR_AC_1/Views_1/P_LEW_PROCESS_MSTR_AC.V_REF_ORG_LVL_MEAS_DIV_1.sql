CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_ORG_LVL_MEAS_DIV_1
( meas_id
, curr_tot_id
, currency_iso_cd
, divsr
, org_lvl_id_from
, org_lvl_id_to
, unit_text_id
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     meas_id,
   curr_tot_id,
   currency_iso_cd,
   divsr,
   org_lvl_id_from,
   org_lvl_id_to,
   unit_text_id,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.t_ref_org_lvl_meas_div_1
;