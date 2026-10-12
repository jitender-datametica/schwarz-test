CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_adl_acceptance_rate_ui_2 (country_2, wh, item_nr,
item_packagecapacity, supplier_nr, generation_date, orders_arrival_date, ord_unit_id, order_unit_quantity,
corrected_order_unit_quantity, corrected_order_unit_id, order_sent_date, calculation_number, orders_total,
orders_arrival_date_dis, order_unit_id_dis, order_nr, is_zero, shc_unit_name, pac_package_count, active, status_2,
order_qty_dis, check_qty, check_dis, number_of_items)
OPTIONS(DESCRIPTION = `VERSION: 1.4 - CHANGING CROSS JOIN CONDITION TO DELIVERY DATE; SUM UP DIS ORDERS`) AS WITH DIS AS
  (SELECT country_2,
   wh,
   item_nr,
   item_packagecapacity,
   supplier_nr,
   orders_arrival_date AS orders_arrival_date_dis,
   order_unit_id AS order_unit_id_dis,
   STRING_AGG(CAST(order_nr AS STRING), ', ' ORDER BY order_sent_date IS NULL, order_sent_date) AS order_nr,
   SUM(orders_total) AS orders_total
  FROM ldl_autodispo_core.t_oracle_v_fk_supplier_order_2
  WHERE order_unit_id <> - 1
  GROUP BY country_2,
   wh,
   item_nr,
   item_packagecapacity,
   supplier_nr,
   orders_arrival_date_dis,
   order_unit_id_dis), ORDERS AS (SELECT FSFO.country_2,
   FSFO.wh,
   FSFO.item_nr,
   FSFO.item_packagecapacity,
   FSFO.supplier_nr,
   FSFO.generation_date,
   FSFO.orders_arrival_date,
   FSFO.order_unit_id,
   FSFO.order_unit_quantity,
   FSFO.corrected_order_unit_quantity,
   FSFO.corrected_order_unit_id,
   FSFO.order_sent_date,
   FSFO.calculation_number,
   fso.orders_total,
   fso.orders_arrival_date_dis,
   fso.order_unit_id_dis,
   fso.order_nr,
    CASE
    WHEN FSFO.order_unit_quantity = 0 AND FSFO.corrected_order_unit_quantity = 0
    THEN 1
    ELSE 0
    END AS is_zero
  FROM ldl_autodispo_core.t_oracle_v_fk_supplier_final_order_2 AS FSFO
   LEFT JOIN DIS AS fso ON FSFO.country_2 = fso.country_2 AND FSFO.wh = fso.wh AND FSFO.item_nr = fso.item_nr AND FSFO.item_packagecapacity
        = fso.item_packagecapacity AND FSFO.supplier_nr = fso.supplier_nr AND FSFO.orders_arrival_date = fso.orders_arrival_date_dis
     
  WHERE FSFO.is_sent_fg = 1
   AND FSFO.corrected_order_unit_id <> - 1) (SELECT o.country_2,
   o.wh,
   o.item_nr,
   o.item_packagecapacity,
   o.supplier_nr,
   DATE(o.generation_date),
   o.orders_arrival_date,
   o.order_unit_id AS ord_unit_id,
   o.order_unit_quantity,
   o.corrected_order_unit_quantity,
   o.corrected_order_unit_id,
   o.order_sent_date,
   o.calculation_number,
   o.orders_total,
   o.orders_arrival_date_dis,
   o.order_unit_id_dis,
   o.order_nr,
   o.is_zero,
   DSH.shc_unit_name,
   DAPC.pac_package_count,
   DSI.active,
   DIS.dis_status AS status_2,
   IFNULL(o.orders_total / o.item_packagecapacity / DAPC.pac_package_count, 0) AS order_qty_dis,
    CASE
    WHEN o.order_unit_quantity = o.corrected_order_unit_quantity AND o.order_unit_id = o.corrected_order_unit_id
    THEN 1
    ELSE 0
    END AS check_qty,
    CASE
    WHEN o.corrected_order_unit_quantity = 0 AND o.orders_total IS NULL
    THEN 0
    WHEN o.corrected_order_unit_quantity = IFNULL(o.orders_total / o.item_packagecapacity / DAPC.pac_package_count, 0)
     AND o.order_unit_id = o.order_unit_id_dis
    THEN 0
    ELSE 1
    END AS check_dis,
   1 AS number_of_items
  FROM ORDERS AS o
   LEFT JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_item_status_all_2 AS DIS ON o.country_2 = DIS.country_2 AND o.wh =
       DIS.dis_wh AND o.item_nr = DIS.dis_item_nr AND o.item_packagecapacity = DIS.dis_packagecapacity
   LEFT JOIN ldl_autodispo_core.t_oracle_v_dim_supplier_item_hist_2 AS DSI ON o.country_2 = DSI.country_2 AND o.item_nr = DSI
         .item_nr AND o.wh = DSI.supplier_wh AND o.supplier_nr = DSI.supplier_nr AND o.item_packagecapacity = DSI.item_packagecapacity
       AND CAST(o.generation_date AS DATE) BETWEEN DATE(DATETIME_ADD(DSI.dwh_valid_from_tmsp, INTERVAL 12 HOUR)) AND (DATE(DATETIME_ADD(DSI
        .dwh_valid_to_tmsp, INTERVAL - 12 HOUR)))
   LEFT JOIN ldl_autodispo_core.t_oracle_v_dim_art_pack_conv_2 AS DAPC ON o.country_2 = DAPC.country_2 AND o.item_nr = DAPC.pac_item_nr
         AND o.item_packagecapacity = DAPC.pac_item_packagecapacity AND o.wh = DAPC.pac_wh AND o.order_unit_id_dis =
     DAPC.pac_article_unit
   LEFT JOIN ldl_autodispo_core.t_oracle_v_dic_shc_2 AS DSH ON o.order_unit_id = DSH.shc_unit_id
  WHERE DSI.active = 1
   AND DSI.deleted = 0);