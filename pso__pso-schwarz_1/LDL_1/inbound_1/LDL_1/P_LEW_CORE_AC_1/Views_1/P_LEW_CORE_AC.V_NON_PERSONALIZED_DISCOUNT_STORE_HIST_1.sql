create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_NON_PERSONALIZED_DISCOUNT_STORE_HIST_1(
	CLIENT_ID COMMENT 'unique identifier of the DWH client / slice.',
	NP_DISCOUNT_SID COMMENT 'Surrogate Key of the non personalized discount.',
	STORE_LOC_SID COMMENT 'Surrogate Key LOCATION_1 (eindeutig ueber alle Laender / Mandanten hinweg).',
	DELETED_FG COMMENT 'relation was not delivered by source system (anymore), if deleted_fg=1',
	DWH_VALID_FROM COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
	DWH_VALID_TO COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) COMMENT='This tables contains the Store for which the non-personalized promotion is valid.(historised version).'
 as 
    SELECT 
        client_id,
        np_discount_sid,
        store_loc_sid,
        deleted_fg,
        dwh_valid_from,
        dwh_valid_to,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_STORE_HIST_1 ;
