CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAWI_INVENTUR_KPI_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code'
	,WH_ID COMMENT 'Warehouse id'
	,ARTIKELNR COMMENT 'Item_1 nr'
	,FORM_NR COMMENT 'T067 Form nr'
	,BEZ_LANG COMMENT 'Item_1 description - long'
	,BEZ_KURZ COMMENT 'Item_1 description - short'
	,DEUTSCHTEXT COMMENT 'Item_1 description - DE'
	,ARTGRUPNR COMMENT 'Item_1 group nr'
	,ARTGRUPBEZ COMMENT 'Item_1 group description - DE'
	,ARTGRUPBEZ_EN COMMENT 'Item_1 group description - EN'
	,LPTYP COMMENT 'Storage Type - DE'
	,LPTYP_EN COMMENT 'Storage Type - EN'
	,AUTODISPO_FLG COMMENT 'Is it relevant for AutoDispo: Yes/No'
	,WGI COMMENT 'Storage Type - DE'
	,WGI_EN COMMENT 'Storage Type - EN'
	,REPORTED_DATE COMMENT 'T067 = T072 Date'
	,REASON_ID COMMENT 'T067 Reason id'
	,REASON_DESC COMMENT 'T067 Reason for inventory change'
	,CHARGE COMMENT 'T067 Charge'
	,MOD_USER COMMENT 'T067 User who made changes'
	,PIECE_QTY COMMENT 'T067 Piece quantity'
	,PIECE_QTY_NEG COMMENT 'T067 Summe negierte Piece QTY auf Ebene „C067 Itemnumber“ und „C076 Formdate“ mit Filter„C067 Reason ID“ = 3'
	,PIECE_QTY_POS COMMENT 'T067 Summe Piece QTY auf Ebene der „C067 Itemnumber“ und „C076 Formdate“ mit Filter „C067 Reason ID“ = 4'
	,INVENTORYNUM COMMENT 'T073 Inventory nr'
	,INVENTORYDESC COMMENT 'T073 Inventory desc'
	,INVENTORYTYPE COMMENT 'T072 Inventory type'
	,EXP_QTY COMMENT 'T073 INV Expected Qty. (PC)'
	,GES_QTY COMMENT 'T073 INV Counted Qty. (PC)'
	,DIFF_QTY COMMENT 'T073 INV Difference Qty.'
	,PRICE COMMENT 'Retail Price'
	,DATEFROM COMMENT 'Price Valid From'
	,DATETO COMMENT 'Price Valid To'
	,DWH_VALID_FROM COMMENT 'Valid from date'
	,DWH_VALID_TO COMMENT 'Valid to date'
	,DWH_UPDATED COMMENT 'Record updated at'
	,PV_FLAG COMMENT 'PV_Flag'
	,SCN COMMENT 'Scan Flag'
	,GROUPNR COMMENT 'Retail Price Group Nr'
	,CURR_SIGN COMMENT 'Currency Sign'
) AS
WITH Agg_Price AS (
    SELECT
        wai.client_id
        ,wai.wh_id
        ,wai.artikelnr
		,wai.form_nr
        ,wai.reported_date
		,wai.reason_id
		,wai.reason_desc
		,wai.charge
		,wai.mod_user
        ,wai.piece_qty
        ,wai.piece_qty_neg
        ,wai.piece_qty_pos
        ,wai.inventorynum
		,wai.inventorydesc
		,wai.inventorytype
        ,wai.exp_qty
        ,wai.ges_qty
        ,wai.diff_qty
        ,prc.max_price AS price
        ,prc.datefrom
        ,prc.dateto
	    ,prc.dwh_valid_from
        ,prc.dwh_valid_to
        ,wai.dwh_updated
        ,prc.pv_flag
        ,prc.scn
        ,prc.groupnr
		,prc.row_num
    FROM FE_MSTR_LOGOP.v_wawi_inventur_add_1 wai
   INNER JOIN (
        SELECT
			client_id
			,itemno AS artikelnr
			,MAX(price) AS max_price
			,pv_flag
			,scn
			,datefrom
			,dateto
			,groupnr
			,dwh_valid_from
            ,dwh_valid_to
			,ROW_NUMBER() OVER (PARTITION BY client_id, itemno, groupnr ORDER BY datefrom DESC) AS row_num
		FROM "DATA".T_WAWI_ITEMPRICES_1
		WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
        AND deleted_fg = 'FALSE'
		AND scn <> 0
        GROUP BY client_id, artikelnr, dateto, datefrom, dwh_valid_from, dwh_valid_to, pv_flag, scn, groupnr
    ) prc
    ON wai.client_id = prc.client_id
    AND wai.artikelnr = prc.artikelnr
WHERE 1=1 
--AND wai.REPORTED_DATE BETWEEN DATE_TRUNC('Day',prc.DATEFROM) AND DATE_TRUNC('Day',prc.DATETO)
)
,LatestAgg AS (
SELECT
    agg.client_id
    ,agg.wh_id
    ,agg.artikelnr
	,agg.form_nr
    ,agg.reported_date
	,agg.reason_id
	,agg.reason_desc
	,agg.charge
	,agg.mod_user
    ,agg.piece_qty
    ,agg.piece_qty_neg
    ,agg.piece_qty_pos
    ,agg.inventorynum
	,agg.inventorydesc
	,agg.inventorytype
    ,agg.exp_qty
    ,agg.ges_qty
    ,agg.diff_qty
    ,agg.price
    ,agg.datefrom
    ,agg.dateto
    ,agg.dwh_valid_from
    ,agg.dwh_valid_to
    ,agg.dwh_updated
    ,agg.pv_flag
    ,agg.scn
    ,agg.groupnr
	,agg.row_num
FROM Agg_Price agg
WHERE 1=1
AND agg.row_num = 1
)
SELECT
    lsg.client_id
    ,lsg.wh_id
    ,lsg.artikelnr
    ,lsg.form_nr
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
    ,lsg.reported_date
    ,lsg.reason_id
    ,lsg.reason_desc
    ,lsg.charge
    ,lsg.mod_user
    ,lsg.piece_qty
    ,lsg.piece_qty_neg
    ,lsg.piece_qty_pos
    ,lsg.inventorynum
    ,lsg.inventorydesc
    ,lsg.inventorytype
    ,lsg.exp_qty
    ,lsg.ges_qty
    ,lsg.diff_qty
    ,lsg.price
    ,lsg.datefrom
    ,lsg.dateto
    ,lsg.dwh_valid_from
    ,lsg.dwh_valid_to
    ,lsg.dwh_updated
    ,lsg.pv_flag
    ,lsg.scn
    ,lsg.groupnr
    ,cur.curr_sign
FROM LatestAgg lsg
INNER JOIN FE_MSTR_LOGOP.V_LU_WAWI_ARTIKEL_1 lar
    ON lar.client_id = lsg.client_id
    AND lar.artikelnr = lsg.artikelnr
INNER JOIN "DATA".T_WAWI_CURRENCY_1 cur
    ON cur.client_id = lsg.client_id
;