/* --------------------------------------------------------------------------------
   DDL for table: t_dim_ldl_core_assortment_type_group
   generated from Powerdesigner on Mittwoch, 5. März 2025 11:56:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LDL_CORE_ASSORTMENT_TYPE_GROUP DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_core_assort_type_grp_cd         VARCHAR(100)     NOT NULL COMMENT 'Code of the group of types of the overall Lidl core assortment defined by business.',
   ldl_core_assort_type_grp_name       VARCHAR(100)     COMMENT 'Name of the group of types of the overall Lidl core assortment defined by business.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_LDL_CORE_ASSORTMENT_TYPE_GROUP PRIMARY KEY (ldl_core_assort_type_grp_cd) NOT ENFORCED 
)  COMMENT = 'Groups of types of the overall Lidl core assortment defined by business.';
