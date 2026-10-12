create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_NON_PERSONALIZED_DISCOUNT_STATUS_2(
	NP_DISCOUNT_STATUS_CD COMMENT 'Code of the non personalized discount status.',
	NP_DISCOUNT_STATUS_DESCR COMMENT 'Description of the non personalized discount status.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This table contains the different status_2 of a non personalized discount.'
 as 
    SELECT 
        np_discount_status_cd,
        np_discount_status_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_NON_PERSONALIZED_DISCOUNT_STATUS_2 ;
