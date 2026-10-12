CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_BUYER_1
(
   client_id
    , buyer_sid
    , src_user_doc_ref
    , cbx_user_version_nr
    , buyer_cd
    , buyer_forename
    , buyer_surname
    , buyer_email
    , buyer_notes
    , buyer_manager_abbr_name
    , sso_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
      client_id
   , buyer_sid
   , src_user_doc_ref
   , cbx_user_version_nr
   , buyer_cd
   , buyer_forename
   , buyer_surname
   , buyer_email
   , buyer_notes
   , buyer_manager_abbr_name
   , sso_name
   , dwh_load_id
   , dwh_created
   , dwh_updated
  FROM p_lew_core.t_mdm_buyer_1 ;