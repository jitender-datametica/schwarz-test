create or replace view LDL_PRODUCTION.P_LEW_BIL_AC.V_SM_MAP_ITEM_CONTAINER_STR(
	CLIENT_ID COMMENT 'Landeskennzeichen',
	ITEM_SID COMMENT 'Artikelnummer',
	LOC_SID_WH COMMENT 'Surrogate Key LOCATION (eindeutig ueber alle Laender/Mandanten hinweg)',
	WH_ID COMMENT 'WH ID from source (WAWI)',
	CONTAINER_ID COMMENT 'Surrogate Key container',
	MOVE_TO_STORE_ID COMMENT 'Store-Nr',
	ASPECT_ID COMMENT 'only 1= BGES',
	DAT_REC_START COMMENT 'Gültigkeitsdatum von',
	DAT_REC_END COMMENT 'Gültigkeitsdatum bis'
) as
SELECT
   client_id
,  item_sid
,  loc_sid_wh
,  wh_id
,  container_id
,  move_to_store_id
,  aspect_id
,  dat_rec_start
,  dat_rec_end
FROM P_LEW_BIL.T_SM_MAP_ITEM_CONTAINER_STR
;
