/* Pfand-EANs Pruefung. Ob die EANs 19 || 24 -stellig sind */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_transact_deposit_ean AS
-- CROSS JOIN to *load_store to get only the relevant stores
 SELECT RL.client_id,
 RL.store_id,
 RL.pos_terminal_id,
 RL.time_receipt_ejr,
 RL.dat_formdate,
 RL.orig_receipt_nr_ejr,
 RL.checker_id,
 RL.barcode,
  CASE
  WHEN LENGTH(RL.barcode) = 19
  THEN SUBSTR(RL.barcode, 1, 13)
  WHEN LENGTH(RL.barcode) = 24
  THEN SUBSTR(RL.barcode, 1, 3) || SUBSTR(RL.barcode, 15, 10)
  ELSE NULL
  END AS pfand_ean,
 SUM(1) OVER (PARTITION BY RL.client_id, RL.store_id, RL.checker_id, CASE
     WHEN LENGTH(RL.barcode) = 19
     THEN SUBSTR(RL.barcode, 1, 13) || '19'
     WHEN LENGTH(RL.barcode) = 24
     THEN SUBSTR(RL.barcode, 1, 3) || SUBSTR(RL.barcode, 15, 10) || '24'
     ELSE NULL
     END RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_all_deposit_ean_cnt,
 SUM(CASE
   WHEN RL.item_entry_method_cd_ejr = 'KE'
   THEN 1
   ELSE 0
   END) OVER (PARTITION BY RL.client_id, RL.store_id, RL.checker_id, CASE
     WHEN LENGTH(RL.barcode) = 19
     THEN SUBSTR(RL.barcode, 1, 13) || '19'
     WHEN LENGTH(RL.barcode) = 24
     THEN SUBSTR(RL.barcode, 1, 3) || SUBSTR(RL.barcode, 15, 10) || '24'
     ELSE NULL
     END RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_man_deposit_ean,
 1 AS cnt_all_deposit_ean
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract AS RL
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk AS REVSTR ON RL.store_id = REVSTR.store_id AND
    RL.client_id = REVSTR.client_id AND RL.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
WHERE (RL.transactiontype_id = '120' OR RL.transactiontype_id = '122')
 AND CASE
  WHEN LENGTH(RL.barcode) = 19
  THEN SUBSTR(RL.barcode, 1, 13)
  WHEN LENGTH(RL.barcode) = 24
  THEN SUBSTR(RL.barcode, 1, 3) || SUBSTR(RL.barcode, 15, 10)
  ELSE NULL
  END IS NOT NULL
QUALIFY (SUM(1) OVER (PARTITION BY RL.client_id, RL.store_id, RL.checker_id, CASE
       WHEN LENGTH(RL.barcode) = 19
       THEN SUBSTR(RL.barcode, 1, 13) || '19'
       WHEN LENGTH(RL.barcode) = 24
       THEN SUBSTR(RL.barcode, 1, 3) || SUBSTR(RL.barcode, 15, 10) || '24'
       ELSE NULL
       END RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1;