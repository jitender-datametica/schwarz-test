CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_LDL_CORE_ASSORTMENT_TYPE_GROUP (
   ldl_core_assort_type_grp_cd              COMMENT 'Code of the group of types of  the overall Lidl core assortment defined by Business.'
  ,ldl_core_assort_type_grp_name            COMMENT 'Name of the group of types of  the overall Lidl core assortment defined by Business.'
  ,dwh_created_tmsp                         COMMENT 'Timestamp of the initial insertion of the data record into the DWH.'
  ,dwh_updated_tmsp                         COMMENT 'Timestamp of the last change to the data record in the DWH.'
  ,dwh_src_tmsp                             COMMENT 'Timestamp of source extraction.'
)
COMMENT = 'Groups of types of  the overall Lidl core assortment defined by Business.'
AS SELECT
   ldl_core_assort_type_grp_cd
  ,ldl_core_assort_type_grp_name
  ,dwh_created_tmsp
  ,dwh_updated_tmsp
  ,dwh_src_tmsp
FROM CORE.T_DIM_LDL_CORE_ASSORTMENT_TYPE_GROUP
;