CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_inventur_add_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id OPTIONS(description='Warehouse id'),
artikelnr OPTIONS(description='Item_1 nr'), form_nr OPTIONS(description='T067 Form nr'), reported_date
OPTIONS(description='T067 = T072 Date'), reason_id OPTIONS(description='T067 Reason id'), reason_desc
OPTIONS(description='T067 Reason for inventory change'), charge OPTIONS(description='T067 Charge'), mod_user
OPTIONS(description='T067 User who made changes'), piece_qty OPTIONS(description='T067 Piece quantity'), piece_qty_neg
OPTIONS(description='T067 Summe negierte Piece QTY auf Ebene „C067 Itemnumber“ und „C076 Formdate“ mit Filter„C067 Reason ID“ = 3'),
piece_qty_pos
OPTIONS(description='T067 Summe Piece QTY auf Ebene der „C067 Itemnumber“ und „C076 Formdate“ mit Filter „C067 Reason ID“ = 4'),
inventorynum OPTIONS(description='T073 Inventory nr'), inventorydesc OPTIONS(description='T073 Inventory desc'),
inventorytype OPTIONS(description='T072 Inventory type'), exp_qty OPTIONS(description='T073 INV Expected Qty. (PC)'),
ges_qty OPTIONS(description='T073 INV Counted Qty. (PC)'), diff_qty OPTIONS(description='T073 INV Difference Qty.'),
dwh_load_id OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted')) AS WITH LUINVDET AS (SELECT
   *
  FROM ldl_logop_fe_mstr_logop.v_wawi_inventorydet_1), LUSTOCK AS (SELECT client_id,
    CASE
    WHEN client_id = 13 AND wh_id = 600
    THEN 60
    WHEN client_id = 18 AND wh_id = 20
    THEN 4
    WHEN client_id = 21 AND wh_id = 20
    THEN 22
    ELSE wh_id
    END AS wh_id,
   item_nr AS artikelnr,
   form_nr,
   form_date AS t067_form_date,
   reason_id AS t067_reason_id,
   reason_desc AS t067_reason_desc,
   charge AS t067_charge,
   mod_user AS t067_mod_user,
     case_qty * decimal_case + piece_qty AS t067_piece_qty,
    CASE
    WHEN CAST(reason_id AS INTEGER) IN (1, 2, 3)
    THEN case_qty * decimal_case + piece_qty
    ELSE 0
    END AS t067_piece_qty_neg,
    CASE
    WHEN CAST(reason_id AS FLOAT64) = 4
    THEN case_qty * decimal_case + piece_qty
    ELSE 0
    END AS t067_piece_qty_pos,
   dwh_load_id,
   dwh_created,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg
  FROM ldl_logop_data.t_wawi_stock_corr_1
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND form_date > DATE '2024-03-01'
   AND NOT deleted_fg) (SELECT *
  FROM (SELECT client_id,
      wh_id,
      artikelnr,
      form_nr,
      t072_date AS reported_date,
      SUBSTR(CAST(NULL AS STRING), 1, 20) AS reason_id,
      SUBSTR(CAST(NULL AS STRING), 1, 254) AS reason_desc,
      SUBSTR(CAST(NULL AS STRING), 1, 35) AS charge,
      SUBSTR(CAST(NULL AS STRING), 1, 8) AS mod_user,
      CAST(NULL AS BIGNUMERIC) AS piece_qty,
      CAST(NULL AS BIGNUMERIC) AS piece_qty_neg,
      CAST(NULL AS BIGNUMERIC) AS piece_qty_pos,
      inventorynum,
      CONCAT('INV', ' ', CAST(inventorynum AS STRING)) AS inventorydesc,
      inventorytype,
      t073_exp_qty AS exp_qty,
      t073_ges_qty AS ges_qty,
      t073_diff_qty AS diff_qty,
      dwh_load_id,
      dwh_created,
      dwh_updated,
      dwh_valid_from,
      dwh_valid_to,
      deleted_fg
     FROM LUINVDET AS lui
     UNION DISTINCT
     SELECT client_id,
      wh_id,
      artikelnr,
      form_nr,
      t067_form_date AS reported_date,
      t067_reason_id AS reason_id,
      t067_reason_desc AS reason_desc,
      t067_charge AS charge,
      t067_mod_user AS mod_user,
      t067_piece_qty AS piece_qty,
      t067_piece_qty_neg AS piece_qty_neg,
      t067_piece_qty_pos AS piece_qty_pos,
      CAST(NULL AS BIGNUMERIC) AS inventorynum,
      CAST(NULL AS STRING) AS inventorydesc,
      SUBSTR(CAST(NULL AS STRING), 1, 1) AS inventorytype,
      CAST(NULL AS NUMERIC) AS exp_qty,
      CAST(NULL AS NUMERIC) AS ges_qty,
      CAST(NULL AS NUMERIC) AS diff_qty,
      dwh_load_id,
      dwh_created,
      dwh_updated,
      dwh_valid_from,
      dwh_valid_to,
      deleted_fg
     FROM LUSTOCK AS lus));