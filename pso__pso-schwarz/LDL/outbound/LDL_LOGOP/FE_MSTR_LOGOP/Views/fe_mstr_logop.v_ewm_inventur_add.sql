CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ewm_inventur_add (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id OPTIONS(description='Warehouse id'),
artikelnr OPTIONS(description='Item nr'), form_nr OPTIONS(description='T067 Form nr'), reported_date
OPTIONS(description='T067 and DA Date'), reason_id OPTIONS(description='T067 and DA Reason id'), reason_desc
OPTIONS(description='T067 and DA Reason description'), piece_qty OPTIONS(description='T067 Piece quantity'),
piece_qty_neg
OPTIONS(description='T067 Summe negierte Piece QTY auf Ebene „C067 Itemnumber“ und „C076 Formdate“ mit Filter„C067 Reason ID“ = 3'),
piece_qty_pos
OPTIONS(description='T067 Summe Piece QTY auf Ebene der „C067 Itemnumber“ und „C076 Formdate“ mit Filter „C067 Reason ID“ = 4'),
form_ref_fg OPTIONS(description='Form Ref Flag: 1 = All ; 2 = Form Nr Ref starts with 2 ; 3 = Difference Analyzer'),
diff_qty OPTIONS(description='DA Difference QTY. (PC)'), diff_val OPTIONS(description='DA Difference Val.'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted')) AS WITH LUSTOCK_ALL
 AS (SELECT client_id,
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
   1 AS form_ref_fg,
   dwh_load_id,
   dwh_created,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg
  FROM ldl_logop_data.t_wawi_stock_corr
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND form_date > DATE '2024-03-01'
   AND NOT deleted_fg), LUSTOCK_TECH AS (SELECT client_id,
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
   2 AS form_ref_fg,
   dwh_load_id,
   dwh_created,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg
  FROM ldl_logop_data.t_wawi_stock_corr
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND form_date > DATE '2024-03-01'
   AND STARTS_WITH(form_nr_ref, '2')
   AND NOT deleted_fg), LUDIFF AS (SELECT client_id,
   wh_id,
   LPAD(matnr, 11, '0') AS artikelnr,
   posted_date,
   reason AS reason_id,
   reason_text AS da_reason_desc,
   SUM(ui_quan_diff) AS diff_qty,
   SUM(value) AS diff_val,
   3 AS form_ref_fg,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated_0
  FROM ldl_logop_data.t_sapewm_differenceanalyzer
  GROUP BY client_id,
   wh_id,
   artikelnr,
   posted_date,
   reason_id,
   da_reason_desc,
   form_ref_fg,
   dwh_updated) (SELECT *
  FROM ((SELECT client_id,
       wh_id,
       artikelnr,
       form_nr,
       t067_form_date AS reported_date,
       t067_reason_id AS reason_id,
       t067_reason_desc AS reason_desc,
       t067_piece_qty AS piece_qty,
       t067_piece_qty_neg AS piece_qty_neg,
       t067_piece_qty_pos AS piece_qty_pos,
       form_ref_fg,
       CAST(NULL AS BIGNUMERIC) AS diff_qty,
       CAST(NULL AS BIGNUMERIC) AS diff_val,
       dwh_load_id,
       dwh_created,
       dwh_updated,
       dwh_valid_from,
       dwh_valid_to,
       deleted_fg
      FROM LUSTOCK_ALL AS lusa
      UNION DISTINCT
      SELECT client_id,
       wh_id,
       artikelnr,
       form_nr,
       t067_form_date AS reported_date,
       t067_reason_id AS reason_id,
       t067_reason_desc AS reason_desc,
       t067_piece_qty AS piece_qty,
       t067_piece_qty_neg AS piece_qty_neg,
       t067_piece_qty_pos AS piece_qty_pos,
       form_ref_fg,
       CAST(NULL AS BIGNUMERIC) AS diff_qty,
       CAST(NULL AS BIGNUMERIC) AS diff_val,
       dwh_load_id,
       dwh_created,
       dwh_updated,
       dwh_valid_from,
       dwh_valid_to,
       deleted_fg
      FROM LUSTOCK_TECH AS lust)
     UNION DISTINCT
     SELECT client_id,
      wh_id,
      artikelnr,
      CAST(NULL AS BIGNUMERIC) AS form_nr,
      posted_date AS reported_date,
      reason_id,
      da_reason_desc AS reason_desc,
      CAST(NULL AS BIGNUMERIC) AS piece_qty,
      CAST(NULL AS BIGNUMERIC) AS piece_qty_neg,
      CAST(NULL AS BIGNUMERIC) AS piece_qty_pos,
      form_ref_fg,
      diff_qty,
      diff_val,
      CAST(NULL AS BIGNUMERIC) AS dwh_load_id,
      CAST(NULL AS DATETIME) AS dwh_created,
      dwh_updated_0 AS dwh_updated,
      CAST(CAST(NULL AS STRING) AS DATE) AS dwh_valid_from,
      CAST(CAST(NULL AS STRING) AS DATE) AS dwh_valid_to,
      CAST(NULL AS BOOL) AS deleted_fg
     FROM LUDIFF AS ludi));