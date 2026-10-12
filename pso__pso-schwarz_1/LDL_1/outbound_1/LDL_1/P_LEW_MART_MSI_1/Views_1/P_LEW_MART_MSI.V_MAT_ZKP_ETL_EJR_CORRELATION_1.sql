-- An-/Abmeldung
 -- 
 -- Bonrueckstellung   AND Bonabbruch
 -- 
 -- 
 -- 

-- Verkauf Szenarien (Pf  AND  ,Storno  ,Kleinstbon ...)
 -- Geldrueckgabe Szenarien
 -- 
 -- Preisanzeige
 -- 
 -- 

-- 
 -- 
 -- 
 CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_correlation_1 AS SELECT TR1.store_id,
 TR1.client_id,
 TR1.pos_terminal_id,
 TR1.dat_formdate,
 TR1.time_receipt_ejr,
 TR1.orig_receipt_nr_ejr,
 TR1.checker_id,
 RL.authority_id,
 TR1.scenario_id,
  CASE
  WHEN RL.transactiontype_id IN ('101', '102')
  THEN 'Verkauf'
  WHEN RL.transactiontype_id IN ('120', '122')
  THEN 'Pfand'
  WHEN RL.transactiontype_id IN ('171', '173')
  THEN 'Storno'
  ELSE 'Sonstiges'
  END AS auth_type,
 SUM(RL.val_retail_ejr) AS val_authorised_retail_ejr,
 1 AS cnt_authorised_receipt
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS TR1
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS RL ON TR1.client_id = RL.client_id AND TR1.orig_receipt_nr_ejr
        = RL.orig_receipt_nr_ejr AND TR1.store_id = RL.store_id AND TR1.dat_formdate = RL.dat_formdate AND TR1.time_receipt_ejr
     = RL.time_receipt_ejr AND TR1.pos_terminal_id = RL.pos_terminal_id
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group_1 AS SG ON TR1.scenario_id = SG.scenario_id
WHERE SUBSTR(SG.scenario_id, 1, 1) = '1'
 AND RL.transactiontype_id IN ('101', '102', '120', '122', '171', '173')
 AND TR1.transactiontype_id = '100'
 AND RL.authority_id IS NOT NULL
GROUP BY TR1.store_id,
 TR1.client_id,
 TR1.pos_terminal_id,
 TR1.dat_formdate,
 TR1.time_receipt_ejr,
 TR1.orig_receipt_nr_ejr,
 TR1.checker_id,
 RL.authority_id,
 TR1.scenario_id,
 auth_type
UNION ALL
SELECT TR2.store_id,
 TR2.client_id,
 TR2.pos_terminal_id,
 TR2.dat_formdate,
 TR2.time_receipt_ejr,
 TR2.orig_receipt_nr_ejr,
 TR2.checker_id,
 RL.authority_id,
 TR2.scenario_id,
 'Geldrückgabe' AS auth_type,
 SUM(RL.val_retail_ejr) AS val_authorised_retail_ejr,
 1 AS cnt_authorised_receipt
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS TR2
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS RL ON TR2.client_id = RL.client_id AND TR2.orig_receipt_nr_ejr
        = RL.orig_receipt_nr_ejr AND TR2.store_id = RL.store_id AND TR2.dat_formdate = RL.dat_formdate AND TR2.time_receipt_ejr
     = RL.time_receipt_ejr AND TR2.pos_terminal_id = RL.pos_terminal_id
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group_1 AS SG ON TR2.scenario_id = SG.scenario_id
WHERE SG.scenario_group_id = 1
 AND RL.transactiontype_id BETWEEN '140' AND '149'
 AND RL.authority_id IS NOT NULL
GROUP BY TR2.store_id,
 TR2.client_id,
 TR2.pos_terminal_id,
 TR2.dat_formdate,
 TR2.time_receipt_ejr,
 TR2.orig_receipt_nr_ejr,
 TR2.checker_id,
 TR2.scenario_id,
 RL.authority_id
UNION ALL
SELECT TR3.store_id,
 TR3.client_id,
 TR3.pos_terminal_id,
 TR3.dat_formdate,
 TR3.time_receipt_ejr,
 TR3.orig_receipt_nr_ejr,
 TR3.checker_id,
 TR3.authority_id,
 TR3.scenario_id,
  CASE
  WHEN SG.scenario_group_id = 5
  THEN 'Bonrückstellung'
  ELSE 'Bonabbruch'
  END AS auth_type,
 SUM(TR3.val_retail_ejr) AS val_authorised_retail_ejr,
 1 AS cnt_authorised_receipt
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS TR3
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group_1 AS SG ON TR3.scenario_id = SG.scenario_id
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON TR3.store_id = REVSTR.store_id
   AND TR3.client_id = REVSTR.client_id AND TR3.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
   
WHERE SG.scenario_group_id IN (4, 5)
 AND TR3.authority_id IS NOT NULL
GROUP BY TR3.store_id,
 TR3.client_id,
 TR3.pos_terminal_id,
 TR3.dat_formdate,
 TR3.time_receipt_ejr,
 TR3.orig_receipt_nr_ejr,
 TR3.checker_id,
 TR3.authority_id,
 TR3.scenario_id,
 auth_type
UNION ALL
SELECT TR4.store_id,
 TR4.client_id,
 TR4.pos_terminal_id,
 TR4.dat_formdate,
 TR4.time_receipt_ejr,
 TR4.orig_receipt_nr_ejr,
 TR4.checker_id,
 TR4.authority_id,
 TR4.scenario_id,
 'Preisanzeige' AS auth_type,
 SUM(TR4.val_retail_ejr) AS val_authorised_retail_ejr,
 1 AS cnt_authorised_receipt
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS TR4
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group_1 AS SG ON TR4.scenario_id = SG.scenario_id
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON TR4.store_id = REVSTR.store_id
   AND TR4.client_id = REVSTR.client_id AND TR4.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
   
WHERE SUBSTR(SG.scenario_id, 1, 1) = '6'
 AND TR4.authority_id IS NOT NULL
GROUP BY TR4.store_id,
 TR4.client_id,
 TR4.pos_terminal_id,
 TR4.dat_formdate,
 TR4.time_receipt_ejr,
 TR4.orig_receipt_nr_ejr,
 TR4.checker_id,
 TR4.authority_id,
 TR4.scenario_id,
 auth_type
UNION ALL
SELECT TR5.store_id,
 TR5.client_id,
 TR5.pos_terminal_id,
 TR5.dat_formdate,
 TR5.time_receipt_ejr,
 TR5.orig_receipt_nr_ejr,
 TR5.checker_id,
 TR5.authority_id,
 TR5.scenario_id,
 'An/-Abmeldung' AS auth_type,
 CAST(NULL AS NUMERIC) AS val_authorised_retail_ejr,
 1 AS cnt_authorised_receipt
FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS TR5
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_rel_scenario_to_group_1 AS SG ON TR5.scenario_id = SG.scenario_id
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON TR5.store_id = REVSTR.store_id
   AND TR5.client_id = REVSTR.client_id AND TR5.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
   
WHERE SUBSTR(SG.scenario_id, 1, 1) = '2'
 AND TR5.authority_id IS NOT NULL
GROUP BY TR5.store_id,
 TR5.client_id,
 TR5.pos_terminal_id,
 TR5.dat_formdate,
 TR5.time_receipt_ejr,
 TR5.orig_receipt_nr_ejr,
 TR5.checker_id,
 TR5.authority_id,
 TR5.scenario_id,
 auth_type;