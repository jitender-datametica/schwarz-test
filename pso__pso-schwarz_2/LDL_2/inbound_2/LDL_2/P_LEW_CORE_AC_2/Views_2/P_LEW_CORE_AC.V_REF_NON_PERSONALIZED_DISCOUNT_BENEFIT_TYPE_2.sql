create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_NON_PERSONALIZED_DISCOUNT_BENEFIT_TYPE_2(
	NP_DISCOUNT_BENEFIT_TYPE_CD COMMENT 'Code of the benefit type for the non personalized discount.',
	NP_DISCOUNT_BENEFIT_TYPE_DESCR COMMENT 'Description of the benefit type for the non personalized discount.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the different benefits of a non personalized discount.'
 as 
    SELECT 
        np_discount_benefit_type_cd,
        np_discount_benefit_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_NON_PERSONALIZED_DISCOUNT_BENEFIT_TYPE_2 ;
