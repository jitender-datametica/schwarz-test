create or replace view SZD_PRODUCTION.FE_MSTR_LIFECYCLE.MV_L_LIFECYCLE_RVM_CLEANING_TYPE(
	CLEANING_TYPE_CD,
	CLEANING_TYPE_DESCR_EN,
	CLEANING_TYPE_DESCR_DE,
	CLEANING_TYPE_DESCR
) as SELECT
 core.t_dim_rvm_cleaning_type.cleaning_type_cd
,core.t_dim_rvm_cleaning_type.cleaning_type_descr_en
,core.t_dim_rvm_cleaning_type.cleaning_type_descr_de
,core.t_dim_rvm_cleaning_type.cleaning_type_descr
FROM 
core.t_dim_rvm_cleaning_type
;