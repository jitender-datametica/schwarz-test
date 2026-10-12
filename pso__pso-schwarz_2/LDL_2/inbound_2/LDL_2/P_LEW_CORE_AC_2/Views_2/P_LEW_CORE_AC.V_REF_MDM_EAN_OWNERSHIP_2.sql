CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_EAN_OWNERSHIP_2
/*
#DescStart#
#$Revision: 8238 $, $LastChangedBy: aketley $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , ean_ownership_cd
    , ean_ownership
    , dwh_load_id
    , dwh_created
    , dwh_updated

)
AS
   SELECT
       client_id,
   ean_ownership_cd,
   ean_ownership,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_ref_mdm_ean_ownership_2
;