CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_CORRELATION
AS
(
--
--  Verkauf Szenarien (Pf  AND  ,Storno  ,Kleinstbon ...)
--
SELECT
tr1.store_id,
tr1.client_id,
tr1.pos_terminal_id,
tr1.dat_formdate,
tr1.time_receipt_ejr,
tr1.orig_receipt_nr_ejr,
tr1.checker_id,
rl.authority_id,
tr1.scenario_id,
CASE WHEN rl.transactiontype_id IN ('101','102') THEN'Verkauf'
       WHEN rl.transactiontype_id IN ('120','122') THEN'Pfand'
       WHEN rl.transactiontype_id IN ('171','173') THEN'Storno'
  ELSE 'Sonstiges'
  END AS auth_type,
Sum(rl.val_retail_ejr) AS val_authorised_retail_ejr,
CAST(1 AS INTEGER) AS cnt_authorised_receipt
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower tr1
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract rl
ON tr1.client_id = rl.client_id
  AND tr1.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
  AND tr1.store_id = rl.store_id
  AND tr1.dat_formdate = rl.dat_formdate
  AND tr1.time_receipt_ejr = rl.time_receipt_ejr
  AND tr1.pos_terminal_id = rl.pos_terminal_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group sg
ON tr1.scenario_id = sg.scenario_id
WHERE SUBSTR( sg.scenario_id, 1, 1) = '1'
AND rl.transactiontype_id IN ('101','102','120','122','171','173')
AND tr1.transactiontype_id = '100'
AND rl.authority_id IS NOT NULL
GROUP BY
tr1.store_id
,tr1.client_id
,tr1.pos_terminal_id
,tr1.dat_formdate
,tr1.time_receipt_ejr
,tr1.orig_receipt_nr_ejr
,tr1.checker_id
,rl.authority_id
,tr1.scenario_id
,auth_type
UNION ALL
--
--  Geldrueckgabe Szenarien
--
SELECT
tr2.store_id,
tr2.client_id,
tr2.pos_terminal_id,
tr2.dat_formdate,
tr2.time_receipt_ejr,
tr2.orig_receipt_nr_ejr,
tr2.checker_id,
rl.authority_id,
tr2.scenario_id,
'Geldrückgabe' AS auth_type,
Sum(rl.val_retail_ejr) AS val_authorised_retail_ejr,
CAST(1 AS INTEGER) AS cnt_authorised_receipt
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower tr2
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract  rl
ON tr2.client_id = rl.client_id
  AND tr2.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
  AND tr2.store_id = rl.store_id
  AND tr2.dat_formdate = rl.dat_formdate
  AND tr2.time_receipt_ejr = rl.time_receipt_ejr
  AND tr2.pos_terminal_id = rl.pos_terminal_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group sg
ON tr2.scenario_id = sg.scenario_id
WHERE sg.scenario_group_id = 1
  AND rl.transactiontype_id BETWEEN '140'   AND '149'
  AND rl.authority_id IS NOT NULL
GROUP BY
  tr2.store_id
  ,tr2.client_id
  ,tr2.pos_terminal_id
  ,tr2.dat_formdate
  ,tr2.time_receipt_ejr
  ,tr2.orig_receipt_nr_ejr
  ,tr2.checker_id
  ,rl.authority_id
  ,tr2.scenario_id
UNION ALL
--
-- Bonrueckstellung   AND Bonabbruch
--
SELECT
tr3.store_id,
tr3.client_id,
tr3.pos_terminal_id,
tr3.dat_formdate,
tr3.time_receipt_ejr,
tr3.orig_receipt_nr_ejr,
tr3.checker_id,
tr3.authority_id,
tr3.scenario_id,
CASE WHEN sg.scenario_group_id = 5 THEN'Bonrückstellung' ELSE'Bonabbruch' END AS auth_type,
Sum(tr3.val_retail_ejr) AS val_authorised_retail_ejr,
CAST(1 AS INTEGER) AS cnt_authorised_receipt
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower tr3
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group sg
ON tr3.scenario_id = sg.scenario_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON tr3.store_id = revstr.store_id
  AND tr3.client_id = revstr.client_id
  AND tr3.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
WHERE sg.scenario_group_id IN (4  ,5)
  AND tr3.authority_id IS NOT NULL
GROUP BY
  tr3.store_id
  ,tr3.client_id
  ,tr3.pos_terminal_id
  ,tr3.dat_formdate
  ,tr3.time_receipt_ejr
  ,tr3.orig_receipt_nr_ejr
  ,tr3.checker_id
  ,tr3.authority_id
  ,tr3.scenario_id
  ,auth_type
UNION ALL
--
-- Preisanzeige
--
SELECT
tr4.store_id,
tr4.client_id,
tr4.pos_terminal_id,
tr4.dat_formdate,
tr4.time_receipt_ejr,
tr4.orig_receipt_nr_ejr,
tr4.checker_id,
tr4.authority_id,
tr4.scenario_id,
'Preisanzeige'  AS auth_type,
Sum(tr4.val_retail_ejr) AS val_authorised_retail_ejr,
CAST(1 AS INTEGER) AS cnt_authorised_receipt
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower tr4
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group sg
ON tr4.scenario_id = sg.scenario_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON tr4.store_id = revstr.store_id
  AND tr4.client_id = revstr.client_id
  AND tr4.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
WHERE SUBSTR( sg.scenario_id, 1, 1) = '6'
AND tr4.authority_id IS NOT NULL
GROUP BY
tr4.store_id
,tr4.client_id
,tr4.pos_terminal_id
,tr4.dat_formdate
,tr4.time_receipt_ejr
,tr4.orig_receipt_nr_ejr
,tr4.checker_id
,tr4.authority_id
,tr4.scenario_id
,auth_type
UNION ALL
--
-- An-/Abmeldung
--
SELECT
tr5.store_id,
tr5.client_id,
tr5.pos_terminal_id,
tr5.dat_formdate,
tr5.time_receipt_ejr,
tr5.orig_receipt_nr_ejr,
tr5.checker_id,
tr5.authority_id,
tr5.scenario_id,
'An/-Abmeldung' AS auth_type,
Cast(NULL AS DECIMAL(18,4))  AS val_authorised_retail_ejr,
CAST(1 AS INTEGER) AS cnt_authorised_receipt
FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower tr5
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group sg
ON tr5.scenario_id = sg.scenario_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk revstr
ON tr5.store_id = revstr.store_id
  AND tr5.client_id = revstr.client_id
  AND tr5.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until
WHERE SUBSTR( sg.scenario_id, 1, 1) = '2'
AND tr5.authority_id IS NOT NULL
GROUP BY
tr5.store_id
,tr5.client_id
,tr5.pos_terminal_id
,tr5.dat_formdate
,tr5.time_receipt_ejr
,tr5.orig_receipt_nr_ejr
,tr5.checker_id
,tr5.authority_id
,tr5.scenario_id
,auth_type
)
;



