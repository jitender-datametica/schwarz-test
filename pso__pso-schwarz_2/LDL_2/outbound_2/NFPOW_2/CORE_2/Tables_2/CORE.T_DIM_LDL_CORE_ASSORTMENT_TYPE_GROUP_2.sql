/* --------------------------------------------------------------------------------
   DDL for table: t_dim_ldl_core_assortment_type_group_2
   generated from Powerdesigner on Mittwoch, 5. März 2025 11:56:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_ldl_core_assortment_type_group_2 (
ldl_core_assort_type_grp_cd STRING(100) NOT NULL
OPTIONS(description='Code of the group of types of the overall Lidl core assortment defined by business.'),
ldl_core_assort_type_grp_name STRING(100)
OPTIONS(description='Name of the group of types of the overall Lidl core assortment defined by business.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_core_assort_type_grp_cd) NOT ENFORCED
) OPTIONS(description='Groups of types of the overall Lidl core assortment defined by business.');