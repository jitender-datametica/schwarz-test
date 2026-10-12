CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_inventorydet (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id OPTIONS(description='Warehouse id'),
artikelnr OPTIONS(description='Item nr'), form_nr OPTIONS(description='Item row id'), inventorynum
OPTIONS(description='Inventory nr'), inventorytype OPTIONS(description='Inventory type'), t072_date
OPTIONS(description='Modification date'), t073_exp_qty OPTIONS(description='INV Expected Qty. (PC)'), t073_ges_qty
OPTIONS(description='INV Counted Qty. (PC)'), t073_diff_qty OPTIONS(description='INV Difference Qty.'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `ARTIKEL - VIEW BASED ON T_WAWI_INVENTORYDET`) AS WITH T73_INVENTORYDET AS (SELECT client_id,
    CASE
    WHEN client_id = 13 AND wh_id = 600
    THEN 60
    WHEN client_id = 18 AND wh_id = 20
    THEN 4
    WHEN client_id = 21 AND wh_id = 20
    THEN 22
    ELSE wh_id
    END AS wh_id,
   CONCAT(itemnumber, casesize) AS artikelnr,
   id AS form_nr,
   inventorynum,
   expected AS t073_exp_qty,
   totalqty AS t073_ges_qty,
   difference AS t073_diff_qty,
   dwh_load_id,
   dwh_created,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg
  FROM ldl_logop_data.t_wawi_inventorydet
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg), T72_INVENTORY AS (SELECT client_id,
    CASE
    WHEN client_id = 13 AND wh_nr = 600
    THEN 60
    WHEN client_id = 18 AND wh_nr = 20
    THEN 4
    WHEN client_id = 21 AND wh_nr = 20
    THEN 22
    ELSE wh_nr
    END AS wh_id,
   inventorynum,
   DATE(dayenddate) AS t072_date,
   c72_type AS inventorytype,
   dwh_load_id,
   dwh_created,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(CASE
        WHEN client_id = 13 AND wh_nr = 600
        THEN 60
        WHEN client_id = 18 AND wh_nr = 20
        THEN 4
        WHEN client_id = 21 AND wh_nr = 20
        THEN 22
        ELSE wh_nr
        END AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated,
   dwh_valid_from,
   dwh_valid_to,
   deleted_fg
  FROM ldl_logop_data.t_wawi_inventory
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND DATE(dayenddate) > DATE '2024-03-01'
   AND NOT deleted_fg) (SELECT a.client_id,
   a.wh_id,
   a.artikelnr,
   a.form_nr,
   a.inventorynum,
   b.inventorytype,
   b.t072_date,
   a.t073_exp_qty,
   a.t073_ges_qty,
   a.t073_diff_qty,
   a.dwh_load_id,
   a.dwh_created,
   a.dwh_updated,
   a.dwh_valid_from,
   a.dwh_valid_to,
   a.deleted_fg
  FROM T73_INVENTORYDET AS a
   INNER JOIN T72_INVENTORY AS b ON a.client_id = b.client_id AND a.wh_id = b.wh_id AND a.inventorynum = b.inventorynum
  );