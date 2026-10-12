CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_PACKAGE_TYPE_1

/*
#DescStart#
#$Revision: 9392 $, $LastChangedBy: cesmeliyadm $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    package_type_cd
    , package_type_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
   package_type_cd
  ,package_type_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
  FROM p_lew_core.t_ref_mdm_package_type_1 ;  