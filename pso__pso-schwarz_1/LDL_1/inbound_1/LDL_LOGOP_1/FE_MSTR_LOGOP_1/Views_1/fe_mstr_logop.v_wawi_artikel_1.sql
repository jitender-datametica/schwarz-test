CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAWI_ARTIKEL_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	ARTIKELNR COMMENT 'Item_1 nr',
	BEZ_LANG COMMENT 'Item_1 description - long',
	BEZ_KURZ COMMENT 'Item_1 description - short',
	DEUTSCHTEXT COMMENT 'Item_1 description - DE',
	ARTGRUPNR COMMENT 'Item_1 group nr',
	DWH_LOAD_ID COMMENT 'Load id',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date',
	DELETED_FG COMMENT 'Flag if record is deleted'
) COMMENT='Artikel_1 - lookup view based on T_WAWI_ARTIKEL_1'
AS
SELECT 
	 client_id
	,artikelnr
	,bez_lang
	,bez_kurz
	,deutschtext
	,artgrupnr
	,dwh_load_id
	,dwh_created
	,dwh_updated
	,dwh_valid_from
	,dwh_valid_to
	,deleted_fg
FROM  "DATA".T_WAWI_ARTIKEL_1 
WHERE CURRENT_DATE BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
AND DELETED_FG = 'FALSE'
;