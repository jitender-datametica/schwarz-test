create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_NON_PERSONALIZED_DISCOUNT_METHOD_1(
	NP_DISCOUNT_METHOD_CD COMMENT 'Code of the calculation method of a non personalized discount for the new price.',
	NP_DISCOUNT_METHOD_NAME COMMENT 'Nameof the calculation method of a non personalized discount for the new price.',
	NP_DISCOUNT_METHOD_DESCR COMMENT 'Description of the calculation method of a non personalized discount for the new price.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the different calculation method of a non personalized discount for the new price.'
 as 
    SELECT 
        np_discount_method_cd,
        np_discount_method_name,
        np_discount_method_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_NON_PERSONALIZED_DISCOUNT_METHOD_1 ;
