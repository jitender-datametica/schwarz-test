CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_inventur_kpi_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), wh_id OPTIONS(description='Warehouse id'),
artikelnr OPTIONS(description='Item_2 nr'), form_nr OPTIONS(description='T067 Form nr'), bez_lang
OPTIONS(description='Item_2 description - long'), bez_kurz OPTIONS(description='Item_2 description - short'), deutschtext
OPTIONS(description='Item_2 description - DE'), artgrupnr OPTIONS(description='Item_2 group nr'), artgrupbez
OPTIONS(description='Item_2 group description - DE'), artgrupbez_en OPTIONS(description='Item_2 group description - EN'),
lptyp OPTIONS(description='Storage Type - DE'), lptyp_en OPTIONS(description='Storage Type - EN'), autodispo_flg
OPTIONS(description='Is it relevant for AutoDispo: Yes/No'), wgi OPTIONS(description='Storage Type - DE'), wgi_en
OPTIONS(description='Storage Type - EN'), reported_date OPTIONS(description='T067 = T072 Date'), reason_id
OPTIONS(description='T067 Reason id'), reason_desc OPTIONS(description='T067 Reason for inventory change'), charge
OPTIONS(description='T067 Charge'), mod_user OPTIONS(description='T067 User who made changes'), piece_qty
OPTIONS(description='T067 Piece quantity'), piece_qty_neg
OPTIONS(description='T067 Summe negierte Piece QTY auf Ebene „C067 Itemnumber“ und „C076 Formdate“ mit Filter„C067 Reason ID“ = 3'),
piece_qty_pos
OPTIONS(description='T067 Summe Piece QTY auf Ebene der „C067 Itemnumber“ und „C076 Formdate“ mit Filter „C067 Reason ID“ = 4'),
inventorynum OPTIONS(description='T073 Inventory nr'), inventorydesc OPTIONS(description='T073 Inventory desc'),
inventorytype OPTIONS(description='T072 Inventory type'), exp_qty OPTIONS(description='T073 INV Expected Qty. (PC)'),
ges_qty OPTIONS(description='T073 INV Counted Qty. (PC)'), diff_qty OPTIONS(description='T073 INV Difference Qty.'),
price OPTIONS(description='Retail Price'), datefrom OPTIONS(description='Price Valid From'), dateto
OPTIONS(description='Price Valid To'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), dwh_updated OPTIONS(description='Record updated at'), pv_flag
OPTIONS(description='PV_Flag'), scn OPTIONS(description='Scan Flag'), groupnr
OPTIONS(description='Retail Price Group Nr'), curr_sign OPTIONS(description='Currency Sign')) AS WITH AGG_PRICE AS (SELECT
   WAI.client_id,
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
   prc.groupnr,
   prc.row_num
  FROM ldl_logop_fe_mstr_logop.v_wawi_inventur_add_2 AS WAI
   INNER JOIN (SELECT client_id,
     itemno AS artikelnr,
     MAX(price) AS max_price,
     pv_flag,
     scn,
     datefrom,
     dateto,
     groupnr,
     dwh_valid_from,
     dwh_valid_to,
     ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), itemno, CAST(groupnr AS STRING) ORDER BY datefrom
        IS NULL DESC, datefrom DESC) AS row_num
    FROM ldl_logop_data.t_wawi_itemprices_2
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
  WHERE prc.row_num = 1), LATESTAGG AS (SELECT *
  FROM AGG_PRICE AS agg) (SELECT lsg.client_id,
   lsg.wh_id,
   lsg.artikelnr,
   lsg.form_nr,
   LAR.bez_lang,
   LAR.bez_kurz,
   LAR.deutschtext,
   LAR.artgrupnr,
   LAR.artgrupbez,
   LAR.artgrupbez_en,
   LAR.lptyp,
   LAR.lptyp_en,
   LAR.autodispo_flg,
   LAR.wgi,
   LAR.wgi_en,
   lsg.reported_date,
   lsg.reason_id,
   lsg.reason_desc,
   lsg.charge,
   lsg.mod_user,
   lsg.piece_qty,
   lsg.piece_qty_neg,
   lsg.piece_qty_pos,
   lsg.inventorynum,
   lsg.inventorydesc,
   lsg.inventorytype,
   lsg.exp_qty,
   lsg.ges_qty,
   lsg.diff_qty,
   lsg.price,
   lsg.datefrom,
   lsg.dateto,
   lsg.dwh_valid_from,
   lsg.dwh_valid_to,
   lsg.dwh_updated,
   lsg.pv_flag,
   lsg.scn,
   lsg.groupnr,
   CUR.curr_sign
  FROM LATESTAGG AS lsg
   INNER JOIN ldl_logop_fe_mstr_logop.v_lu_wawi_artikel_2 AS LAR ON lsg.client_id = LAR.client_id AND lsg.artikelnr = LAR
     .artikelnr
   INNER JOIN ldl_logop_data.t_wawi_currency_2 AS CUR ON lsg.client_id = CUR.client_id);