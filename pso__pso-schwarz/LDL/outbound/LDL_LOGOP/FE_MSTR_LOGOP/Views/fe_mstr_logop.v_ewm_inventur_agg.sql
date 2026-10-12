CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ewm_inventur_agg (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id OPTIONS(description='Warehouse id'),
artikelnr OPTIONS(description='Item nr'), form_nr OPTIONS(description='T067 Form nr'), reported_date
OPTIONS(description='T067 and DA Date'), reason_id OPTIONS(description='T067 and DA Reason id'), reason_desc
OPTIONS(description='T067 and DA Reason description'), piece_qty OPTIONS(description='T067 Piece quantity'),
piece_qty_neg
OPTIONS(description='T067 Summe negierte Piece QTY auf Ebene „C067 Itemnumber“ und „C076 Formdate“ mit Filter„C067 Reason ID“ = 3'),
piece_qty_pos
OPTIONS(description='T067 Summe Piece QTY auf Ebene der „C067 Itemnumber“ und „C076 Formdate“ mit Filter „C067 Reason ID“ = 4'),
form_ref_fg OPTIONS(description='T067 Form Ref Flag: 1 = All; 2 = Form Nr Ref starts with 2'), diff_qty
OPTIONS(description='DA Difference QTY. (PC)'), diff_val OPTIONS(description='DA Difference Val.'), price
OPTIONS(description='Retail Price'), datefrom OPTIONS(description='Price Valid From'), dateto
OPTIONS(description='Price Valid To'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), dwh_updated OPTIONS(description='Record updated at'), pv_flag
OPTIONS(description='PV_Flag'), scn OPTIONS(description='Scan Flag'), groupnr OPTIONS(description='Retail Price')) AS
WITH AGG_PRICE AS (SELECT EWI.client_id,
   EWI.wh_id,
   EWI.artikelnr,
   EWI.form_nr,
   EWI.reported_date,
   EWI.reason_id,
   EWI.reason_desc,
   EWI.piece_qty,
   EWI.piece_qty_neg,
   EWI.piece_qty_pos,
   EWI.form_ref_fg,
   EWI.diff_qty,
   EWI.diff_val,
   prc.max_price AS price,
   prc.datefrom,
   prc.dateto,
   prc.dwh_valid_from,
   prc.dwh_valid_to,
   EWI.dwh_updated,
   prc.pv_flag,
   prc.scn,
   prc.groupnr
  FROM ldl_logop_fe_mstr_logop.v_ewm_inventur_add AS EWI
   INNER JOIN (SELECT client_id,
     itemno AS artikelnr,
     MAX(price) AS max_price,
     pv_flag,
     scn,
     datefrom,
     dateto,
     groupnr,
     dwh_valid_from,
     dwh_valid_to
    FROM ldl_logop_data.t_wawi_itemprices
    WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
     AND scn <> 0
     AND NOT deleted_fg
    GROUP BY client_id,
     artikelnr,
     dateto,
     datefrom,
     dwh_valid_from,
     dwh_valid_to,
     pv_flag,
     scn,
     groupnr) AS prc ON EWI.client_id = prc.client_id AND EWI.artikelnr = prc.artikelnr
  WHERE EWI.reported_date BETWEEN CAST(DATE_TRUNC(prc.datefrom, DAY) AS DATE) AND (CAST(DATE_TRUNC(prc.dateto, DAY) AS DATE)
     )) (SELECT *
  FROM AGG_PRICE);