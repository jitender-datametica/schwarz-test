CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_EWM_INVENTUR_AGG_2(
	CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code',
	WH_ID COMMENT 'Warehouse id',
	ARTIKELNR COMMENT 'Item_2 nr',
	FORM_NR COMMENT 'T067 Form nr',
	REPORTED_DATE COMMENT 'T067 and DA Date',
	REASON_ID COMMENT 'T067 and DA Reason id',
	REASON_DESC COMMENT 'T067 and DA Reason description',
	PIECE_QTY COMMENT 'T067 Piece quantity',
	PIECE_QTY_NEG COMMENT 'T067 Summe negierte Piece QTY auf Ebene „C067 Itemnumber“ und „C076 Formdate“ mit Filter„C067 Reason ID“ = 3',
	PIECE_QTY_POS COMMENT 'T067 Summe Piece QTY auf Ebene der „C067 Itemnumber“ und „C076 Formdate“ mit Filter „C067 Reason ID“ = 4',
	FORM_REF_FG COMMENT 'T067 Form Ref Flag: 1 = All; 2 = Form Nr Ref starts with 2',
	DIFF_QTY COMMENT 'DA Difference QTY. (PC)',
	DIFF_VAL COMMENT 'DA Difference Val.',
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
        ewi.client_id,
        ewi.wh_id,
        ewi.artikelnr,
		ewi.form_nr,
        ewi.reported_date,
		ewi.reason_id,
		ewi.reason_desc,
        ewi.piece_qty,
        ewi.piece_qty_neg,
        ewi.piece_qty_pos,
		ewi.form_ref_fg,
        ewi.diff_qty,
        ewi.diff_val,
        prc.max_price AS price, 
        prc.datefrom,
        prc.dateto,
	    prc.dwh_valid_from,
        prc.dwh_valid_to,
        ewi.dwh_updated,
        prc.pv_flag,
        prc.scn,
        prc.groupnr
    FROM FE_MSTR_LOGOP.v_ewm_inventur_add_2 ewi
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
		FROM "DATA".T_WAWI_ITEMPRICES_2
		WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
        AND deleted_fg = 'FALSE'
		AND scn <> 0
        GROUP BY client_id, artikelnr, dateto, datefrom, dwh_valid_from, dwh_valid_to, pv_flag, scn, groupnr
    ) prc
    ON ewi.client_id = prc.client_id
    AND ewi.artikelnr = prc.artikelnr
WHERE 1=1 
AND ewi.reported_date BETWEEN DATE_TRUNC('Day',prc.datefrom) AND DATE_TRUNC('Day',prc.DATETO)

)
SELECT
	client_id,
    wh_id,
    artikelnr,
	form_nr,
    reported_date,
	reason_id,
	reason_desc,
    piece_qty,
    piece_qty_neg,
    piece_qty_pos,
	form_ref_fg,
    diff_qty,
    diff_val,
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