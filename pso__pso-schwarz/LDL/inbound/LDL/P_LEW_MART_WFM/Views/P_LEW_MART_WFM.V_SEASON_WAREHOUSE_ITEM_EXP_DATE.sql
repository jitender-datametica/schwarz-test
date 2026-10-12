CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_SEASON_WAREHOUSE_ITEM_EXP_DATE
AS
   SELECT DISTINCT
   c.country_cd AS iso_cd
   ,mhd.wh_id
   ,TRY_CAST(COALESCE(itm.src_orig_item_nr,itm.config_item_cd,itm.src_matnr) AS DECIMAL(18,0)) AS orig_item_nr
   ,mhd.delivery_dt
   ,mhd.location_item_receipt_id
   ,mhd.receipt_type_id
   ,mhd.expire_dt
   ,mhd.receive_piece_qty
   ,mhd.dwh_created AS dwh_created_dt
   FROM
  (
   /*WAWI Part*/
   SELECT
      a.client_id
   ,a.src_wh_id                AS wh_id
   ,a.item_sid
   ,a.entry_dt                 AS delivery_dt
   ,CAST(CAST(a.location_item_receipt_id AS NUMBER(38))AS VARCHAR(20)) AS location_item_receipt_id
   ,a.receipt_type_id          AS receipt_type_id
   ,a.dat_min_durability_rcv   AS expire_dt
   ,a.receive_piece_qty        AS receive_piece_qty
   ,MAX(a.dwh_created) AS dwh_created
   FROM p_lew_bil_ac.v_mov_item_receive_wh AS a
   INNER JOIN p_lew_core_ac.v_client_migration_per mig
   ON mig.client_id = a.client_id
   AND (    a.entry_dt < mig.migration_dat_valid_from
         OR a.entry_dt > mig.migration_dat_valid_to
       )
 /* Only Records of last 40 Months */
   WHERE a.entry_dt  > ADD_MONTHS(CURRENT_DATE, -40)
 /*Only Records which have a min durability date defined*/
 AND a.dat_min_durability_rcv IS NOT NULL
 /*Only Records which has the receipt_type_id 1,2 or 3. 
 1 Wareneingang im WH
 2 Mengenkorrektur bzw. Ruecksendungskorrektur (bezieht sich immer auf Typ 1 oder 3
 3 Ruecksendung*/
 AND a.receipt_type_id IN(1,2,3)
 GROUP BY  1,2,3,4,5,6,7,8
 ) AS mhd
   INNER JOIN p_lew_core_ac.v_item AS itm
   ON itm.client_id = mhd.client_id
   AND itm.item_sid = mhd.item_sid
   INNER JOIN p_lew_core_ac.v_client AS c
   ON c.client_id = mhd.client_id
   WHERE orig_item_nr IS NOT NULL
;