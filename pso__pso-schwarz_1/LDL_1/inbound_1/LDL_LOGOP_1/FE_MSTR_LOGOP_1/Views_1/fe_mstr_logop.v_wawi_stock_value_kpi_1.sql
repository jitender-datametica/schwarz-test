CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAWI_STOCK_VALUE_KPI_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse id',
	ARTIKELNR COMMENT 'Item_1 nr',
	BEZ_LANG COMMENT 'Item_1 description - long',
	BEZ_KURZ COMMENT 'Item_1 description - short',
	DEUTSCHTEXT COMMENT 'Item_1 description - DE',
	ARTGRUPNR COMMENT 'Item_1 group nr',
	ARTGRUPBEZ COMMENT 'Item_1 group description - DE',
	ARTGRUPBEZ_EN COMMENT 'Item_1 group description - EN',
	LPTYP COMMENT 'Storage Type - DE',
	LPTYP_EN COMMENT 'Storage Type - EN',
	AUTODISPO_FLG COMMENT 'Is it relevant for AutoDispo: Yes/No',
	WGI COMMENT 'Storage Type - DE',
	WGI_EN COMMENT 'Storage Type - EN',
	REPORTED_DATE COMMENT 'T067 and DA Date',
	PIECEQTY_CAL COMMENT 'Stock Expected',
	PIECEQTY_REAL COMMENT 'Stock Counted',
	PIECEQTY_DIFF COMMENT 'Stock Difference',
	VALID_SEQ COMMENT 'Valid Sequences of Tech Differences',
	RETAIL_PRICE COMMENT 'Retail Price from Bestandartikel_1',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date',
	DWH_UPDATED COMMENT 'Record updated at',
	CURR_SIGN COMMENT 'Currency Sign'
) COMMENT='KPI view based on aggregated Inventur_1 view and Article lookup view'
 AS
SELECT
	agg.client_id
	,agg.wh_id
	,agg.artikelnr
	,lar.bez_lang
	,lar.bez_kurz
	,lar.deutschtext
	,lar.artgrupnr
	,lar.artgrupbez
	,lar.artgrupbez_en
	,lar.lptyp
	,lar.lptyp_en
	,lar.autodispo_flg
	,lar.wgi
	,lar.wgi_en
	,agg.reported_date 
	,ZEROIFNULL(agg.pieceqty_cal)
	,ZEROIFNULL(agg.pieceqty_real)
	,ZEROIFNULL(agg.pieceqty_diff)
	,agg.valid_seq
	,agg.retail_price 
	,agg.dwh_valid_from 
    ,agg.dwh_valid_to
	,agg.dwh_updated
	,cur.curr_sign
FROM FE_MSTR_LOGOP.V_WAWI_STOCK_VALUE_AGG_1 agg
	INNER JOIN FE_MSTR_LOGOP.V_LU_WAWI_ARTIKEL_1 lar
	ON lar.client_id = agg.client_id
	AND lar.artikelnr = agg.artikelnr
	INNER JOIN "DATA".T_WAWI_CURRENCY_1 cur
	ON cur.client_id = agg.client_id
;