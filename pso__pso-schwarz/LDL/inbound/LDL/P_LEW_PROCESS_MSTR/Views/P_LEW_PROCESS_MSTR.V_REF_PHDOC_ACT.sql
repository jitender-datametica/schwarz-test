CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_PHDOC_ACT
 (
   phy_doc_id
 , phy_doc_desc
 , mstr_phy_doc_guid
 , phy_doc_type_id
 , deleted_fg
 , dwh_valid_from
 , dwh_valid_to
 , dwh_load_id
 , dwh_created
 , dwh_updated
 )
 AS
    SELECT
      phy_doc_id,
    phy_doc_desc,
    mstr_phy_doc_guid,
    phy_doc_type_id,
    deleted_fg,
    dwh_valid_from,
    dwh_valid_to,
    dwh_load_id,
    dwh_created,
    dwh_updated
FROM p_lew_process_mstr.t_ref_phdoc
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
AND deleted_fg = 0;