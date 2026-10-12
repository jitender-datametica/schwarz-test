CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_ldl_core_assortment_type_group_1 (ldl_core_assort_type_grp_cd
OPTIONS(description='Code of the group of types of  the overall Lidl core assortment defined by Business.'),
ldl_core_assort_type_grp_name
OPTIONS(description='Name of the group of types of  the overall Lidl core assortment defined by Business.'),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = `GROUPS OF TYPES OF  THE OVERALL LIDL CORE ASSORTMENT DEFINED BY BUSINESS.`) AS SELECT *
FROM nfpow_core.t_dim_ldl_core_assortment_type_group_1;