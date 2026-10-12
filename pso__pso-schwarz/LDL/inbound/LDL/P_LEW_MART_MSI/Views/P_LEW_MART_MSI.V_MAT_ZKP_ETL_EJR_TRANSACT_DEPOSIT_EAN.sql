CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_TRANSACT_DEPOSIT_EAN
AS
/* Pfand-EANs Pruefung. Ob die EANs 19 || 24 -stellig sind */
SELECT
rl.client_id,
rl.store_id,
rl.pos_terminal_id,
rl.time_receipt_ejr,
rl.dat_formdate,
rl.orig_receipt_nr_ejr,
rl.checker_id,
rl.barcode,
CASE
       WHEN LENGTH(rl.barcode) = 19 THEN SUBSTRING(rl.barcode, 1, 13)
WHEN LENGTH(rl.barcode) = 24 THEN SUBSTRING(rl.barcode, 1, 3) || SUBSTRING(rl.barcode, 15, 10)
ELSE NULL
END AS pfand_ean,
Sum(1) Over (PARTITION BY
      rl.client_id
      ,rl.store_id
      ,rl.checker_id
      ,CASE
           WHEN LENGTH(rl.barcode) = 19 THEN SUBSTRING(rl.barcode, 1, 13) ||'19'
WHEN LENGTH(rl.barcode) = 24 THEN SUBSTRING(rl.barcode, 1, 3) || SUBSTRING(rl.barcode, 15, 10) ||'24'
ELSE NULL
END) AS cnt_all_deposit_ean_cnt,
Sum((CASE WHEN rl.item_entry_method_cd_ejr = 'KE' THEN 1 ELSE 0 END) ) Over (PARTITION BY
      rl.client_id
      ,rl.store_id
      ,rl.checker_id
      ,CASE
           WHEN LENGTH(rl.barcode) = 19 THEN SUBSTRING(rl.barcode, 1, 13) ||'19'
WHEN LENGTH(rl.barcode) = 24 THEN SUBSTRING(rl.barcode, 1, 3) || SUBSTRING(rl.barcode, 15, 10) ||'24'
ELSE NULL
END) AS cnt_man_deposit_ean,
1 AS cnt_all_deposit_ean
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract rl
-- Join to *load_store to get only the relevant stores
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON rl.store_id = revstr.store_id
  AND rl.client_id = revstr.client_id
  AND rl.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
WHERE  (rl.transactiontype_id = '120'  OR rl.transactiontype_id = '122')
  AND (CASE
             WHEN LENGTH(rl.barcode) = 19 THEN SUBSTRING(rl.barcode, 1, 13)
WHEN LENGTH(rl.barcode) = 24 THEN SUBSTRING(rl.barcode, 1, 3) || SUBSTRING(rl.barcode, 15, 10)
ELSE NULL
END) IS NOT NULL
QUALIFY cnt_all_deposit_ean_cnt > 1
;





