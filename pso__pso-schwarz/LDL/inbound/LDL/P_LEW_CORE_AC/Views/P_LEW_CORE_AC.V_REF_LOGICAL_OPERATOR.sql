create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_LOGICAL_OPERATOR(
	LOGICAL_OPERATOR_CD COMMENT 'Code of  item/itemgroup combination type for a non personalized discount.',
	LOGICAL_OPERATOR_DESCR COMMENT 'Description of  item/itemgroup combination type for a non personalized discount.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the different item/itemgroup combination type for a non personalized discount.(Mix&Match)'
 as 
    SELECT 
        logical_operator_cd,
        logical_operator_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_LOGICAL_OPERATOR ;
