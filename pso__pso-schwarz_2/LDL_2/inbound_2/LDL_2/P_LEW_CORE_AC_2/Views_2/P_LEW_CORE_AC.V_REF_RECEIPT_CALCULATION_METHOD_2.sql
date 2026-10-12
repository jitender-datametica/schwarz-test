create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_RECEIPT_CALCULATION_METHOD_2(
	RECEIPT_CALC_METHOD_CD COMMENT 'Code of receipt calculation method for a non personalized discount.',
	RECEIPT_CALC_METHOD_NAME COMMENT 'Name of receipt calculation method for a non personalized discount.',
	RECEIPT_CALC_METHOD_DESCR COMMENT 'Description of receipt calculation method for a non personalized discount.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the different receipt calculation methodof a non personalized discount.'
 as 
    SELECT 
        receipt_calc_method_cd,
        receipt_calc_method_name,
        receipt_calc_method_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_RECEIPT_CALCULATION_METHOD_2 ;
