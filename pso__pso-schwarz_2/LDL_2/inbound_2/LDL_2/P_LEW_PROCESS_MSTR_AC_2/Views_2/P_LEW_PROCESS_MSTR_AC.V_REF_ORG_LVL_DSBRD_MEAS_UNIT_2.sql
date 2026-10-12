CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_ORG_LVL_DSBRD_MEAS_UNIT_2
( int_id
, meas_id
, dsbrd_id
, phy_doc_type_id
, client_ctry_id
, client_id
, aspect_id
, wh_id
, move_to_store_id
, org_lvl_id
, curr_tot_id
, currency_iso_cd
, blk_meas_ord
, pg_no
, pg_meas_ord
, phy_doc_dsbrd_meas_ord
, divsr
, unit_text_desc
)
AS
   SELECT
     int_id,
   meas_id,
   dsbrd_id,
   phy_doc_type_id,
   client_ctry_id,
   client_id,
   aspect_id,
   wh_id,
   move_to_store_id,
   org_lvl_id,
   curr_tot_id,
   currency_iso_cd,
   blk_meas_ord,
   pg_no,
   pg_meas_ord,
   phy_doc_dsbrd_meas_ord,
   divsr,
   unit_text_desc
  FROM p_lew_process_mstr.v_ref_org_lvl_dsbrd_meas_unit_2
;