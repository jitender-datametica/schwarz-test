CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_season_warehouse_item_exp_date_1 AS SELECT DISTINCT C.country_cd AS iso_cd,
 mhd.wh_id,
 ROUND(SAFE_CAST(COALESCE(ITM.src_orig_item_nr, ITM.config_item_cd, ITM.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
 mhd.delivery_dt,
 mhd.location_item_receipt_id,
 mhd.receipt_type_id,
 mhd.expire_dt,
 mhd.receive_piece_qty,
 mhd.dwh_created AS dwh_created_dt
FROM (SELECT A.client_id,
   A.src_wh_id AS wh_id,
   A.item_sid,
   A.entry_dt AS delivery_dt,
   CAST(CAST(A.location_item_receipt_id AS BIGNUMERIC) AS STRING) AS location_item_receipt_id,
   A.receipt_type_id,
   A.dat_min_durability_rcv AS expire_dt,
   A.receive_piece_qty,
   MAX(A.dwh_created) AS dwh_created
  FROM ldl_p_lew_bil_ac.v_mov_item_receive_wh_1 AS A
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON A.client_id = MIG.client_id AND (A.entry_dt < MIG.migration_dat_valid_from OR A.entry_dt > MIG.migration_dat_valid_to)
  WHERE A.entry_dt > IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 40 MONTH))
   AND A.receipt_type_id IN (1, 2, 3)
   AND A.dat_min_durability_rcv IS NOT NULL
  GROUP BY A.client_id,
   wh_id,
   A.item_sid,
   delivery_dt,
   location_item_receipt_id,
   A.receipt_type_id,
   expire_dt,
   A.receive_piece_qty) AS mhd
 INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON mhd.client_id = ITM.client_id AND mhd.item_sid = ITM.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C ON mhd.client_id = C.client_id;