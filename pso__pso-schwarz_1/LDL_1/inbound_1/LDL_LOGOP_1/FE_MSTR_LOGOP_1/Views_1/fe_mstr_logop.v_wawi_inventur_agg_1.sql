CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAWI_INVENTUR_AGG_1(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_1 code',
	WH_ID COMMENT 'Warehouse id',
	ARTIKELNR COMMENT 'Item_1 nr',
	FORM_NR COMMENT 'T067 Form nr',
	REPORTED_DATE COMMENT 'T067 = T072 Date',
	REASON_ID COMMENT 'T067 Reason id',
	REASON_DESC COMMENT 'T067 Reason for inventory change',
	CHARGE COMMENT 'T067 Charge',
	MOD_USER COMMENT 'T067 User who made changes',
	PIECE_QTY COMMENT 'T067 Piece quantity',
	PIECE_QTY_NEG COMMENT 'T067 Summe negierte Piece QTY auf Ebene „C067 Itemnumber“ und „C076 Formdate“ mit Filter„C067 Reason ID“ = 3',
	PIECE_QTY_POS COMMENT ' T067 Summe Piece QTY auf Ebene der „C067 Itemnumber“ und „C076 Formdate“ mit Filter „C067 Reason ID“ = 4',
	INVENTORYNUM COMMENT 'T073 Inventory nr',
	INVENTORYDESC COMMENT 'T073 Inventory desc',
	INVENTORYTYPE COMMENT 'T072 Inventory type',
	EXP_QTY COMMENT 'T073 INV Expected Qty. (PC)',
	GES_QTY COMMENT 'T073 INV Counted Qty. (PC)',
	DIFF_QTY COMMENT 'T073 INV Difference Qty.',
	PRICE COMMENT 'Retail Price',
	DATEFROM COMMENT 'Price Valid From',
	DATETO COMMENT 'Price Valid To',
	DWH_VALID_FROM COMMENT 'Valid from date',
	DWH_VALID_TO COMMENT 'Valid to date',
	DWH_UPDATED COMMENT 'Record updated at',
	PV_FLAG COMMENT 'PV_Flag',
	SCN COMMENT 'Scan Flag',
	GROUPNR COMMENT 'Retail Price'
) AS
WITH Agg_Price AS (
    SELECT
        wai.client_id,
        wai.wh_id,
        wai.artikelnr,
		wai.form_nr,
        wai.reported_date,
		wai.reason_id,
		wai.reason_desc,
		wai.charge,
		wai.mod_user,
        wai.piece_qty,
        wai.piece_qty_neg,
        wai.piece_qty_pos,
        wai.inventorynum,
		wai.inventorydesc,
		wai.inventorytype,
        wai.exp_qty,
        wai.ges_qty,
        wai.diff_qty,
        prc.max_price AS price, 
        prc.datefrom,
        prc.dateto,
	    prc.dwh_valid_from,
        prc.dwh_valid_to,
        wai.dwh_updated,
        prc.pv_flag,
        prc.scn,
        prc.groupnr
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
		FROM "DATA".T_WAWI_ITEMPRICES_1
		WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
        AND deleted_fg = 'FALSE'
		AND scn <> 0
        GROUP BY client_id, artikelnr, dateto, datefrom, dwh_valid_from, dwh_valid_to, pv_flag, scn, groupnr
    ) prc
    ON wai.client_id = prc.client_id
    AND wai.artikelnr = prc.artikelnr
WHERE 1=1 
AND wai.REPORTED_DATE BETWEEN DATE_TRUNC('Day',prc.DATEFROM) AND DATE_TRUNC('Day',prc.DATETO)
)
SELECT
    client_id,
    wh_id,
    artikelnr,
	form_nr,
    reported_date,
	reason_id,
	reason_desc,
	charge,
	mod_user,
    piece_qty,
    piece_qty_neg,
    piece_qty_pos,
    inventorynum,
	inventorydesc,
	inventorytype,
    exp_qty,
    ges_qty,
    diff_qty,
    price,
    datefrom,
    dateto,
    dwh_valid_from,
    dwh_valid_to,
    dwh_updated,
    pv_flag,
    scn,
    groupnr
FROM Agg_Price
;