CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_GUARANTEE_TYPE_1

/*
#DescStart#
#$Revision: 9392 $, $LastChangedBy: mahdi $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , guarantee_type_cd
    , guarantee_type_descr
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id,
   guarantee_type_cd,
   guarantee_type_descr,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_ref_mdm_guarantee_type_1;