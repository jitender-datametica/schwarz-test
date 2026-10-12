CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_PHDOC_TYP_ACT_2
( phy_doc_type_id
, phy_doc_type_desc
, phy_doc_type_ord
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     phy_doc_type_id,
   phy_doc_type_desc,
   phy_doc_type_ord,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.v_ref_phdoc_typ_act_2
;