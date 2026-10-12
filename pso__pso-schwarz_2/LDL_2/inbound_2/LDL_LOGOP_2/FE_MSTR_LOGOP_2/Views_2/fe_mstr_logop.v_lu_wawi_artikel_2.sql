CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LU_WAWI_ARTIKEL_2(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code',
	ARTIKELNR COMMENT 'Item_2 nr',
	BEZ_LANG COMMENT 'Item_2 description - long',
	BEZ_KURZ COMMENT 'Item_2 description - short',
	DEUTSCHTEXT COMMENT 'Item_2 description - DE',
	ARTGRUPNR COMMENT 'Item_2 group nr',
	ARTGRUPBEZ COMMENT 'Item_2 group description - DE',
	ARTGRUPBEZ_EN COMMENT 'Item_2 group description - EN',
	LPTYP COMMENT 'Storage Type - DE',
	LPTYP_EN COMMENT 'Storage Type - EN',
	AUTODISPO_FLG COMMENT 'Is it relevant for AutoDispo: Yes/No',
	WGI COMMENT 'Storage Type - DE',
	WGI_EN COMMENT 'Storage Type - EN',
	DWH_LOAD_ID COMMENT 'Load id',
	DWH_CREATED COMMENT 'Record created at',
	DWH_UPDATED COMMENT 'Record updated at',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date',
	DELETED_FG COMMENT 'Flag if record is deleted'
) COMMENT='Artikel_2 - lookup view based on T_WAWI_ARTIKEL_2 and T_WAWI_ARTIKELGRP_MAPPING_2'
 AS
SELECT 
	 art.client_id
	,art.artikelnr
	,art.bez_lang
	,art.bez_kurz
	,art.deutschtext
	,atm.artgrupnr
	,atm.artgrupbez
	,atm.artgrupbez_en
	,atm.lptyp
	,atm.lptyp_en
	,atm.autodispo_flg
	,atm.wgi
	,atm.wgi_en
	,art.dwh_load_id
	,art.dwh_created
	,art.dwh_updated
	,art.dwh_valid_from
	,art.dwh_valid_to
	,art.deleted_fg
FROM fe_mstr_logop.V_WAWI_ARTIKEL_2 art_2  
JOIN fe_mstr_logop.V_LU_WAWI_ARTIKELGRP_2 atm
	ON art.artgrupnr = atm.artgrupnr
;