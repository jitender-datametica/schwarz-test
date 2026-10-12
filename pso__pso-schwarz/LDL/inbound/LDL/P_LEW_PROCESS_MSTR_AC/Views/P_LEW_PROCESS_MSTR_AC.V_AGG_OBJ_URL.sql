CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_AGG_OBJ_URL
(
  dsbrd_id
, phy_doc_id
, mstr_phy_doc_guid
, phy_doc_type_id
, url_mtrc
, sub_nav_prmpt
, load_id
, dwh_inserted
, dwh_updated
)
AS
   SELECT
     dsbrd_id,
   phy_doc_id,
   mstr_phy_doc_guid,
   phy_doc_type_id,
   url_mtrc,
   sub_nav_prmpt,
   load_id,
   dwh_inserted,
   dwh_updated
  FROM p_lew_process_mstr.t_agg_obj_url
;