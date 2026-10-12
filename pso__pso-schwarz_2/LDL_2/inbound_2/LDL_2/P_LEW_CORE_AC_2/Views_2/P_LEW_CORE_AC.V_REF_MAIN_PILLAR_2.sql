CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MAIN_PILLAR_2

/*
#DescStart#
#$Revision: 9392 $, $LastChangedBy: cesmeliyadm $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    main_pillar_cd
    , main_pillar_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
   main_pillar_cd
  ,main_pillar_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
  FROM p_lew_core.t_ref_main_pillar_2 ;