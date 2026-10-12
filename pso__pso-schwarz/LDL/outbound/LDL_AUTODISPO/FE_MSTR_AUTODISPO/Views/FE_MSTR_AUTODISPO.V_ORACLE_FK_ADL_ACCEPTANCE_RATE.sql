CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_adl_acceptance_rate AS WITH ORDERS AS (SELECT
   COALESCE(FSFO.country, FSO.country) AS country,
   COALESCE(FSFO.item_nr, FSO.item_nr) AS item_nr,
   COALESCE(FSFO.supplier_nr, FSO.supplier_nr) AS supplier_nr,
   COALESCE(FSFO.wh, FSO.wh) AS supplier_wh,
   COALESCE(DATE(FSFO.generation_date), FSO.order_sent_date) AS generation_date,
   FSFO.item_packagecapacity AS fo_item_packagecapacity,
   FSO.item_packagecapacity,
   DATE(FSFO.orders_arrival_date) AS fo_delivery_date,
   FSO.orders_arrival_date,
   FSFO.order_unit_id AS fo_order_unit_id,
   FSFO.order_unit_quantity,
   FSO.orders_total,
   FSO.order_nr,
    CASE
    WHEN FSFO.order_unit_quantity = 0 OR FSO.orders_total = 0
    THEN 1
    ELSE 0
    END AS is_zero
  FROM ldl_autodispo_core.t_oracle_v_fk_supplier_final_order AS FSFO
   FULL JOIN ldl_autodispo_core.t_oracle_v_fk_supplier_order AS FSO ON FSFO.country = FSO.country AND FSFO.item_nr = FSO
        .item_nr AND FSFO.supplier_nr = FSO.supplier_nr AND FSFO.wh = FSO.wh AND DATE(FSFO.generation_date) = FSO.order_sent_date
     
  WHERE FSFO.is_sent_fg = 1
   AND FSFO.corrected_order_unit_id = - 1
   AND FSO.order_unit_id = - 1) (SELECT o.country,
   o.item_nr,
   o.supplier_nr,
   o.supplier_wh,
   o.generation_date,
   o.item_packagecapacity,
   o.fo_item_packagecapacity,
   o.fo_delivery_date,
   o.orders_arrival_date,
   o.fo_order_unit_id,
   o.orders_total,
   o.order_nr,
   o.is_zero,
   DSH.shc_unit_name,
   DAPC.pac_package_count,
   DSI.active,
   DIS.dis_status AS status,
   o.order_unit_quantity AS order_qty_adl,
    CASE
    WHEN o.fo_order_unit_id = 0
    THEN IFNULL(o.orders_total / o.item_packagecapacity, 0)
    ELSE IFNULL(o.orders_total / o.item_packagecapacity / DAPC.pac_package_count, 0)
    END AS order_qty_dis,
    CASE
    WHEN o.order_unit_quantity = 0 AND o.orders_total IS NULL
    THEN 1
    WHEN o.order_unit_quantity = CASE
       WHEN o.fo_order_unit_id = 0
       THEN IFNULL(o.orders_total / o.item_packagecapacity, 0)
       ELSE IFNULL(o.orders_total / o.item_packagecapacity / DAPC.pac_package_count, 0)
       END AND o.fo_delivery_date = o.orders_arrival_date
    THEN 1
    ELSE 0
    END AS check_qty,
   1 AS number_of_items
  FROM ORDERS AS o
   LEFT JOIN ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_item_status_all AS DIS ON o.country = DIS.country AND o.supplier_wh
        = DIS.dis_wh AND o.item_nr = DIS.dis_item_nr AND o.fo_item_packagecapacity = DIS.dis_packagecapacity
   LEFT JOIN ldl_autodispo_core.t_oracle_v_dim_supplier_item_hist AS DSI ON o.country = DSI.country AND o.item_nr = DSI
         .item_nr AND o.supplier_wh = DSI.supplier_wh AND o.supplier_nr = DSI.supplier_nr AND o.fo_item_packagecapacity
      = DSI.item_packagecapacity AND o.generation_date BETWEEN DATE(DATETIME_ADD(DSI.dwh_valid_from_tmsp, INTERVAL 12
       HOUR)) AND (DATE(DATETIME_ADD(DSI.dwh_valid_to_tmsp, INTERVAL - 12 HOUR)))
   LEFT JOIN ldl_autodispo_core.t_oracle_v_dim_art_pack_conv AS DAPC ON o.country = DAPC.country AND o.item_nr = DAPC.pac_item_nr
         AND o.fo_item_packagecapacity = DAPC.pac_item_packagecapacity AND o.supplier_wh = DAPC.pac_wh AND o.fo_order_unit_id
      = DAPC.pac_article_unit
   LEFT JOIN ldl_autodispo_core.t_oracle_v_dic_shc AS DSH ON o.fo_order_unit_id = DSH.shc_unit_id
  WHERE DSI.active = 1
   AND DSI.deleted = 0);