create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_NON_PERSONALIZED_DISCOUNT_1(
	CLIENT_ID COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID COMMENT 'Surrogate Key of the non personalized discount.',
	LOCAL_NP_DISCOUNT_NR COMMENT 'Unique identifier of  a non personalized discount within the country_1/ tenant.',
	NP_DISCOUNT_NR COMMENT 'Global unique identifier of  a non personalized discount.',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='Non-personalized discount, excluding Lidl Plus.'
 as 
    SELECT 
        client_id,
        np_discount_sid,
        local_np_discount_nr,
        np_discount_nr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_1 ;
