create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_NON_PERSONALIZED_DISCOUNT_ACTION_TYPE_1(
	NP_DISCOUNT_ACTION_TYPE_CD COMMENT 'Code of the action type for the non personalized discount.',
	NP_DISCOUNT_ACTION_TYPE_NAME COMMENT 'Name of the action type for the non personalized discount.',
	NP_DISCOUNT_ACTION_TYPE_DESCR COMMENT 'Description of the action type for the non personalized discount.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the different action type for a non personalized discount.'
 as 
    SELECT 
        np_discount_action_type_cd,
        np_discount_action_type_name,
        np_discount_action_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_NON_PERSONALIZED_DISCOUNT_ACTION_TYPE_1 ;
