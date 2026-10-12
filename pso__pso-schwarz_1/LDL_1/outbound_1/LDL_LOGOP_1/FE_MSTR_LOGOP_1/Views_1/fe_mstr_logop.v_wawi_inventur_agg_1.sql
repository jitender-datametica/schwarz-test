CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_inventur_agg_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id OPTIONS(description='Warehouse id'),
artikelnr OPTIONS(description='Item_1 nr'), form_nr OPTIONS(description='T067 Form nr'), reported_date
OPTIONS(description='T067 = T072 Date'), reason_id OPTIONS(description='T067 Reason id'), reason_desc
OPTIONS(description='T067 Reason for inventory change'), charge OPTIONS(description='T067 Charge'), mod_user
OPTIONS(description='T067 User who made changes'), piece_qty OPTIONS(description='T067 Piece quantity'), piece_qty_neg
OPTIONS(description='T067 Summe negierte Piece QTY auf Ebene „C067 Itemnumber“ und „C076 Formdate“ mit Filter„C067 Reason ID“ = 3'),
piece_qty_pos
OPTIONS(description=' T067 Summe Piece QTY auf Ebene der „C067 Itemnumber“ und „C076 Formdate“ mit Filter „C067 Reason ID“ = 4'),
inventorynum OPTIONS(description='T073 Inventory nr'), inventorydesc OPTIONS(description='T073 Inventory desc'),
inventorytype OPTIONS(description='T072 Inventory type'), exp_qty OPTIONS(description='T073 INV Expected Qty. (PC)'),
ges_qty OPTIONS(description='T073 INV Counted Qty. (PC)'), diff_qty OPTIONS(description='T073 INV Difference Qty.'),
price OPTIONS(description='Retail Price'), datefrom OPTIONS(description='Price Valid From'), dateto
OPTIONS(description='Price Valid To'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), dwh_updated OPTIONS(description='Record updated at'), pv_flag
OPTIONS(description='PV_Flag'), scn OPTIONS(description='Scan Flag'), groupnr OPTIONS(description='Retail Price')) AS
WITH AGG_PRICE AS (SELECT WAI.client_id,
   WAI.wh_id,
   WAI.artikelnr,
   WAI.form_nr,
   WAI.reported_date,
   WAI.reason_id,
   WAI.reason_desc,
   WAI.charge,
   WAI.mod_user,
   WAI.piece_qty,
   WAI.piece_qty_neg,
   WAI.piece_qty_pos,
   WAI.inventorynum,
   WAI.inventorydesc,
   WAI.inventorytype,
   WAI.exp_qty,
   WAI.ges_qty,
   WAI.diff_qty,
   prc.max_price AS price,
   prc.datefrom,
   prc.dateto,
   prc.dwh_valid_from,
   prc.dwh_valid_to,
   WAI.dwh_updated,
   prc.pv_flag,
   prc.scn,
   prc.groupnr
  FROM ldl_logop_fe_mstr_logop.v_wawi_inventur_add_1 AS WAI
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
    FROM ldl_logop_data.t_wawi_itemprices_1
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
     groupnr) AS prc ON WAI.client_id = prc.client_id AND WAI.artikelnr = prc.artikelnr
  WHERE WAI.reported_date BETWEEN CAST(DATE_TRUNC(prc.datefrom, DAY) AS DATE) AND (CAST(DATE_TRUNC(prc.dateto, DAY) AS DATE)
     )) (SELECT *
  FROM AGG_PRICE);