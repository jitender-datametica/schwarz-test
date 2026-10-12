/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_REL_TRANS_TO_TRANS_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  16.05.2019    Morris, Michael          20190516_2087_MFRB - scenario 55 corrected
#  1.3  03.07.2019    Morris, Michael          20190703_2143_ZKP_MFRGB Thresholdanpassung fur scenario_group_id = 55
#  1.4  09.09.2019    Morris, Michael          20190904_2211_ZKP_all_agg_kz (Jira: LEAD-7979): 6 neue scenario_group_id
#                                              (1001 - 1006) fur die 6 neue aggregierten gesamt Kennzahlen.
#  1.5  21.10.2019    Morris, Michael          20191021_2259_ZKP_BBT_272_398 (Jira: LEAD-7462): New scenario_group_id 57 & 58.
#  1.6  11.11.2019    Morris, Michael          20191107_2280_HF_ZKP_SG_57_58 (Jira: LEAD-7462): NOT IN Liste erganzt fur 57 und 58
#  1.7  20.11.2019    Morris, Michael          20191125_2303_HF_ZKP_trans2trans_398 (LEAD-7462): Line 413 - Un-comment
#  1.8  20.11.2019    Morris, Michael          20191114_2289_ZKP_SG_59_60 (LEAD-8205): New Scenarios 59 & 60.
#  1.9  04.12.2019    Morris, Michael          20191114_2287_ZKP_SG_61 (REP1-6730) - New logic for scenario_group_id 55 & 61
#  2.0  13.01.2020    Morris, Michael          20200113_2343_SG_36_37_korrektur (REP1-6622) - Anpassung der scenario_group_id 36 & 37
#  2.1  24.01.2020    Morris, Michael          20200124_2356_ZKP_trans2trans_INC1635754 (REP1-13266) - bug fix in scenario_group_id = 1004 - store_id of original sale receipt fixed.
#  2.2  30.01.2020    Morris, Michael          20200130_2361_ZKP_t2t_61_dup (REP1-13250) - bug fix duplicates in scenario_group_id = 61
#  2.3  04.02.2020    Morris, Michael          20200204_2366_ZKP_t2t_INC1635754_2 (REP1-13250): Bug fix - LEFT OUTER JOIN for table
#                                                                                               #X_LEW_MART_MSI#.v_mat0_zkp_etl_sys_revision_load_store_wrk_1
#                                                                                               in scenario_group_id = 1004.
#  2.4  27.02.2020    Morris, Michael          20200227_2410_ZKP_t2t_55_qual (REP1-13531) - scenario_group_id = 55 - QUALIFY erganzt mit rd.p_checker_id
#  2.5  26.05.2020    Wandtke, Andrzej         20200526_2482_ZKP_Einzelbedienerbericht: new sections for columns is_return_not_dv, is_return_dv, is_return_orig_same_checker, is_return_orig_same_checker_day, is_return_no_orig_receipt
#  2.6  23.10.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: New section for discount (Rabatt) metrics
#  2.7  28.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Added scenarios 68, 69
#  2.8  28.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Amend transaction type list in scenarios 67, 68, 69
#  2.9  29.12.2020    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Complete column comments
#  3.0  05.01.2021    Wandtke, Andrzej         20201023_2631_ZKP_Rabatt: Scenarios 68, 69: correct joins with v_ejr_lp_threshold_manual_1
#  3.1  22.01.2021    Wandtke, Andrzej         AP0056021 Migrate to SF
#  3.2  13.05.2021    Wandtke, Andrzej         AP0056038 20210216_2750_ZKP_RET_NO_RECEIPT: Add scenario 70 (scanned returns); scenario 66: set return value in val_retail_ejr, remove condition rt1.s_orig_receipt_nr_ejr IS NOT NULL
#  3.3  24.06.2021    Wandtke, Andrzej         AP0056038 20210526_2845_ZKP_TRANS_RECEIPT: scenarios 62, 63, 64, 65, 70: remove condition rt1.s_orig_receipt_nr_ejr IS NOT NULL
#  3.4  21.07.2021    Wandtke, Andrzej         AP0056037 20210428_2816_ZKP_Void_Tran: Add scenarios 71, 72, 73, 74, 75, 76
#  3.5  04.10.2021    Wandtke, Andrzej         AP0056037 20210428_2816_ZKP_Void_Tran: Remove scenario 21 from the 1st section, add separate section for scenario 21
#  3.6  10.12.2021    Wandtke, Andrzej         AP0085915_ZKP_SHOW_PRICE scenario 49: show 1 transaction before and 1 transaction after price series
#                                                                       scenarios 36,37: include series: flag in (1,2)
#  3.7  15.11.2022    Wandtke, Andrzej         AP0105940-ZKP - Neues Szenario Pfandbon manuell+rein - add new section (Scenario 77)
#  3.8  20.03.2023    Wandtke, Andrzej         AP0152808 - Szenario Geldruckgabe ohne Originalbon (manuell) - add new section (Scenario 78)
#  3.9  13.04.2023    Wandtke, Andrzej         AP0170366 - Szenario Geldruckgabe mehrerer Artikel_1 eines Originalbons - add new sections (Scenarios 79, 80)
#  4.0  07.07.2023    Kowalik, Aleksander      AP0122629 - Anpassung Kennzahlen Preisanzeige - added new sections (Scenarios 81,82,83,84)
#  4.1  24.07.2023    Wandtke, Andrzej         INC4030732 AP0140277_ZKP_discount_filter - scenarios 67, 68, 69: add condition : AND NOT ((BARCODE LIKE '55%' OR BARCODE LIKE '56%') AND LENGTH(BARCODE) BETWEEN 15 AND 17) in order to exclude scanned discounts
#                                                                                - scenarios 67, 68: exclude discounts 0.01 and lower. In the scenario 69 there is already a threshold on discount value.
#-----------------------------------------------------------------------------
#  4.1  28.08.2023    Kowalik, Aleksander      AP0177990 - Anpassung Szenario Geldruckgabe - Originalbon gleicher Bediener - added new sections (Scenarios 85,86)
#  4.2  11.09.2023    Wandtke, Andrzej         AP0177990 - Anpassung Szenario Geldruckgabe - Originalbon gleicher Bediener - added new section (Scenario 87)
#  4.3  21.11.2023    Wandtke,Andrzej          AP0150752 - scenarios 57, 58, 33, 35, 34: add skipped transactions 400, 405, 420, 425, 430, 480 to the Bonausdruck
#  4.4  11.01.2024    Szewczyk, Milosz         AP0182639 - new scenarios 88,89,90,91,92,93,94,95,96
#  4.5  12.03.2024    Wandtke,Andrzej          INC7594606 - scenario 87: remove duplicates
#  4.6  27.03.2024    Szewczyk, Milosz         AP0188368 - new scenario 99
#  4.7  18.04.2024    Kowalik, Aleksander      AP0198132 - new scenarios 97,98 and 1007 (Bonabbruch+Kleinstbon, Bonabbruch+Abmeldung, Alle Bonabbruche)
#  4.8  10.06.2024    Vanchenko, Yurii         AP0198116 - new scenarios 100, 101, 102 (Geldrückgabe Bar, EC-Karte, anderen Tag_1 gleicher Bediener)
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_REL_TRANS_TO_TRANS_1
AS
   SELECT
    tr.c_store_id
   ,tr.c_client_id
   ,tr.c_pos_terminal_id
   ,tr.c_dat_formdate
   ,tr.c_time_receipt_ejr
   ,tr.c_orig_receipt_nr_ejr
   ,tr.c_checker_id
   ,tr.c_transaction_type_id
   ,tr.p_store_id
   ,tr.p_client_id
   ,tr.p_pos_terminal_id
   ,tr.p_dat_formdate
   ,tr.p_time_receipt_ejr
   ,tr.p_proof_object_nr_ejr
   ,tr.p_checker_id
   ,tr.scenario_group_id
   ,tr.resumed_trans_seqnr
   ,tr.val_retail_ejr                                       AS p_val_retail_ejr
   FROM
   (
   SELECT
      t.store_id                                              AS p_store_id
	 ,t.client_id                                             AS p_client_id
	 ,t.pos_terminal_id                                       AS p_pos_terminal_id
	 ,t.dat_formdate                                          AS p_dat_formdate
	 ,CAST(t.time_receipt_ejr    AS VARCHAR(8))               AS p_time_receipt_ejr
	 ,CAST(t.orig_receipt_nr_ejr AS VARCHAR(13))              AS p_proof_object_nr_ejr
	 ,t.checker_id                                            AS p_checker_id
	 ,sg.scenario_group_id                                    AS scenario_group_id
	 ,t.store_id                                              AS c_store_id
	 ,t.client_id                                             AS c_client_id
	 ,t.pos_terminal_id                                       AS c_pos_terminal_id
	 ,t.dat_formdate                                          AS c_dat_formdate
	 ,t.time_receipt_ejr                                      AS c_time_receipt_ejr
	 ,t.orig_receipt_nr_ejr                                   AS c_orig_receipt_nr_ejr
	 ,t.checker_id                                            AS c_checker_id
	 ,t.transactiontype_id                                    AS c_transaction_type_id
	 ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
	 ,t.val_retail_ejr                                        AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_all_transact_1 t
   INNER JOIN p_lew_mart_msi.v_ejr_lp_rel_scenario_to_group_1 sg
   ON t.scenario_id = sg.scenario_id
   WHERE sg.scenario_group_id NOT IN (21,33,34,35,36,37,24,40,41,42,20,45,53,55,57,58,59,60,61)
   UNION ALL
   /* Section for scenario_group_id 36 & 37 Preisanzeige + Kleinstbon/ Preisanzeige + Abmeldung */
   SELECT DISTINCT
    sp.store_id                                             AS p_store_id
   ,sp.client_id                                            AS p_client_id
   ,sp.pos_terminal_id                                      AS p_pos_terminal_id
   ,sp.dat_formdate                                         AS p_dat_formdate
   ,CAST(atf.time_receipt_ejr AS VARCHAR(8))                AS p_time_receipt_ejr
   ,CAST(sp.pr_show_orig_receipt_nr_ejr AS VARCHAR(13))     AS p_proof_object_nr_ejr
   ,sp.checker_id                                           AS p_checker_id
   ,CASE WHEN sp.is_kleinstbon IN (1,2) THEN CAST(36 AS SMALLINT)
        WHEN sp.is_abmeldung IN (1,2) THEN CAST(37 AS SMALLINT)
        ELSE NULL
    END                                                     AS scenario_group_id
   ,sp.store_id                                             AS c_store_id
   ,sp.client_id                                            AS c_client_id
   ,sp.pos_terminal_id                                      AS c_pos_terminal_id
   ,sp.dat_formdate                                         AS c_dat_formdate
   ,atf.time_receipt_ejr                                    AS c_time_receipt_ejr
   ,atf.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
   ,atf.checker_id                                          AS c_checker_id
   ,atf.transactiontype_id                                  AS c_transactiontype_id
   ,1                                                       AS resumed_trans_seqnr
   ,atf.val_retail_ejr                                      AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_show_price_1 sp
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   ON sp.client_id                 = atf.client_id
   AND sp.store_id                 = atf.store_id
   AND sp.dat_formdate             = atf.dat_formdate
   AND sp.pos_terminal_id          = atf.pos_terminal_id
   AND sp.checker_id               = atf.checker_id
   AND  atf.orig_receipt_nr_ejr BETWEEN sp.orig_receipt_nr_ejr AND CASE WHEN sp.is_abmeldung = 1 THEN sp.next_orig_receipt_nr_ejr+1 ELSE sp.next_orig_receipt_nr_ejr END
   -- For logoff operation (Abmeldung), show one more operation (Anmeldung)
   WHERE (sp.is_kleinstbon IN(1 ,2)
       OR sp.is_abmeldung  IN(1 ,2))
   UNION ALL
   SELECT
      st1.resumed_trans_store_id_ejr                          AS p_store_id
	 ,st1.client_id                                           AS p_client_id
	 ,st1.resumed_trans_terminal_id_ejr                       AS p_pos_terminal_id
	 ,st1.resumed_trans_date_ejr                              AS p_dat_formdate
	 ,CAST('00:00:00'                       AS VARCHAR(8))    AS p_time_receipt_ejr
	 ,CAST(st1.resumed_trans_receipt_nr_ejr AS VARCHAR(13))   AS p_proof_object_nr_ejr
	 ,st1.checker_id                                          AS p_checker_id
	 ,CASE WHEN st1.is_resumed_aborted    = 1 THEN CAST(33 AS SMALLINT)
           WHEN st1.is_new_item_in_resume = 1 THEN CAST(35 AS SMALLINT)
           ELSE NULL
      END                                                    AS scenario_group_id
	 ,st1.store_id                                            AS c_store_id
	 ,st1.client_id                                           AS c_client_id
	 ,st1.pos_terminal_id                                     AS c_pos_terminal_id
	 ,st1.dat_formdate                                        AS c_dat_formdate
	 ,st1.time_receipt_ejr                                    AS c_time_receipt_ejr
	 ,st1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
	 ,st1.checker_id                                          AS c_checker_id
	 ,st1.transactiontype_id                                  AS c_transactiontype_id
	 ,st1.resumed_trans_seqnr                                 AS resumed_trans_seqnr
	 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_suspended_transact_1 st1
   WHERE st1.is_suspend_gt_10  = 1
     AND st1.is_next_tran_cond = 1
     AND st1.same_checker_fg   = 1
     AND ( st1.is_resumed_aborted = 1 OR st1.is_new_item_in_resume = 1)
   UNION ALL
   -- add skipped transactions
   SELECT DISTINCT
     atf.store_id                                          AS p_store_id
	,atf.client_id                                         AS p_client_id
	,atf.pos_terminal_id                                   AS p_pos_terminal_id
	,atf.dat_formdate                                      AS p_dat_formdate
	,CAST(atf.time_receipt_ejr AS VARCHAR(8))              AS p_time_receipt_ejr
	,CAST(st1.resumed_trans_receipt_nr_ejr AS VARCHAR(13)) AS p_proof_object_nr_ejr
	,atf.checker_id                                        AS p_checker_id
	,CASE WHEN st1.is_resumed_aborted    = 1 THEN CAST(33 AS SMALLINT)
          WHEN st1.is_new_item_in_resume = 1 THEN CAST(35 AS SMALLINT)
          ELSE NULL
     END                                                   AS scenario_group_id
	,atf.store_id                                          AS c_store_id
	,atf.client_id                                         AS c_client_id
	,atf.pos_terminal_id                                   AS c_pos_terminal_id
	,atf.dat_formdate                                      AS c_dat_formdate
	,atf.time_receipt_ejr                                  AS c_time_receipt_ejr
	,atf.orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
	,atf.checker_id                                        AS c_checker_id
	,CAST(atf.transactiontype_id AS CHAR(3))               AS c_transaction_type_id
	,CAST(1 AS BYTEINT)                                    AS resumed_trans_seqnr
	,atf.val_retail_ejr                                    AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   INNER JOIN p_lew_mart_msi.v_ejr_suspended_transact_1 st1
   ON st1.client_id = atf.client_id
   AND st1.store_id = atf.store_id
   AND st1.checker_id = atf.checker_id
   AND st1.dat_formdate = atf.dat_formdate
 WHERE st1.is_suspend_gt_10  = 1
  AND st1.is_next_tran_cond = 1
  AND st1.same_checker_fg   = 1
  AND ( st1.is_resumed_aborted = 1 OR st1.is_new_item_in_resume = 1)
  AND atf.transactiontype_id IN(400, 405, 420, 425, 430, 480)

  QUALIFY atf.orig_receipt_nr_ejr > MIN(CASE WHEN st1.transactiontype_id IN ('300') THEN st1.orig_receipt_nr_ejr ELSE NULL END) OVER ( PARTITION BY st1.client_id, st1.store_id, st1.checker_id, st1.dat_formdate, st1.resumed_trans_receipt_nr_ejr)
  -- between the Bonruckstellung ...

  AND atf.orig_receipt_nr_ejr < MAX(CASE WHEN st1.transactiontype_id IN ('100','101','200','201','410') THEN st1.orig_receipt_nr_ejr ELSE NULL END) OVER ( PARTITION BY st1.client_id, st1.store_id, st1.checker_id, st1.dat_formdate, st1.resumed_trans_receipt_nr_ejr) 
  -- and Kleinstbon oder Abmeldung
  UNION ALL
   SELECT
      st2.resumed_trans_store_id_ejr                          AS p_store_id
	 ,st2.client_id                                           AS p_client_id
	 ,st2.resumed_trans_terminal_id_ejr                       AS p_pos_terminal_id
	 ,st2.resumed_trans_date_ejr                              AS p_dat_formdate
	 ,CAST('00:00:00'                       AS VARCHAR(8))    AS p_time_receipt_ejr
	 ,CAST(st2.resumed_trans_receipt_nr_ejr AS VARCHAR(13))   AS p_proof_object_nr_ejr
	 ,st2.checker_id                                          AS p_checker_id
	 ,CAST(34 AS SMALLINT)                                    AS scenario_group_id
	 ,st2.store_id                                            AS c_store_id
	 ,st2.client_id                                           AS c_client_id
	 ,st2.pos_terminal_id                                     AS c_pos_terminal_id
	 ,st2.dat_formdate                                        AS c_dat_formdate
	 ,st2.time_receipt_ejr                                    AS c_time_receipt_ejr
	 ,st2.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
	 ,st2.checker_id                                          AS c_checker_id
	 ,st2.transactiontype_id                                  AS c_transactiontype_id
	 ,st2.resumed_trans_seqnr                                 AS resumed_trans_seqnr
	 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_suspended_transact_1 st2
   WHERE st2.is_voided_till_last_artikel = 1
     AND st2.is_suspend_gt_10            = 1
     AND st2.is_next_tran_cond           = 1
     AND st2.same_checker_fg             = 1 
   UNION ALL
    -- add skipped transactions
   SELECT DISTINCT
     atf.store_id                                          AS p_store_id
	,atf.client_id                                         AS p_client_id
	,atf.pos_terminal_id                                   AS p_pos_terminal_id
	,atf.dat_formdate                                      AS p_dat_formdate
	,CAST(atf.time_receipt_ejr AS VARCHAR(8))              AS p_time_receipt_ejr
	,CAST(st2.resumed_trans_receipt_nr_ejr AS VARCHAR(13)) AS p_proof_object_nr_ejr
	,atf.checker_id                                        AS p_checker_id
	,CAST(34 AS SMALLINT)                                  AS scenario_group_id
	,atf.store_id                                          AS c_store_id
	,atf.client_id                                         AS c_client_id
	,atf.pos_terminal_id                                   AS c_pos_terminal_id
	,atf.dat_formdate                                      AS c_dat_formdate
	,atf.time_receipt_ejr                                  AS c_time_receipt_ejr
	,atf.orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
	,atf.checker_id                                        AS c_checker_id
	,CAST(atf.transactiontype_id AS CHAR(3))               AS c_transaction_type_id
	,CAST(1 AS BYTEINT)                                    AS resumed_trans_seqnr
	,atf.val_retail_ejr                                    AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   INNER JOIN p_lew_mart_msi.v_ejr_suspended_transact_1 st2
   ON st2.client_id = atf.client_id
   AND st2.store_id = atf.store_id
   AND st2.checker_id = atf.checker_id
   AND st2.dat_formdate = atf.dat_formdate
   WHERE st2.is_voided_till_last_artikel = 1
   AND st2.is_suspend_gt_10            = 1
   AND st2.is_next_tran_cond           = 1
   AND st2.same_checker_fg             = 1
   AND atf.transactiontype_id IN(400, 405, 420, 425, 430, 480)

   QUALIFY atf.orig_receipt_nr_ejr > MIN(CASE WHEN st2.transactiontype_id IN ('300') THEN st2.orig_receipt_nr_ejr ELSE NULL END) OVER ( PARTITION BY st2.client_id, st2.store_id, st2.checker_id, st2.dat_formdate, st2.resumed_trans_receipt_nr_ejr)
   -- between the Bonruckstellung ...

   AND atf.orig_receipt_nr_ejr < MAX(CASE WHEN st2.transactiontype_id IN ('100','101','200','201','410') THEN st2.orig_receipt_nr_ejr ELSE NULL END) OVER ( PARTITION BY st2.client_id, st2.store_id, st2.checker_id, st2.dat_formdate, st2.resumed_trans_receipt_nr_ejr) 
   -- and Kleinstbon oder Abmeldung
   UNION ALL
   SELECT DISTINCT
      de.store_id                                             AS p_store_id
	 ,de.client_id                                            AS p_client_id
	 ,CAST(-1 AS SMALLINT)                                    AS p_pos_terminal_id
	 ,DATE '1900-01-01'                                       AS p_dat_formdate
	 ,CAST('00:00:00' AS VARCHAR(8))                          AS p_time_receipt_ejr
	 ,de.pfand_ean                                            AS p_proof_object_nr_ejr
	 ,de.checker_id                                           AS p_checker_id
	 ,CAST(24 AS SMALLINT)                                    AS scenario_group_id
	 ,de.store_id                                             AS c_store_id
	 ,de.client_id                                            AS c_client_id
	 ,de.pos_terminal_id                                      AS c_pos_terminal_id
	 ,de.dat_formdate                                         AS c_dat_formdate
	 ,de.time_receipt_ejr                                     AS c_time_receipt_ejr
	 ,de.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
	 ,de.checker_id                                           AS c_checker_id
	 ,'100'                                                   AS c_transactiontype_id
	 ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
	 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_transact_deposit_ean_1 de
   UNION ALL
   SELECT
      st1.resumed_trans_store_id_ejr                          AS p_store_id
	 ,st1.client_id                                           AS p_client_id
	 ,st1.resumed_trans_terminal_id_ejr                       AS p_pos_terminal_id
	 ,st1.resumed_trans_date_ejr                              AS p_dat_formdate
	 ,CAST('00:00:00'                       AS VARCHAR(8))    AS p_time_receipt_ejr
	 ,CAST(st1.resumed_trans_receipt_nr_ejr AS VARCHAR(13))   AS p_proof_object_nr_ejr
	 ,st1.checker_id                                          AS p_checker_id
	 ,CAST(41 AS SMALLINT)                                    AS scenario_group_id
	 ,st1.store_id                                            AS c_store_id
	 ,st1.client_id                                           AS c_client_id
	 ,st1.pos_terminal_id                                     AS c_pos_terminal_id
	 ,st1.dat_formdate                                        AS c_dat_formdate
	 ,st1.time_receipt_ejr                                    AS c_time_receipt_ejr
	 ,st1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
	 ,st1.checker_id                                          AS c_checker_id
	 ,st1.transactiontype_id                                  AS c_transactiontype_id
	 ,CASE WHEN st1.resumed_trans_seqnr = 3 THEN CAST(1 AS BYTEINT)
           ELSE CAST(3 AS BYTEINT)
       END                                                    AS resumed_trans_seqnr
	 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_suspended_transact_1 st1
   WHERE st1.same_checker_fg       = 0
     AND is_new_item_in_resume_mc  = 1
     AND st1.resumed_trans_seqnr  IN (1,3)
   UNION ALL
   SELECT
      st2.resumed_trans_store_id_ejr                          AS p_store_id
	 ,st2.client_id                                           AS p_client_id
	 ,st2.resumed_trans_terminal_id_ejr                       AS p_pos_terminal_id
	 ,st2.resumed_trans_date_ejr                              AS p_dat_formdate
	 ,CAST('00:00:00'                       AS VARCHAR(8))    AS p_time_receipt_ejr
	 ,CAST(st2.resumed_trans_receipt_nr_ejr AS VARCHAR(13))   AS p_proof_object_nr_ejr
	 ,st2.checker_id                                          AS p_checker_id
	 ,CAST(42 AS SMALLINT)                                    AS scenario_group_id
	 ,st2.store_id                                            AS c_store_id
	 ,st2.client_id                                           AS c_client_id
	 ,st2.pos_terminal_id                                     AS c_pos_terminal_id
	 ,st2.dat_formdate                                        AS c_dat_formdate
	 ,st2.time_receipt_ejr                                    AS c_time_receipt_ejr
	 ,st2.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
	 ,st2.checker_id                                          AS c_checker_id
	 ,st2.transactiontype_id                                  AS c_transactiontype_id
	 ,CASE WHEN st2.resumed_trans_seqnr = 3 THEN CAST(1 AS BYTEINT)
           ELSE CAST(3 AS BYTEINT)
       END                                                    AS resumed_trans_seqnr
	 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_suspended_transact_1 st2
   WHERE st2.is_voided_till_last_artikel_mc  = 1
     AND st2.same_checker_fg                 = 0
     AND st2.resumed_trans_seqnr            IN (1,3)
   UNION ALL
   SELECT
      st3.resumed_trans_store_id_ejr                          AS p_store_id
	 ,st3.client_id                                           AS p_client_id
	 ,st3.resumed_trans_terminal_id_ejr                       AS p_pos_terminal_id
	 ,st3.resumed_trans_date_ejr                              AS p_dat_formdate
	 ,CAST('00:00:00'                       AS VARCHAR(8))    AS p_time_receipt_ejr
	 ,CAST(st3.resumed_trans_receipt_nr_ejr AS VARCHAR(13))   AS p_proof_object_nr_ejr
	 ,st3.checker_id                                          AS p_checker_id
	 ,CAST(40 AS SMALLINT)                                    AS scenario_group_id
	 ,st3.store_id                                            AS c_store_id
	 ,st3.client_id                                           AS c_client_id
	 ,st3.pos_terminal_id                                     AS c_pos_terminal_id
	 ,st3.dat_formdate                                        AS c_dat_formdate
	 ,st3.time_receipt_ejr                                    AS c_time_receipt_ejr
	 ,st3.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
	 ,st3.checker_id                                          AS c_checker_id
	 ,st3.transactiontype_id                                  AS c_transactiontype_id
	 ,CASE WHEN st3.resumed_trans_seqnr = 3 THEN CAST(1 AS BYTEINT)
           ELSE CAST(3 AS BYTEINT)
       END                                                    AS resumed_trans_seqnr
	 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_suspended_transact_1 st3
   WHERE st3.same_checker_fg = 0
     AND st3.is_resumed_aborted = 1
     AND st3.resumed_trans_seqnr IN (1,3)
   UNION ALL
   SELECT DISTINCT
      de.store_id                                             AS p_store_id
	 ,de.client_id                                            AS p_client_id
	 ,de.checker_id                                           AS p_pos_terminal_id
	 ,DATE '1900-01-01'                                       AS p_dat_formdate
	 ,CAST('00:00:00' AS VARCHAR(8))                          AS p_time_receipt_ejr
	 ,CAST(de.item_id AS VARCHAR(13))                         AS p_proof_object_nr_ejr
	 ,de.checker_id                                           AS p_checker_id
	 ,CAST(20 AS SMALLINT)                                    AS scenario_group_id
	 ,de.store_id                                             AS c_store_id
	 ,de.client_id                                            AS c_client_id
	 ,de.pos_terminal_id                                      AS c_pos_terminal_id
	 ,de.dat_formdate                                         AS c_dat_formdate
	 ,de.time_receipt_ejr                                     AS c_time_receipt_ejr
	 ,de.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
	 ,de.checker_id                                           AS c_checker_id
	 ,CAST('100' AS CHAR(3))                                  AS c_transactiontype_id
	 ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
	 ,de.val_retail_ejr                                       AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_item_receipt_rel_1 de
   UNION ALL
   SELECT DISTINCT
      ta1.store_id                                            AS p_store_id
	 ,ta1.client_id                                           AS p_client_id
	 ,ta1.pos_terminal_id                                     AS p_pos_terminal_id
	 ,ta1.dat_formdate                                        AS p_dat_formdate
	 ,CAST(ta1.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
	 ,CAST(ta1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
	 ,ta1.checker_id                                          AS p_checker_id
	 ,sg.scenario_group_id                                    AS scenario_group_id
	 ,tc.store_id                                             AS c_store_id
	 ,tc.client_id                                            AS c_client_id
	 ,tc.pos_terminal_id                                      AS c_pos_terminal_id
	 ,tc.dat_formdate                                         AS c_dat_formdate
	 ,tc.time_receipt_ejr                                     AS c_time_receipt_ejr
	 ,tc.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
	 ,tc.checker_id                                           AS c_checker_id
	 ,tc.transactiontype_id                                   AS c_transaction_type_id
	 ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
	 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_all_transact_1 ta1
   INNER JOIN p_lew_mart_msi.v_ejr_lp_rel_scenario_to_group_1 sg
   ON ta1.scenario_id                              = sg.scenario_id
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
   ON ta1.client_id                                = rl.client_id
   AND ta1.store_id                                 = rl.store_id
   AND ta1.pos_terminal_id                          = rl.pos_terminal_id
   AND ta1.dat_formdate = rl.dat_formdate
   AND ta1.orig_receipt_nr_ejr                      = rl.orig_receipt_nr_ejr
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 ls
   ON ls.client_id                                 = rl.client_id
   AND rl.original_orig_store_nr_ejr                = CAST(ls.orig_store_nr AS VARCHAR(100))
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 tc
   ON tc.client_id                                 = ls.client_id
   AND tc.store_id = ls.store_id
   AND CAST(tc.orig_receipt_nr_ejr AS VARCHAR(100)) = rl.original_orig_receipt_nr_ejr
   AND tc.dat_formdate                              = rl.original_dat_formdate_ejr
   AND CAST(tc.pos_terminal_id AS VARCHAR(100))     = rl.original_pos_terminal_id_ejr
   AND tc.transactiontype_id                        = '100'
 WHERE sg.scenario_group_id IN (1,2,3,25,26,27,28,29,30,31,32,46,47,50)
 UNION ALL
 /* 45: Geldruckgabe - mehrfach mit gleichem Originalbon  */
 SELECT
    rt1.store_id                                            AS p_store_id
   ,rt1.client_id                                           AS p_client_id
   ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
   ,rt1.dat_last_returndate                                 AS p_dat_formdate
   ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
   ,CAST(rt1.s_orig_receipt_nr_ejr AS VARCHAR(13))          AS p_proof_object_nr_ejr
   ,rt1.checker_id                                          AS p_checker_id
   ,CAST(45 AS SMALLINT)                                    AS scenario_group_id
   ,rt1.store_id                                            AS c_store_id
   ,rt1.client_id                                           AS c_client_id
   ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
   ,rt1.dat_formdate                                        AS c_dat_formdate
   ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
   ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
   ,rt1.checker_id                                          AS c_checker_id
   ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
   ,CASE WHEN rt1.is_returned_gt_original = 1
            AND rt1.cnt_returned_gt_original = 1 THEN CAST(1 AS BYTEINT)
           ELSE CAST(2 AS BYTEINT)
       END                                                    AS resumed_trans_seqnr
   ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
   WHERE rt1.is_returned_gt_original = 1
     AND rt1.is_return_same_checker  = 0
   UNION ALL
   SELECT
      rt2.store_id                                            AS p_store_id
	 ,rt2.client_id                                           AS p_client_id
	 ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
	 ,rt2.dat_last_returndate                                 AS p_dat_formdate
	 ,CAST(rt2.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
	 ,CAST(rt2.s_orig_receipt_nr_ejr AS VARCHAR(13))          AS p_proof_object_nr_ejr
	 ,rt2.checker_id                                          AS p_checker_id
	 ,CAST(45 AS SMALLINT)                                    AS scenario_group_id
	 ,vt2.store_id                                            AS c_store_id
	 ,vt2.client_id                                           AS c_client_id
	 ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
	 ,vt2.dat_formdate                                        AS c_dat_formdate
	 ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
	 ,vt2.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
	 ,vt2.checker_id                                          AS c_checker_id
	 ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
	 ,CAST(3 AS BYTEINT)                                      AS resumed_trans_seqnr
	 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
   INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
   AND  rt2.s_orig_store_nr_ejr     = st.orig_store_nr
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
   ON rt2.client_id                = vt2.client_id
   AND st.store_id                  = vt2.store_id
   AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
   AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
   AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
 WHERE vt2.transactiontype_id       = '100'
   AND rt2.cnt_returned_gt_original = 1
   AND rt2.is_return_same_checker   = 0
 UNION ALL
 /* 49: Mehrfache Preisanzeigen in Folge   */
 SELECT
   sp.store_id                                             AS p_store_id
  ,sp.client_id                                            AS p_client_id
  ,sp.pos_terminal_id                                      AS p_pos_terminal_id
  ,sp.dat_formdate                                         AS p_dat_formdate
  ,CAST(sp.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(sp.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,sp.checker_id                                           AS p_checker_id
  ,CAST(49 AS SMALLINT)                                    AS scenario_group_id
  ,tra.store_id                                            AS c_store_id
  ,tra.client_id                                           AS c_client_id
  ,tra.pos_terminal_id                                     AS c_pos_terminal_id
  ,tra.dat_formdate                                        AS c_dat_formdate
  ,tra.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,tra.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,tra.checker_id                                          AS c_checker_id
  ,tra.transactiontype_id                                  AS c_transactiontype_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,sp.val_retail_ejr                                       AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_show_price_1 sp
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 th_r
   ON th_r.client_id   = sp.client_id
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 tra
   ON tra.store_id        = sp.store_id
   AND tra.client_id    = sp.client_id
   AND tra.checker_id   = sp.checker_id
   AND tra.dat_formdate = sp.dat_formdate
 /* The following condition is important to define the subsequent receipts that need to be displayed.
    All receipts of the series plus 4 (fixed value) subsequent receipts need to be displayed.
    The number of receipts in the series is stored in cnt_same_transactiontype.
    Pay attention: The first receipt of the series will be selected by the first part of this UNION view.
    E.g. If the number of receipts in the series is "3"  ,it means that 3 receipts in total (1 starting receipt   AND 2 other receipts in the series)
         belong to the series. The condition in the next line has to restrict on the 2 other receipts in the series plus the 1 before and 1 after subsequent receipts in this case.  */
   AND (tra.rank_login_nr BETWEEN sp.rank_login_nr + 1 AND sp.rank_login_nr + sp.cnt_same_transactiontype /* show price series without 1st receipt and 1 transaction after price series */
       OR tra.rank_login_nr = sp.rank_login_nr - 1)  /* show 1 transaction after price series */
 WHERE sp.is_show_price_series = 1
 /* Bonrueckstellung mit Kleinstbon as follower transaction  */
 UNION ALL
 SELECT
    st4.resumed_trans_store_id_ejr                          AS p_store_id
   ,st4.client_id                                           AS p_client_id
   ,st4.resumed_trans_terminal_id_ejr                       AS p_pos_terminal_id
   ,st4.resumed_trans_date_ejr                              AS p_dat_formdate
   ,CAST('00:00:00'                       AS VARCHAR(8))    AS p_time_receipt_ejr
   ,CAST(st4.resumed_trans_receipt_nr_ejr AS VARCHAR(13))   AS p_proof_object_nr_ejr
   ,st4.checker_id                                          AS p_checker_id
   ,CAST(53 AS SMALLINT)                                    AS scenario_group_id
   ,st4.store_id                                            AS c_store_id
   ,st4.client_id                                           AS c_client_id
   ,st4.pos_terminal_id                                     AS c_pos_terminal_id
   ,st4.dat_formdate                                        AS c_dat_formdate
   ,st4.time_receipt_ejr                                    AS c_time_receipt_ejr
   ,st4.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
   ,st4.checker_id                                          AS c_checker_id
   ,st4.transactiontype_id                                  AS c_transactiontype_id
   ,st4.resumed_trans_seqnr                                 AS resumed_trans_seqnr
   ,CASE WHEN resumed_trans_seqnr = 1 THEN val_susp_retail_ejr
           ELSE val_susp_next_retail_ejr
       END                                                    AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_suspended_transact_1 st4
   WHERE st4.is_next_low_tran     = 1
     AND st4.resumed_trans_seqnr <= 2
   /* Bonabbruch mit Kleinstbon as follower transaction  */
   UNION ALL
   SELECT
      tabort.store_id                                         AS p_store_id
	 ,tabort.client_id                                        AS p_client_id
	 ,tabort.pos_terminal_id                                  AS p_pos_terminal_id
	 ,tabort.dat_formdate                                     AS p_dat_formdate
	 ,CAST(tabort.time_receipt_ejr    AS VARCHAR(8))          AS p_time_receipt_ejr
	 ,CAST(tabort.orig_receipt_nr_ejr AS VARCHAR(13))         AS p_proof_object_nr_ejr
	 ,tabort.checker_id                                       AS p_checker_id
	 ,CAST(54 AS SMALLINT)                                    AS scenario_group_id
	 ,tabort.store_id                                         AS c_store_id
	 ,tabort.client_id                                        AS c_client_id
	 ,tabort.pos_terminal_id                                  AS c_pos_terminal_id
	 ,tabort.dat_formdate                                     AS c_dat_formdate
	 ,tabort.next_time_receipt_ejr                            AS c_time_receipt_ejr
	 ,tabort.next_orig_receipt_nr_ejr                         AS c_orig_receipt_nr_ejr
	 ,tabort.checker_id                                       AS c_checker_id
	 ,tabort.transactiontype_id                               AS c_transactiontype_id
	 ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
	 ,tabort.next_val_retail_ejr                              AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_all_transact_1 tabort
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 foll_t
   ON foll_t.client_id               = tabort.client_id
   AND foll_t.store_id                = tabort.store_id
   AND foll_t.checker_id              = tabort.checker_id
   AND foll_t.time_receipt_ejr        = tabort.next_time_receipt_ejr
   AND foll_t.dat_formdate            = tabort.dat_formdate
   AND foll_t.orig_receipt_nr_ejr     = tabort.next_orig_receipt_nr_ejr
 WHERE tabort.transactiontype_id      = '300'
   AND tabort.next_transactiontype_id = '100'
   AND foll_t.transactiontype_id      = '100'
   AND foll_t.is_lowval_fg            = 1
   AND foll_t.prev_transactiontype_id = '200'
 UNION ALL
 /* Scenario: 55 - Mehrfache Geldrueckgabe mit gleichem Originalbon

    The following SQL will identify all "Ruckgabebons" that exceed the user defined threshold of how many
    "Ruckgabebons" are allowed for a single sales_1 receipt. The query restricts its transaction results to
    within a given client_id. The sales_1 store_id and the store_id of the Ruckgabebon should be in the selection
    criteria.

    Built in two parts. 1: (a) Find all the return receipts from the same sales_1 receipt
                           that exceed the allowed threshold. Using the original sales_1 receipt nr.
                           all the other Ruckgabebons are identified. The attribute resumed_trans_seqnr
                           will be set to 3 (Proof Object) for all Ruckgabebons that exceed the allowed threshold.
                           (b) The other Ruckgabebons from the same sales_1 receipt that dont exceed the
                           allowed threshold: their attribute resumed_trans_seqnr will be set to 1 (Child Objects)

                        2: Using the same logic to identify all Ruckgabebons from the same sales_1 receipt
                           that exceed the allowed threshold, this query identifies the original sales_1 receipt.
                           The attribute resumed_trans_seqnr will be set to 1 (Child Objects) for these records.
 */
 SELECT 
   rd.p_store_id
  ,rd.p_client_id
  ,rd.p_pos_terminal_id
  ,rd.p_dat_formdate
  ,rd.p_time_receipt_ejr
  ,rd.p_proof_object_nr_ejr
  ,rd.p_checker_id
  ,rd.scenario_group_id
  ,rd.c_store_id
  ,rd.c_client_id
  ,rd.c_pos_terminal_id
  ,rd.c_dat_formdate
  ,rd.c_time_receipt_ejr
  ,rd.c_orig_receipt_nr_ejr
  ,rd.c_checker_id
  ,rd.c_transaction_type_id
  ,rd.resumed_trans_seqnr
  ,rd.val_retail_ejr
   FROM (
         SELECT
   rt1.return_seq
  ,rt1.s_client_id_ejr
  ,rt1.s_orig_store_nr_ejr
  ,rt1.s_dat_formdate_ejr
  ,rt1.s_orig_receipt_nr_ejr
  ,rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_formdate                                        AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(55 AS SMALLINT)                                    AS scenario_group_id
  ,rt2.store_id                                            AS c_store_id
  ,rt2.client_id                                           AS c_client_id
  ,rt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt2.dat_formdate                                        AS c_dat_formdate
  ,rt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt2.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CASE WHEN rt1.orig_receipt_nr_ejr = rt2.orig_receipt_nr_ejr THEN CAST(1 AS BYTEINT)
                                                                        ELSE CAST(3 AS BYTEINT)
             END                                                    AS resumed_trans_seqnr
  ,rt2.val_return_same_receipt                             AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1                          /* Find the Ruckgabebons that exceed the threshold */
   INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st                  /* Limit result to the requested clients/stores    */
   ON rt1.client_id                       = st.client_id
   AND rt1.store_id                        = st.store_id
   INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st2                 /* Limit result to the requested clients/stores    */
   ON rt1.s_client_id_ejr                 = st2.client_id
   AND rt1.s_orig_store_nr_ejr             = st2.orig_store_nr
   INNER JOIN p_lew_mart_msi.v_ejr_return_transact_1 rt2                     /* Find all the Ruckgabebons that belong to original Bon */
   ON rt1.s_client_id_ejr                 = rt2.s_client_id_ejr           /* These are the Child Objects                           */
   AND rt1.s_orig_store_nr_ejr             = rt2.s_orig_store_nr_ejr
   AND rt1.s_orig_receipt_nr_ejr           = rt2.s_orig_receipt_nr_ejr
   AND rt1.s_pos_terminal_id_ejr           = rt2.s_pos_terminal_id_ejr
   AND rt1.s_dat_formdate_ejr              = rt2.s_dat_formdate_ejr
   AND rt2.return_seq                      > 0
   AND rt2.is_return_not_authorised        = 0
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2                        /*  Obtain the transaction details for Proof Objects */
   ON rt1.client_id                       = vt2.client_id
   AND rt1.store_id                        = vt2.store_id
   AND rt1.orig_receipt_nr_ejr             = vt2.orig_receipt_nr_ejr
   AND rt1.pos_terminal_id                 = vt2.pos_terminal_id
   AND rt1.dat_formdate                    = vt2.dat_formdate
   AND vt2.transactiontype_id              = '150'
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt3                        /* Obtain the transaction details for the Child Objects  */
   ON rt2.client_id                       = vt3.client_id
   AND rt2.store_id                        = vt3.store_id
   AND rt2.orig_receipt_nr_ejr             = vt3.orig_receipt_nr_ejr
   AND rt2.pos_terminal_id                 = vt3.pos_terminal_id
   AND rt2.dat_formdate                    = vt3.dat_formdate
   AND vt3.transactiontype_id              = '150'
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
   ON tr.client_id                        = rt1.client_id

   WHERE ABS(rt1.val_return_same_receipt)   >= tr.return_same_receipt_val
     AND rt1.return_seq                     >= tr.return_same_receipt_qty
     AND rt1.is_return_same_checker          = 0
  ) rd
QUALIFY rd.return_seq = MAX(rd.return_seq) OVER (                               /* Fix for BBT-271 */
 PARTITION BY  rd.s_client_id_ejr
    ,rd.s_orig_store_nr_ejr
    ,rd.s_dat_formdate_ejr
    ,rd.s_orig_receipt_nr_ejr
    ,rd.p_checker_id
    )
UNION ALL
SELECT rd.p_store_id
  ,rd.p_client_id
  ,rd.p_pos_terminal_id
  ,rd.p_dat_formdate
  ,rd.p_time_receipt_ejr
  ,rd.p_proof_object_nr_ejr
  ,rd.p_checker_id
  ,rd.scenario_group_id
  ,rd.c_store_id
  ,rd.c_client_id
  ,rd.c_pos_terminal_id
  ,rd.c_dat_formdate
  ,rd.c_time_receipt_ejr
  ,rd.c_orig_receipt_nr_ejr
  ,rd.c_checker_id
  ,rd.c_transaction_type_id
  ,rd.resumed_trans_seqnr
  ,rd.val_retail_ejr
   FROM (
         SELECT    /* Find and process the original sales_1 receipt */
            rt3.return_seq
   ,rt3.s_client_id_ejr
   ,rt3.s_orig_store_nr_ejr
   ,rt3.s_dat_formdate_ejr
   ,rt3.s_orig_receipt_nr_ejr
   ,rt3.store_id                                            AS p_store_id
   ,rt3.client_id                                           AS p_client_id
   ,rt3.pos_terminal_id                                     AS p_pos_terminal_id
   ,rt3.dat_formdate                                        AS p_dat_formdate
   ,CAST(rt3.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
   ,CAST(rt3.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
   ,rt3.checker_id                                          AS p_checker_id
   ,CAST(55 AS SMALLINT)                                    AS scenario_group_id
   ,vt4.store_id                                            AS c_store_id
   ,vt4.client_id                                           AS c_client_id
   ,vt4.pos_terminal_id                                     AS c_pos_terminal_id
   ,vt4.dat_formdate                                        AS c_dat_formdate
   ,vt4.time_receipt_ejr                                    AS c_time_receipt_ejr
   ,rt3.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
   ,vt4.checker_id                                          AS c_checker_id
   ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
   ,CAST(3 AS BYTEINT)                                      AS resumed_trans_seqnr
   ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
          FROM p_lew_mart_msi.v_ejr_return_transact_1 rt3                          /* Find the Ruckgabebons that exceed the threshold */
   INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st                  /* Limit result to the requested clients/stores    */
   ON rt3.s_client_id_ejr                 = st.client_id
   AND rt3.s_orig_store_nr_ejr             = st.orig_store_nr
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt4                        /* Obtain the transaction details  */
   ON rt3.client_id                       = vt4.client_id
   AND st.store_id                         = vt4.store_id
   AND rt3.s_orig_receipt_nr_ejr           = vt4.orig_receipt_nr_ejr
   AND rt3.s_pos_terminal_id_ejr           = vt4.pos_terminal_id
   AND rt3.s_dat_formdate_ejr              = vt4.dat_formdate
   AND vt4.transactiontype_id              = '100'
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 tr
   ON tr.client_id                        = rt3.client_id

   WHERE ABS(rt3.val_return_same_receipt)   >= tr.return_same_receipt_val
     AND rt3.return_seq                     >= tr.return_same_receipt_qty
     AND rt3.is_return_same_checker          = 0
 ) rd
QUALIFY rd.return_seq = MAX(rd.return_seq) OVER (                               /* Fix for BBT-271 */
 PARTITION BY rd.s_client_id_ejr
    ,rd.s_orig_store_nr_ejr
    ,rd.s_dat_formdate_ejr
    ,rd.s_orig_receipt_nr_ejr
    ,rd.p_checker_id
    )
UNION ALL
/* 56: Geldruckgabe nicht autorisierungspflichtig  */
SELECT
  rt2.store_id                                            AS p_store_id
 ,rt2.client_id                                           AS p_client_id
 ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
 ,rt2.dat_last_returndate                                 AS p_dat_formdate
 ,CAST(rt2.time_receipt_ejr AS VARCHAR(8))                AS p_time_receipt_ejr
 ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
 ,rt2.checker_id                                          AS p_checker_id
 ,CAST(56 AS SMALLINT)                                    AS scenario_group_id
 ,vt2.store_id                                            AS c_store_id
 ,vt2.client_id                                           AS c_client_id
 ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
 ,vt2.dat_formdate                                        AS c_dat_formdate
 ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
 ,vt2.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
 ,vt2.checker_id                                          AS c_checker_id
 ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
 ,CAST(3 AS BYTEINT)                                      AS resumed_trans_seqnr
 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_return_transact_1 AS rt2
   INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr             = st.client_id
   AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
   ON rt2.client_id = vt2.client_id
   AND st.store_id = vt2.store_id
   AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
   AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
   AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
 WHERE vt2.transactiontype_id       = '100'
   AND rt2.is_return_not_authorised = 1
   AND rt2.is_return_same_checker   = 0
 UNION ALL
 /* Section for BBT-398: Bonrueckstellung + Kleinstbon (57) and Bonrueckstellung + Abmeldung (58) */
 SELECT
    st5.resumed_trans_store_id_ejr                          AS p_store_id
   ,st5.client_id                                           AS p_client_id
   ,st5.resumed_trans_terminal_id_ejr                       AS p_pos_terminal_id
   ,st5.resumed_trans_date_ejr                              AS p_dat_formdate
   ,CAST('00:00:00' AS VARCHAR(8))                          AS p_time_receipt_ejr
   ,CAST(st5.resumed_trans_receipt_nr_ejr AS VARCHAR(13))   AS p_proof_object_nr_ejr
   ,st5.checker_id                                          AS p_checker_id
   ,CASE WHEN st5.is_next_low_tran_mc = 1 THEN CAST(57 AS SMALLINT)
         WHEN st5.is_next_abmeld_mc   = 1 THEN CAST(58 AS SMALLINT)
     END                                                    AS scenario_group_id
   ,st5.store_id                                            AS c_store_id
   ,st5.client_id                                           AS c_client_id
   ,st5.pos_terminal_id                                     AS c_pos_terminal_id
   ,st5.dat_formdate                                        AS c_dat_formdate
   ,st5.time_receipt_ejr                                    AS c_time_receipt_ejr
   ,st5.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
   ,st5.checker_id                                          AS c_checker_id
   ,st5.transactiontype_id                                  AS c_transactiontype_id
   ,st5.resumed_trans_seqnr                                 AS resumed_trans_seqnr
   ,CASE WHEN resumed_trans_seqnr = 1 THEN val_susp_retail_ejr
                                        ELSE val_susp_next_retail_ejr
       END                                                    AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_suspended_transact_1 st5
   WHERE st5.is_open_suspended    = 1
     AND (st5.is_next_low_tran_mc = 1
      OR  st5.is_next_abmeld_mc   = 1 )
   UNION ALL
   -- Add skipped transactions
  SELECT DISTINCT
     atf.store_id                                          AS p_store_id
	,atf.client_id                                         AS p_client_id
	,atf.pos_terminal_id                                   AS p_pos_terminal_id
	,atf.dat_formdate                                      AS p_dat_formdate
	,CAST(atf.time_receipt_ejr AS VARCHAR(8))              AS p_time_receipt_ejr
	,CAST(st.resumed_trans_receipt_nr_ejr AS VARCHAR(13))  AS p_proof_object_nr_ejr
	,atf.checker_id                                        AS p_checker_id
	,CASE WHEN st.is_next_low_tran_mc = 1 THEN CAST(57 AS SMALLINT)
          WHEN st.is_next_abmeld_mc   = 1 THEN CAST(58 AS SMALLINT)
     END                                   AS scenario_group_id            
	,atf.store_id                                          AS c_store_id
	,atf.client_id                                         AS c_client_id
	,atf.pos_terminal_id                                   AS c_pos_terminal_id
	,atf.dat_formdate                                      AS c_dat_formdate
	,atf.time_receipt_ejr                                  AS c_time_receipt_ejr
	,atf.orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
	,atf.checker_id                                        AS c_checker_id
	,CAST(atf.transactiontype_id AS CHAR(3))               AS c_transaction_type_id
	,CAST(1 AS BYTEINT)                                    AS resumed_trans_seqnr
	,atf.val_retail_ejr                                    AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   INNER JOIN p_lew_mart_msi.v_ejr_suspended_transact_1 st
   ON st.client_id = atf.client_id
   AND st.store_id = atf.store_id
   AND st.checker_id = atf.checker_id
   AND st.dat_formdate = atf.dat_formdate
  WHERE atf.transactiontype_id IN(400, 405, 420, 425, 430, 480)
  AND st.is_open_suspended    = 1
  AND (st.is_next_low_tran_mc = 1 OR st.is_next_abmeld_mc   = 1 )
  QUALIFY atf.orig_receipt_nr_ejr > MIN(CASE WHEN st.transactiontype_id IN ('300') THEN st.orig_receipt_nr_ejr ELSE NULL END) OVER ( PARTITION BY st.client_id, st.store_id, st.checker_id, st.dat_formdate, st.resumed_trans_receipt_nr_ejr)
  -- between the Bonruckstellung ...

  AND atf.orig_receipt_nr_ejr < MAX(CASE WHEN st.transactiontype_id IN ('100','101','200','201','410') THEN st.orig_receipt_nr_ejr ELSE NULL END) OVER ( PARTITION BY st.client_id, st.store_id, st.checker_id, st.dat_formdate, st.resumed_trans_receipt_nr_ejr) 
  -- and Kleinstbon oder Abmeldung
   UNION ALL
   /* Section for BBT-1566: Preisanzeige + Kleinstbon (man)/ Preisanzeige + Abmeldung (man) */
   SELECT
      sp.store_id                                             AS p_store_id
	 ,sp.client_id                                            AS p_client_id
	 ,sp.pos_terminal_id                                      AS p_pos_terminal_id
	 ,sp.dat_formdate                                         AS p_dat_formdate
	 ,CAST(sp.time_receipt_ejr AS VARCHAR(8))                 AS p_time_receipt_ejr
	 ,CAST(sp.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
	 ,sp.checker_id                                           AS p_checker_id
	 ,CASE WHEN sp.is_kleinstbon_man = 1 THEN CAST(59 AS SMALLINT)
           WHEN sp.is_abmeld_man     = 1 THEN CAST(60 AS SMALLINT)
           ELSE NULL
       END                                                    AS scenario_group_id
	 ,sp.store_id                                             AS c_store_id
	 ,sp.client_id                                            AS c_client_id
	 ,sp.pos_terminal_id                                      AS c_pos_terminal_id
	 ,sp.dat_formdate                                         AS c_dat_formdate
	 ,CASE WHEN ur.resumed_trans_seqnr = 1 THEN sp.time_receipt_ejr
           WHEN ur.resumed_trans_seqnr = 2 THEN atf.time_receipt_ejr
           WHEN ur.resumed_trans_seqnr = 4 THEN atf.next_time_receipt_ejr
       END                                                    AS c_time_receipt_ejr
	 ,CASE WHEN ur.resumed_trans_seqnr = 1 THEN sp.orig_receipt_nr_ejr
           WHEN ur.resumed_trans_seqnr = 2 THEN atf.orig_receipt_nr_ejr
           WHEN ur.resumed_trans_seqnr = 4 THEN atf.next_orig_receipt_nr_ejr
        END                                                   AS c_orig_receipt_nr_ejr
     ,CASE WHEN ur.resumed_trans_seqnr = 1 THEN sp.checker_id
           WHEN ur.resumed_trans_seqnr = 2 THEN atf.checker_id
           WHEN ur.resumed_trans_seqnr = 4 THEN atf.checker_id
       END                                                    AS c_checker_id
	 ,CASE WHEN ur.resumed_trans_seqnr = 1 THEN sp.transactiontype_id
           WHEN ur.resumed_trans_seqnr = 2 THEN atf.transactiontype_id
           WHEN ur.resumed_trans_seqnr = 4 THEN atf.next_transactiontype_id
       END                                                    AS c_transactiontype_id
	 ,ur.resumed_trans_seqnr                                  AS resumed_trans_seqnr
	 ,CASE WHEN sp.is_kleinstbon_man = 1 THEN
                CASE WHEN ur.resumed_trans_seqnr = 1 THEN sp.val_retail_ejr
                     WHEN ur.resumed_trans_seqnr = 2 THEN sp.next_val_retail_ejr
                 END
           WHEN sp.is_abmeld_man     = 1 THEN
                 CASE WHEN ur.resumed_trans_seqnr = 1 THEN sp.val_retail_ejr
                      ELSE CAST(0 AS DECIMAL(18,4))
                  END
        END                                                   AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_show_price_1 sp
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   ON sp.client_id                = atf.client_id
   AND sp.store_id                 = atf.store_id
   AND sp.dat_formdate             = atf.dat_formdate
   AND sp.pos_terminal_id          = atf.pos_terminal_id
   AND sp.next_time_receipt_ejr    = atf.time_receipt_ejr
   AND sp.next_orig_receipt_nr_ejr = atf.orig_receipt_nr_ejr
   INNER JOIN (                                                                        /* Resumed Trans Sequence Numbers for output records */
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(1 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   UNION ALL
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(2 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   UNION ALL
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(4 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   ) ur
   ON 1 = 1
   WHERE (sp.is_kleinstbon_man = 1 AND ur.resumed_trans_seqnr  <= 2)
      OR (sp.is_abmeld_man     = 1 AND (ur.resumed_trans_seqnr <= 2 OR (ur.resumed_trans_seqnr = 4 AND atf.next_orig_receipt_nr_ejr IS NOT NULL)))
   UNION ALL
   /* Section for BBT-1649: Geldruckgabe - Originalbon gleicher Bediener (Part 1) */
   SELECT
       rd.p_store_id
	  ,rd.p_client_id
	  ,rd.p_pos_terminal_id
	  ,rd.p_dat_formdate
	  ,rd.p_time_receipt_ejr
	  ,rd.p_proof_object_nr_ejr
	  ,rd.p_checker_id
	  ,rd.scenario_group_id
	  ,rd.c_store_id
	  ,rd.c_client_id
	  ,rd.c_pos_terminal_id
	  ,rd.c_dat_formdate
	  ,rd.c_time_receipt_ejr
	  ,rd.c_orig_receipt_nr_ejr
	  ,rd.c_checker_id
	  ,rd.c_transaction_type_id
	  ,rd.resumed_trans_seqnr
	  ,rd.val_retail_ejr
   FROM (
       SELECT
          rt1.return_seq
		 ,rt1.s_client_id_ejr
		 ,rt1.s_orig_store_nr_ejr
		 ,rt1.s_dat_formdate_ejr
		 ,rt1.s_orig_receipt_nr_ejr
		 ,rt1.store_id                                            AS p_store_id
		 ,rt1.client_id                                           AS p_client_id
		 ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
		 ,rt1.dat_formdate                                        AS p_dat_formdate
		 ,CAST(rt1.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
		 ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
		 ,rt1.checker_id                                          AS p_checker_id
		 ,CAST(61 AS SMALLINT)                                    AS scenario_group_id
		 ,rt2.store_id                                            AS c_store_id
		 ,rt2.client_id                                           AS c_client_id
		 ,rt2.pos_terminal_id                                     AS c_pos_terminal_id
		 ,rt2.dat_formdate                                        AS c_dat_formdate
		 ,rt2.time_receipt_ejr                                    AS c_time_receipt_ejr
		 ,rt2.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
		 ,rt2.checker_id                                          AS c_checker_id
		 ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
		 ,CASE WHEN rt1.orig_receipt_nr_ejr = rt2.orig_receipt_nr_ejr THEN Cast(1 AS BYTEINT)
                                                                      ELSE Cast(3 AS BYTEINT)
           END                                                    AS resumed_trans_seqnr
		 ,rt2.val_return_same_receipt                             AS val_retail_ejr
       FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1                                     /* Find the Ruckgabebons that exceed the threshold */
   INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st                            /* Limit result to the requested clients/stores    */
   ON rt1.client_id                = st.client_id
   AND rt1.store_id                 = st.store_id
   INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st2                           /* Limit result to the requested clients/stores    */
   ON rt1.s_client_id_ejr          = st2.client_id
   AND rt1.s_orig_store_nr_ejr      = st2.orig_store_nr
   INNER JOIN p_lew_mart_msi.v_ejr_return_transact_1 rt2                               /* Find all the Ruckgabebons that belong to original Bon */
   ON rt1.s_client_id_ejr          = rt2.s_client_id_ejr
   AND rt1.s_orig_store_nr_ejr      = rt2.s_orig_store_nr_ejr
   AND rt1.s_orig_receipt_nr_ejr    = rt2.s_orig_receipt_nr_ejr
   AND rt1.s_pos_terminal_id_ejr    = rt2.s_pos_terminal_id_ejr
   AND rt1.s_dat_formdate_ejr       = rt2.s_dat_formdate_ejr
   AND rt2.return_seq               > 0
   AND rt2.is_return_not_authorised = 0
   AND rt2.is_return_same_checker   = 1
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2                                  /*  Obtain the transaction details for Proof Objects */
   ON rt1.client_id                = vt2.client_id
   AND rt1.store_id                 = vt2.store_id
   AND rt1.orig_receipt_nr_ejr      = vt2.orig_receipt_nr_ejr
   AND rt1.pos_terminal_id          = vt2.pos_terminal_id
   AND rt1.dat_formdate             = vt2.dat_formdate
   AND vt2.transactiontype_id       = '150'
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt3                                  /* Obtain the transaction details for the Child Objects  */
   ON rt2.client_id                = vt3.client_id
   AND rt2.store_id                 = vt3.store_id
   AND rt2.orig_receipt_nr_ejr      = vt3.orig_receipt_nr_ejr
   AND rt2.pos_terminal_id          = vt3.pos_terminal_id
   AND rt2.dat_formdate             = vt3.dat_formdate
   AND vt3.transactiontype_id       = '150'
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
   ON tr.client_id                 = rt1.client_id
   WHERE rt1.is_return_same_checker   = 1
   ) rd
QUALIFY rd.return_seq = MAX(rd.return_seq) OVER (                                 /* Filter out duplicates */
   PARTITION BY rd.s_client_id_ejr
      ,rd.s_orig_store_nr_ejr
      ,rd.s_dat_formdate_ejr
      ,rd.s_orig_receipt_nr_ejr )
UNION ALL
/* Section for BBT-1649: Geldruckgabe - Originalbon gleicher Bediener (Part 2) */
SELECT
   rd.p_store_id
  ,rd.p_client_id
  ,rd.p_pos_terminal_id
  ,rd.p_dat_formdate
  ,rd.p_time_receipt_ejr
  ,rd.p_proof_object_nr_ejr
  ,rd.p_checker_id
  ,rd.scenario_group_id
  ,rd.c_store_id
  ,rd.c_client_id
  ,rd.c_pos_terminal_id
  ,rd.c_dat_formdate
  ,rd.c_time_receipt_ejr
  ,rd.c_orig_receipt_nr_ejr
  ,rd.c_checker_id
  ,rd.c_transaction_type_id
  ,rd.resumed_trans_seqnr
  ,rd.val_retail_ejr
   FROM (
       SELECT    /* Find and process the original sales_1 receipt */
          rt3.return_seq
		 ,rt3.s_client_id_ejr
		 ,rt3.s_orig_store_nr_ejr
		 ,rt3.s_dat_formdate_ejr
		 ,rt3.s_orig_receipt_nr_ejr
		 ,rt3.store_id                                            AS p_store_id
		 ,rt3.client_id                                           AS p_client_id
		 ,rt3.pos_terminal_id                                     AS p_pos_terminal_id
		 ,rt3.dat_formdate                                        AS p_dat_formdate
		 ,CAST(rt3.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
		 ,CAST(rt3.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
		 ,rt3.checker_id                                          AS p_checker_id
		 ,CAST(61 AS SMALLINT)                                    AS scenario_group_id
		 ,vt4.store_id                                            AS c_store_id
		 ,vt4.client_id                                           AS c_client_id
		 ,vt4.pos_terminal_id                                     AS c_pos_terminal_id
		 ,vt4.dat_formdate                                        AS c_dat_formdate
		 ,vt4.time_receipt_ejr                                    AS c_time_receipt_ejr
		 ,rt3.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
		 ,vt4.checker_id                                          AS c_checker_id
		 ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
		 ,CAST(3 AS BYTEINT)                                      AS resumed_trans_seqnr
		 ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
       FROM p_lew_mart_msi.v_ejr_return_transact_1 rt3                           /* Find the Ruckgabebons that exceed the threshold */
   INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st                  /* Limit result to the requested clients/stores    */
   ON rt3.s_client_id_ejr        = st.client_id
   AND rt3.s_orig_store_nr_ejr    = st.orig_store_nr
   INNER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt4                        /* Obtain the transaction details  */
   ON rt3.client_id              = vt4.client_id
   AND st.store_id                = vt4.store_id
   AND rt3.s_orig_receipt_nr_ejr  = vt4.orig_receipt_nr_ejr
   AND rt3.s_pos_terminal_id_ejr  = vt4.pos_terminal_id
   AND rt3.s_dat_formdate_ejr     = vt4.dat_formdate
   AND vt4.transactiontype_id     = '100'
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS tr
   ON tr.client_id               = rt3.client_id
   WHERE rt3.is_return_same_checker = 1
   ) rd
QUALIFY rd.return_seq = MAX(rd.return_seq) OVER (                                   /* Filter out duplicates */
   PARTITION BY rd.s_client_id_ejr
      ,rd.s_orig_store_nr_ejr
      ,rd.s_dat_formdate_ejr
      ,rd.s_orig_receipt_nr_ejr )
/* ****************************************************************************************
  New Section for Patch 20190904_2211_ZKP_all_agg_kz

  This section is for scenario_group_id 1001 - 1006. These scenario groups provide data
  for the all occurance of given scenarios.

  scenario_group_id            Description
       1001                    All Suspended
       1002                    All Void
       1003                    All Show Price
       1004                    All Return
       1005                    All Deposit
       1006                    All Resume

*/
UNION ALL
/* This Query provides data for scenaio_group_id = 1002, 1003 & 1005   */
SELECT
  atf.store_id                                            AS p_store_id
 ,atf.client_id                                           AS p_client_id
 ,atf.pos_terminal_id                                     AS p_pos_terminal_id
 ,atf.dat_formdate                                        AS p_dat_formdate
 ,CAST(atf.time_receipt_ejr AS VARCHAR(8))                AS p_time_receipt_ejr
 ,CAST(atf.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
 ,atf.checker_id                                          AS p_checker_id
 ,CASE WHEN atf.cnt_void_ejr                  > 0     THEN CAST(1002 AS SMALLINT)           /* All Void           */
           WHEN atf.transactiontype_id            = '480' THEN CAST(1003 AS SMALLINT)           /* All Show Price     */
           WHEN atf.transactiontype_id            = '100'
             AND ( atf.cnt_all_deposit_back       <> 0
                   OR atf.is_implausible_deposit   = 1
                   OR atf.is_implausible_depositv1 = 1
                   OR atf.is_implausible_depositv2 = 1 )  THEN CAST(1005 AS SMALLINT)           /* All Deposits      */
       END                                                    AS scenario_group_id
 ,atf.store_id                                            AS c_store_id
 ,atf.client_id                                           AS c_client_id
 ,atf.pos_terminal_id                                     AS c_pos_terminal_id
 ,atf.dat_formdate                                        AS c_dat_formdate
 ,atf.time_receipt_ejr                                    AS c_time_receipt_ejr
 ,atf.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
 ,atf.checker_id                                          AS c_checker_id
 ,CAST(atf.transactiontype_id AS CHAR(3))                 AS c_transactiontype_id
 ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
 ,atf.val_retail_ejr                                      AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   WHERE atf.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
AND atf.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id IS NOT NULL
   AND ( atf.transactiontype_id IN ('480')
         OR ( atf.transactiontype_id = '100' AND ( atf.cnt_all_deposit_back  <> 0
                                              OR atf.is_implausible_deposit   = 1
                                              OR atf.is_implausible_depositv1 = 1
                                              OR atf.is_implausible_depositv2 = 1 ) )
         OR ( atf.cnt_void_ejr                > 0 )
       )
  UNION ALL
  /* This section provides data for scenario_group_id = 1001   */
  SELECT                                                                           /* All Suspend   */
       t.p_store_id                                          AS p_store_id
	  ,t.p_client_id                                         AS p_client_id
	  ,t.p_pos_terminal_id                                   AS p_pos_terminal_id
	  ,t.p_dat_formdate                                      AS p_dat_formdate
	  ,t.p_time_receipt_ejr                                  AS p_time_receipt_ejr
	  ,t.p_proof_object_nr_ejr                               AS p_proof_object_nr_ejr
	  ,t.p_checker_id                                        AS p_checker_id
	  ,t.scenario_group_id                                   AS scenario_group_id
	  ,t.c_store_id                                          AS c_store_id
	  ,t.c_client_id                                         AS c_client_id
	  ,t.c_pos_terminal_id                                   AS c_pos_terminal_id
	  ,t.c_dat_formdate                                      AS c_dat_formdate
	  ,t.c_time_receipt_ejr                                  AS c_time_receipt_ejr
	  ,t.c_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
	  ,t.c_checker_id                                        AS c_checker_id
	  ,t.c_transactiontype_id                                AS c_transactiontype_id
	  ,t.resumed_trans_seqnr                                 AS resumed_trans_seqnr
	  ,t.val_retail_ejr                                      AS val_retail_ejr
    FROM (
         SELECT                                                                     /* Suspended Transactions  */
         atf.store_id                                      AS store_id
		,atf.pos_terminal_id                               AS pos_terminal_id
		,atf.dat_formdate                                  AS dat_formdate
		,CAST(atf.orig_receipt_nr_ejr AS VARCHAR(13))      AS object_nr_ejr
          FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   WHERE atf.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
AND atf.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id             IS NOT NULL
   AND atf.transactiontype_id  =  '300'
   AND atf.val_retail_ejr      <> 0
  MINUS
  SELECT                                                                      /* Resumed Transactions  */
     atf.resumed_trans_store_id_ejr                        AS store_id
	,atf.resumed_trans_terminal_id_ejr                     AS pos_terminal_id
	,atf.resumed_trans_date_ejr                            AS dat_formdate
	,CAST(atf.resumed_trans_receipt_nr_ejr AS VARCHAR(13)) AS object_nr_ejr
          FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   WHERE atf.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
AND atf.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id                   IS NOT NULL
   AND atf.resumed_trans_receipt_nr_ejr IS NOT NULL
  ) l
   INNER JOIN (
   SELECT
     atf.store_id                                 AS p_store_id
	,atf.client_id                                AS p_client_id
	,atf.pos_terminal_id                          AS p_pos_terminal_id
	,atf.dat_formdate                             AS p_dat_formdate
	,CAST(atf.time_receipt_ejr AS VARCHAR(8))     AS p_time_receipt_ejr
	,CAST(atf.orig_receipt_nr_ejr AS VARCHAR(13)) AS p_proof_object_nr_ejr
	,atf.checker_id                               AS p_checker_id
	,CAST(1001 AS SMALLINT)                       AS scenario_group_id
	,atf.store_id                                 AS c_store_id
	,atf.client_id                                AS c_client_id
	,atf.pos_terminal_id                          AS c_pos_terminal_id
	,atf.dat_formdate                             AS c_dat_formdate
	,atf.time_receipt_ejr                         AS c_time_receipt_ejr
	,atf.orig_receipt_nr_ejr                      AS c_orig_receipt_nr_ejr
	,atf.checker_id                               AS c_checker_id
	,CAST(atf.transactiontype_id AS CHAR(3))      AS c_transactiontype_id
	,CAST(1 AS BYTEINT)                           AS resumed_trans_seqnr
	,atf.val_retail_ejr                           AS val_retail_ejr
               FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   WHERE atf.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
AND atf.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id            IS NOT NULL
   AND atf.transactiontype_id = '300'
  ) t
   ON l.store_id               = t.p_store_id
   AND l.pos_terminal_id        = t.p_pos_terminal_id
   AND l.dat_formdate           = t.p_dat_formdate
   AND l.object_nr_ejr          = t.p_proof_object_nr_ejr
   UNION ALL
   /* This section provides data for scenario_group_id = 1004 - All Return   */
   SELECT
          rh_gr.store_id                                                                      AS p_store_id
		 ,rh_gr.client_id                                                                     AS p_client_id
		 ,rh_gr.pos_terminal_id                                                               AS p_pos_terminal_id
		 ,rh_gr.dat_formdate                                                                  AS p_dat_formdate
		 ,CAST(rh_gr.time_receipt_ejr AS VARCHAR(8))                                          AS p_time_receipt_ejr
		 ,CAST(rh_gr.orig_receipt_nr_ejr AS VARCHAR(13))                                      AS p_proof_object_nr_ejr
		 ,rh_gr.checker_id                                                                    AS p_checker_id
		 ,CAST(1004 AS SMALLINT)                                                              AS scenario_group_id              /* All Returns     */
		 ,CASE WHEN ur.resumed_trans_seqnr = 1 THEN rh_gr.store_id
                                               ELSE rh_vb.store_id
                END                                                                           AS c_store_id
		,CASE WHEN ur.resumed_trans_seqnr = 1 THEN rh_gr.client_id
                                               ELSE rh_vb.client_id
                END                                                                           AS c_client_id
		,CASE WHEN ur.resumed_trans_seqnr = 1 THEN rh_gr.pos_terminal_id
                                               ELSE rh_vb.pos_terminal_id
                END                                                                           AS c_pos_terminal_id
		,CASE WHEN ur.resumed_trans_seqnr = 1 THEN rh_gr.dat_formdate
                                               ELSE rh_vb.dat_formdate
                END                                                                           AS c_dat_formdate
		,CASE WHEN ur.resumed_trans_seqnr = 1 THEN rh_gr.time_receipt_ejr
                                               ELSE rh_vb.time_receipt_ejr
                END                                                                           AS c_time_receipt_ejr
		,CASE WHEN ur.resumed_trans_seqnr = 1 THEN rh_gr.orig_receipt_nr_ejr
                                               ELSE rh_vb.orig_receipt_nr_ejr
                END                                                                           AS c_orig_receipt_nr_ejr
		,CASE WHEN ur.resumed_trans_seqnr = 1 THEN rh_gr.checker_id
                                               ELSE rh_vb.checker_id
                END                                                                           AS c_checker_id
		,CASE WHEN ur.resumed_trans_seqnr = 1 THEN CAST(rh_gr.transactiontype_id AS CHAR(3))
                                               ELSE CAST(rh_vb.transactiontype_id AS CHAR(3))
                END                                                                           AS c_transactiontype_id
		,CAST(ur.resumed_trans_seqnr AS BYTEINT)                                              AS resumed_trans_seqnr
		,CAST (0 AS DECIMAL(18,4))                                                            AS val_retail_ejr
    FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_gr              /* Returns   */
   INNER JOIN (
   SELECT
           rl.client_id                           AS client_id
		  ,rl.store_id                            AS store_id
		  ,rl.orig_receipt_nr_ejr                 AS orig_receipt_nr_ejr
		  ,rl.pos_terminal_id                     AS pos_terminal_id
		  ,rl.time_receipt_ejr                    AS time_receipt_ejr
		  ,rl.dat_formdate                        AS dat_formdate
		  ,rl.original_orig_receipt_nr_ejr        AS original_orig_receipt_nr_ejr
		  ,rl.original_pos_terminal_id_ejr        AS original_pos_terminal_id_ejr
		  ,rl.original_dat_formdate_ejr           AS original_dat_formdate_ejr
		  ,st.store_id                            AS original_store_sid
                FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS rl                /* Return Lines  */
   LEFT OUTER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st  /* Ermittlung der store SID der Verkaufsbon */
   ON rl.client_id                   = st.client_id
   AND rl.original_orig_store_nr_ejr  = CAST(st.orig_store_nr AS VARCHAR(100))
 WHERE rl.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)   FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = rl.client_id AND revstr1.store_id = rl.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = rl.client_id AND revstr2.store_id = rl.store_id)
AND rl.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = rl.client_id AND revstr3.store_id = rl.store_id)
   AND rl.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = rl.client_id AND revstr4.store_id = rl.store_id)
   AND rl.transactiontype_id BETWEEN '140'   AND '149'                    /* Filter Geldrueckgaben-Zeilen  */
  ) rl
   ON rh_gr.client_id           = rl.client_id
   AND rh_gr.store_id            = rl.store_id
   AND rh_gr.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr
   AND rh_gr.pos_terminal_id     = rl.pos_terminal_id
   AND rh_gr.time_receipt_ejr    = rl.time_receipt_ejr
   AND rh_gr.dat_formdate        = rl.dat_formdate
   INNER JOIN (
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(1 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   UNION ALL
   SELECT resumed_trans_seqnr FROM ( SELECT CAST(3 AS BYTEINT) AS "resumed_trans_seqnr" ) AS src
   ) ur
   ON 1 = 1
   LEFT OUTER JOIN (
   SELECT
           rh_vb.client_id                        AS client_id
		  ,rh_vb.store_id                         AS store_id
		  ,rh_vb.orig_receipt_nr_ejr              AS orig_receipt_nr_ejr
		  ,rh_vb.pos_terminal_id                  AS pos_terminal_id
		  ,rh_vb.dat_formdate                     AS dat_formdate
		  ,rh_vb.time_receipt_ejr                 AS time_receipt_ejr
		  ,rh_vb.checker_id                       AS checker_id
		  ,rh_vb.transactiontype_id               AS transactiontype_id
                FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_1 AS rh_vb /* Original Sales_1 Bon */
   WHERE rh_vb.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = rh_vb.client_id AND revstr1.store_id = rh_vb.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = rh_vb.client_id AND revstr2.store_id = rh_vb.store_id)
AND rh_vb.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = rh_vb.client_id AND revstr3.store_id = rh_vb.store_id)
   AND rh_vb.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = rh_vb.client_id AND revstr4.store_id = rh_vb.store_id)
   ) rh_vb
   ON rl.client_id                        = rh_vb.client_id
   AND rl.original_store_sid               = rh_vb.store_id
   AND rl.original_orig_receipt_nr_ejr     = CAST(rh_vb.orig_receipt_nr_ejr AS VARCHAR(100))
   AND rl.original_pos_terminal_id_ejr     = CAST(rh_vb.pos_terminal_id AS VARCHAR(100))
   AND rl.original_dat_formdate_ejr        = rh_vb.dat_formdate
 WHERE rh_gr.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = rh_gr.client_id AND revstr1.store_id = rh_gr.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = rh_gr.client_id AND revstr2.store_id = rh_gr.store_id)
AND rh_gr.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = rh_gr.client_id AND revstr3.store_id = rh_gr.store_id)
   AND rh_gr.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = rh_gr.client_id AND revstr4.store_id = rh_gr.store_id)
   AND rh_gr.transactiontype_id = '150'                                      /* Filter Geldrueckgaben (Header-transactiontype_id = 150)  */
   AND ( ur.resumed_trans_seqnr = 1 OR ur.resumed_trans_seqnr = 3 AND rh_vb.client_id IS NOT NULL )
  UNION ALL
  /* This section provides data for scenario_group_id = 1006 - All Resume   */
  SELECT
     atf2.store_id                                          AS p_store_id
	,atf2.client_id                                         AS p_client_id
	,atf2.pos_terminal_id                                   AS p_pos_terminal_id
	,atf2.dat_formdate                                      AS p_dat_formdate
	,CAST(atf2.time_receipt_ejr AS VARCHAR(8))              AS p_time_receipt_ejr
	,CAST(atf2.orig_receipt_nr_ejr AS VARCHAR(13))          AS p_proof_object_nr_ejr
	,atf2.checker_id                                        AS p_checker_id
	,CAST(1006 AS SMALLINT)                                 AS scenario_group_id              /* All Resumed      */
	,atf2.store_id                                          AS c_store_id
	,atf2.client_id                                         AS c_client_id
	,atf2.pos_terminal_id                                   AS c_pos_terminal_id
	,atf2.dat_formdate                                      AS c_dat_formdate
	,atf2.time_receipt_ejr                                  AS c_time_receipt_ejr
	,atf2.orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
	,atf2.checker_id                                        AS c_checker_id
	,CAST(atf2.transactiontype_id AS CHAR(3))               AS c_transactiontype_id
	,CAST(1 AS BYTEINT)                                     AS resumed_trans_seqnr
	,atf2.val_retail_ejr                                    AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf1
   INNER JOIN (
   SELECT
       atf2.store_id                              AS store_id
	  ,atf2.client_id                             AS client_id
	  ,atf2.pos_terminal_id                       AS pos_terminal_id
	  ,atf2.dat_formdate                          AS dat_formdate
	  ,atf2.time_receipt_ejr                      AS time_receipt_ejr
	  ,atf2.orig_receipt_nr_ejr                   AS orig_receipt_nr_ejr
	  ,atf2.checker_id                            AS checker_id
	  ,atf2.transactiontype_id                    AS transactiontype_id
	  ,atf2.val_retail_ejr                        AS val_retail_ejr
              FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf2
   WHERE atf2.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = atf2.client_id AND revstr1.store_id = atf2.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = atf2.client_id AND revstr2.store_id = atf2.store_id)
AND atf2.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = atf2.client_id AND revstr3.store_id = atf2.store_id)
   AND atf2.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = atf2.client_id AND revstr4.store_id = atf2.store_id)
   AND atf2.checker_id IS NOT NULL
   ) atf2
   ON atf1.resumed_trans_store_id_ejr    = atf2.store_id
   AND atf1.resumed_trans_terminal_id_ejr = atf2.pos_terminal_id
   AND atf1.resumed_trans_date_ejr        = atf2.dat_formdate
   AND atf1.resumed_trans_receipt_nr_ejr  = atf2.orig_receipt_nr_ejr
   AND atf2.transactiontype_id            = '300'
   WHERE atf1.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = atf1.client_id AND revstr1.store_id = atf1.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = atf1.client_id AND revstr2.store_id = atf1.store_id)
AND atf1.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = atf1.client_id AND revstr3.store_id = atf1.store_id)
   AND atf1.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = atf1.client_id AND revstr4.store_id = atf1.store_id)
   AND atf1.checker_id IS NOT NULL
   AND atf1.resumed_trans_receipt_nr_ejr IS NOT NULL
  UNION ALL
  SELECT
       dep.store_id                                          AS p_store_id
	  ,dep.client_id                                         AS p_client_id
	  ,dep.pos_terminal_id                                   AS p_pos_terminal_id
	  ,dep.dat_formdate                                      AS p_dat_formdate
	  ,CAST(dep.time_receipt_ejr AS VARCHAR(8))              AS p_time_receipt_ejr
	  ,CAST(dep.orig_receipt_nr_ejr AS VARCHAR(13))          AS p_proof_object_nr_ejr
	  ,dep.checker_id                                        AS p_checker_id
	  ,CAST(1005 AS SMALLINT)                                AS scenario_group_id
	  ,dep.store_id                                          AS c_store_id
	  ,dep.client_id                                         AS c_client_id
	  ,dep.pos_terminal_id                                   AS c_pos_terminal_id
	  ,dep.dat_formdate                                      AS c_dat_formdate
	  ,dep.time_receipt_ejr                                  AS c_time_receipt_ejr,   dep.orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
	  ,dep.checker_id                                        AS c_checker_id
	  ,CAST('120' AS CHAR(3))                                AS c_transactiontype_id
	  ,CAST(1 AS BYTEINT)                                    AS resumed_trans_seqnr
	  ,CAST(0 AS DECIMAL(18,4))                              AS val_retail_ejr
    FROM p_lew_mart_msi.v_ejr_transact_deposit_ean_1 dep
   WHERE dep.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = dep.client_id AND revstr1.store_id = dep.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = dep.client_id AND revstr2.store_id = dep.store_id)
AND dep.client_id = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = dep.client_id AND revstr3.store_id = dep.store_id)
   AND dep.store_id  = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = dep.client_id AND revstr4.store_id = dep.store_id)
 UNION ALL
   /* This section provides data for scenario_group_id = 1007   */
  SELECT                                                                           /* All Cancelled   */
       t.p_store_id                                          AS p_store_id
	  ,t.p_client_id                                         AS p_client_id
	  ,t.p_pos_terminal_id                                   AS p_pos_terminal_id
	  ,t.p_dat_formdate                                      AS p_dat_formdate
	  ,t.p_time_receipt_ejr                                  AS p_time_receipt_ejr
	  ,t.p_proof_object_nr_ejr                               AS p_proof_object_nr_ejr
	  ,t.p_checker_id                                        AS p_checker_id
	  ,t.scenario_group_id                                   AS scenario_group_id
	  ,t.c_store_id                                          AS c_store_id
	  ,t.c_client_id                                         AS c_client_id
	  ,t.c_pos_terminal_id                                   AS c_pos_terminal_id
	  ,t.c_dat_formdate                                      AS c_dat_formdate
	  ,t.c_time_receipt_ejr                                  AS c_time_receipt_ejr
	  ,t.c_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
	  ,t.c_checker_id                                        AS c_checker_id
	  ,t.c_transactiontype_id                                AS c_transactiontype_id
	  ,t.resumed_trans_seqnr                                 AS resumed_trans_seqnr
	  ,t.val_retail_ejr                                      AS val_retail_ejr
    FROM (
         SELECT                                                                     /* Cancelled Transactions  */
         atf.store_id                                      AS store_id
		,atf.pos_terminal_id                               AS pos_terminal_id
		,atf.dat_formdate                                  AS dat_formdate
		,CAST(atf.orig_receipt_nr_ejr AS VARCHAR(13))      AS object_nr_ejr
          FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   WHERE atf.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
AND atf.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id             IS NOT NULL
   AND atf.transactiontype_id  =  '200'
   AND atf.val_retail_ejr      <> 0
  MINUS
  SELECT                                                                      /* Resumed Transactions  */
     atf.resumed_trans_store_id_ejr                        AS store_id
	,atf.resumed_trans_terminal_id_ejr                     AS pos_terminal_id
	,atf.resumed_trans_date_ejr                            AS dat_formdate
	,CAST(atf.resumed_trans_receipt_nr_ejr AS VARCHAR(13)) AS object_nr_ejr
          FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   WHERE atf.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
AND atf.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id                   IS NOT NULL
   AND atf.resumed_trans_receipt_nr_ejr IS NOT NULL
  ) l
   INNER JOIN (
   SELECT
     atf.store_id                                 AS p_store_id
	,atf.client_id                                AS p_client_id
	,atf.pos_terminal_id                          AS p_pos_terminal_id
	,atf.dat_formdate                             AS p_dat_formdate
	,CAST(atf.time_receipt_ejr AS VARCHAR(8))     AS p_time_receipt_ejr
	,CAST(atf.orig_receipt_nr_ejr AS VARCHAR(13)) AS p_proof_object_nr_ejr
	,atf.checker_id                               AS p_checker_id
	,CAST(1007 AS SMALLINT)                       AS scenario_group_id
	,atf.store_id                                 AS c_store_id
	,atf.client_id                                AS c_client_id
	,atf.pos_terminal_id                          AS c_pos_terminal_id
	,atf.dat_formdate                             AS c_dat_formdate
	,atf.time_receipt_ejr                         AS c_time_receipt_ejr
	,atf.orig_receipt_nr_ejr                      AS c_orig_receipt_nr_ejr
	,atf.checker_id                               AS c_checker_id
	,CAST(atf.transactiontype_id AS CHAR(3))      AS c_transactiontype_id
	,CAST(1 AS BYTEINT)                           AS resumed_trans_seqnr
	,atf.val_retail_ejr                           AS val_retail_ejr
               FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   WHERE atf.dat_formdate BETWEEN (SELECT MAX(revstr1.dat_formdate_from)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr1
   WHERE revstr1.client_id = atf.client_id AND revstr1.store_id = atf.store_id)
AND (SELECT MAX(revstr2.dat_formdate_until) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr2
   WHERE revstr2.client_id = atf.client_id AND revstr2.store_id = atf.store_id)
AND atf.client_id   = (SELECT MAX(revstr3.client_id) FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr3 WHERE revstr3.client_id = atf.client_id AND revstr3.store_id = atf.store_id)
   AND atf.store_id    = (SELECT MAX(revstr4.store_id)  FROM p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr4 WHERE revstr4.client_id = atf.client_id AND revstr4.store_id = atf.store_id)
   AND atf.checker_id            IS NOT NULL
   AND atf.transactiontype_id = '200'
  ) t
   ON l.store_id               = t.p_store_id
   AND l.pos_terminal_id        = t.p_pos_terminal_id
   AND l.dat_formdate           = t.p_dat_formdate
   AND l.object_nr_ejr          = t.p_proof_object_nr_ejr
   UNION ALL
   /* BBT-1567 : is_return_not_dv */
   SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(63 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
WHERE rt1.is_return_not_dv  = 1
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(63 AS SMALLINT)                                    AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
  AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_not_dv = 1
UNION ALL
/* BBT-1567 : is_return_dv */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(62 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
WHERE rt1.is_return_dv  = 1
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(62 AS SMALLINT)                                    AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
  AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_dv = 1
UNION ALL
/* BBT-1567 : is_return_orig_same_checker */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(64 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
WHERE rt1.is_return_orig_same_checker  = 1
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(64 AS SMALLINT)                                    AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
  AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_orig_same_checker = 1
UNION ALL
/* BBT-1567 : is_return_orig_same_checker_day */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(65 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
WHERE rt1.is_return_orig_same_checker_day  = 1
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(65 AS SMALLINT)                                    AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
  AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_orig_same_checker_day = 1
UNION ALL
/* BBT-1567 : is_return_no_orig_receipt */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(66 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ABS(vt1.val_retail_ejr)                                 AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
 LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt1
-- Get the value of return
   ON rt1.client_id           = vt1.client_id
  AND rt1.store_id            = vt1.store_id
  AND rt1.orig_receipt_nr_ejr = vt1.orig_receipt_nr_ejr
  AND rt1.pos_terminal_id     = vt1.pos_terminal_id
  AND rt1.dat_formdate        = vt1.dat_formdate
WHERE rt1.is_return_no_orig_receipt  = 1
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(66 AS SMALLINT)                                    AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
  AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_no_orig_receipt = 1
UNION ALL
/* Gesamtanzahl manueller Rabatt */
SELECT
   ta1.store_id                                            AS p_store_id
  ,ta1.client_id                                           AS p_client_id
  ,ta1.pos_terminal_id                                     AS p_pos_terminal_id
  ,ta1.dat_formdate                                        AS p_dat_formdate
  ,CAST(ta1.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(ta1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,ta1.checker_id                                          AS p_checker_id
  ,CAST(67 AS SMALLINT)                                    AS scenario_group_id
  ,ta1.store_id                                            AS c_store_id
  ,ta1.client_id                                           AS c_client_id
  ,ta1.pos_terminal_id                                     AS c_pos_terminal_id
  ,ta1.dat_formdate                                        AS c_dat_formdate
  ,ta1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,ta1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,ta1.checker_id                                          AS c_checker_id
  ,ta1.transactiontype_id                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_all_transact_1 ta1
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
   ON ta1.client_id                                = rl.client_id
  AND ta1.store_id                                 = rl.store_id
  AND ta1.pos_terminal_id                          = rl.pos_terminal_id
  AND ta1.dat_formdate = rl.dat_formdate
  AND ta1.orig_receipt_nr_ejr                      = rl.orig_receipt_nr_ejr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 ls
   ON ls.client_id                                 = rl.client_id
  AND rl.store_id                                  =  ls.store_id
WHERE rl.transactiontype_id IN (401,402,441,442,470,502,570,472,482,572,580,582) -- only discounts
AND NOT ((BARCODE LIKE '55%' OR BARCODE LIKE '56%') AND LENGTH(BARCODE) BETWEEN 15 AND 17) -- exclude scanned discounts
AND ABS(rl.val_discount_ejr) > 0.01
UNION ALL
/* Anzahl Bons mit >=X rabattierten Artikeln pro Bon */
SELECT
   ta1.store_id                                            AS p_store_id
  ,ta1.client_id                                           AS p_client_id
  ,ta1.pos_terminal_id                                     AS p_pos_terminal_id
  ,ta1.dat_formdate                                        AS p_dat_formdate
  ,CAST(ta1.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(ta1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,ta1.checker_id                                          AS p_checker_id
  ,CAST(68 AS SMALLINT)                                    AS scenario_group_id
  ,ta1.store_id                                            AS c_store_id
  ,ta1.client_id                                           AS c_client_id
  ,ta1.pos_terminal_id                                     AS c_pos_terminal_id
  ,ta1.dat_formdate                                        AS c_dat_formdate
  ,ta1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,ta1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,ta1.checker_id                                          AS c_checker_id
  ,ta1.transactiontype_id                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_all_transact_1 ta1
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
   ON ta1.client_id                                = rl.client_id
  AND ta1.store_id                                 = rl.store_id
  AND ta1.pos_terminal_id                          = rl.pos_terminal_id
  AND ta1.dat_formdate = rl.dat_formdate
  AND ta1.orig_receipt_nr_ejr                      = rl.orig_receipt_nr_ejr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 ls
   ON ls.client_id                                 = rl.client_id
  AND rl.store_id                                  = ls.store_id
INNER JOIN p_lew_mart_msi_ac.v_ejr_lp_threshold_manual_1 tm
   ON ta1.client_id                                = tm.client_id
  AND ta1.store_id                                 = tm.store_id
  AND ta1.checker_id                               = tm.checker_id
WHERE rl.transactiontype_id IN (401,402,441,442,470,502,570,472,482,572,580,582) -- only discounts
AND NOT ((BARCODE LIKE '55%' OR BARCODE LIKE '56%') AND LENGTH(BARCODE) BETWEEN 15 AND 17) -- exclude scanned discounts
AND ABS(rl.val_discount_ejr) > 0.01
QUALIFY COUNT(*) OVER(PARTITION BY ta1.client_id, ta1.store_id, ta1.dat_formdate, ta1.pos_terminal_id, ta1.orig_receipt_nr_ejr) >= tm.mdiscount_cnt_receipt
UNION ALL
/* Anzahl Bons mit Rabattwert >=X LW pro Bon */
SELECT
   ta1.store_id                                            AS p_store_id
  ,ta1.client_id                                           AS p_client_id
  ,ta1.pos_terminal_id                                     AS p_pos_terminal_id
  ,ta1.dat_formdate                                        AS p_dat_formdate
  ,CAST(ta1.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(ta1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,ta1.checker_id                                          AS p_checker_id
  ,CAST(69 AS SMALLINT)                                    AS scenario_group_id
  ,ta1.store_id                                            AS c_store_id
  ,ta1.client_id                                           AS c_client_id
  ,ta1.pos_terminal_id                                     AS c_pos_terminal_id
  ,ta1.dat_formdate                                        AS c_dat_formdate
  ,ta1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,ta1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,ta1.checker_id                                          AS c_checker_id
  ,ta1.transactiontype_id                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_all_transact_1 ta1
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
   ON ta1.client_id                                = rl.client_id
  AND ta1.store_id                                 = rl.store_id
  AND ta1.pos_terminal_id                          = rl.pos_terminal_id
  AND ta1.dat_formdate = rl.dat_formdate
  AND ta1.orig_receipt_nr_ejr                      = rl.orig_receipt_nr_ejr
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 ls
   ON ls.client_id                                 = rl.client_id
  AND rl.store_id                                  = ls.store_id
INNER JOIN p_lew_mart_msi_ac.v_ejr_lp_threshold_manual_1 tm
   ON ta1.client_id                                = tm.client_id
  AND ta1.store_id                                 = tm.store_id
  AND ta1.checker_id                               = tm.checker_id
WHERE rl.transactiontype_id IN (401,402,441,442,470,502,570,472,482,572,580,582) -- only discounts
AND NOT ((BARCODE LIKE '55%' OR BARCODE LIKE '56%') AND LENGTH(BARCODE) BETWEEN 15 AND 17) -- exclude scanned discounts
QUALIFY SUM(ABS(rl.val_discount_ejr)) OVER(PARTITION BY ta1.client_id, ta1.store_id, ta1.dat_formdate, ta1.pos_terminal_id, ta1.orig_receipt_nr_ejr) >= tm.mdiscount_val_receipt
UNION ALL
/* 20210216_2750_ZKP_RET_NO_RECEIPT: is_return_sc */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(70 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ABS(vt1.val_retail_ejr)                                 AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
 LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt1
-- Get the value of return
   ON rt1.client_id           = vt1.client_id
  AND rt1.store_id            = vt1.store_id
  AND rt1.orig_receipt_nr_ejr = vt1.orig_receipt_nr_ejr
  AND rt1.pos_terminal_id     = vt1.pos_terminal_id
  AND rt1.dat_formdate        = vt1.dat_formdate
WHERE rt1.is_return_sc  = 1
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(70 AS SMALLINT)                                    AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
  AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_sc = 1
UNION ALL
SELECT
   t.store_id                                              AS p_store_id
  ,t.client_id                                             AS p_client_id
  ,t.pos_terminal_id                                       AS p_pos_terminal_id
  ,t.dat_formdate                                          AS p_dat_formdate
  ,CAST(t.time_receipt_ejr    AS VARCHAR(8))               AS p_time_receipt_ejr
  ,CAST(t.orig_receipt_nr_ejr AS VARCHAR(13))              AS p_proof_object_nr_ejr
  ,t.checker_id                                            AS p_checker_id
  ,CAST(71 AS SMALLINT)                                    AS scenario_group_id
  ,t.store_id                                              AS c_store_id
  ,t.client_id                                             AS c_client_id
  ,t.pos_terminal_id                                       AS c_pos_terminal_id
  ,t.dat_formdate                                          AS c_dat_formdate
  ,t.time_receipt_ejr                                      AS c_time_receipt_ejr
  ,t.orig_receipt_nr_ejr                                   AS c_orig_receipt_nr_ejr
  ,t.checker_id                                            AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,t.total_value_void                                      AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_1 t
WHERE is_pay_exact = 1
UNION ALL
SELECT
   t.store_id                                              AS p_store_id
  ,t.client_id                                             AS p_client_id
  ,t.pos_terminal_id                                       AS p_pos_terminal_id
  ,t.dat_formdate                                          AS p_dat_formdate
  ,CAST(t.time_receipt_ejr    AS VARCHAR(8))               AS p_time_receipt_ejr
  ,CAST(t.orig_receipt_nr_ejr AS VARCHAR(13))              AS p_proof_object_nr_ejr
  ,t.checker_id                                            AS p_checker_id
  ,CAST(72 AS SMALLINT)                                    AS scenario_group_id
  ,t.store_id                                              AS c_store_id
  ,t.client_id                                             AS c_client_id
  ,t.pos_terminal_id                                       AS c_pos_terminal_id
  ,t.dat_formdate                                          AS c_dat_formdate
  ,t.time_receipt_ejr                                      AS c_time_receipt_ejr
  ,t.orig_receipt_nr_ejr                                   AS c_orig_receipt_nr_ejr
  ,t.checker_id                                            AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,t.total_value_void                                      AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_1 t
WHERE is_subtotal_bef_storno = 1
UNION ALL
SELECT
   t.store_id                                              AS p_store_id
  ,t.client_id                                             AS p_client_id
  ,t.pos_terminal_id                                       AS p_pos_terminal_id
  ,t.dat_formdate                                          AS p_dat_formdate
  ,CAST(t.time_receipt_ejr    AS VARCHAR(8))               AS p_time_receipt_ejr
  ,CAST(t.orig_receipt_nr_ejr AS VARCHAR(13))              AS p_proof_object_nr_ejr
  ,t.checker_id                                            AS p_checker_id
  ,CAST(73 AS SMALLINT)                                    AS scenario_group_id
  ,t.store_id                                              AS c_store_id
  ,t.client_id                                             AS c_client_id
  ,t.pos_terminal_id                                       AS c_pos_terminal_id
  ,t.dat_formdate                                          AS c_dat_formdate
  ,t.time_receipt_ejr                                      AS c_time_receipt_ejr
  ,t.orig_receipt_nr_ejr                                   AS c_orig_receipt_nr_ejr
  ,t.checker_id                                            AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,t.total_value_void                                      AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_1 t
WHERE is_void_not_authorised = 1
UNION ALL
SELECT
   t.store_id                                              AS p_store_id
  ,t.client_id                                             AS p_client_id
  ,t.pos_terminal_id                                       AS p_pos_terminal_id
  ,t.dat_formdate                                          AS p_dat_formdate
  ,CAST(t.time_receipt_ejr    AS VARCHAR(8))               AS p_time_receipt_ejr
  ,CAST(t.orig_receipt_nr_ejr AS VARCHAR(13))              AS p_proof_object_nr_ejr
  ,t.checker_id                                            AS p_checker_id
  ,CAST(74 AS SMALLINT)                                    AS scenario_group_id
  ,t.store_id                                              AS c_store_id
  ,t.client_id                                             AS c_client_id
  ,t.pos_terminal_id                                       AS c_pos_terminal_id
  ,t.dat_formdate                                          AS c_dat_formdate
  ,t.time_receipt_ejr                                      AS c_time_receipt_ejr
  ,t.orig_receipt_nr_ejr                                   AS c_orig_receipt_nr_ejr
  ,t.checker_id                                            AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,t.total_value_void                                      AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_1 t
WHERE is_highest_val = 1
UNION ALL
SELECT
   t.store_id                                              AS p_store_id
  ,t.client_id                                             AS p_client_id
  ,t.pos_terminal_id                                       AS p_pos_terminal_id
  ,t.dat_formdate                                          AS p_dat_formdate
  ,CAST(t.time_receipt_ejr    AS VARCHAR(8))               AS p_time_receipt_ejr
  ,CAST(t.orig_receipt_nr_ejr AS VARCHAR(13))              AS p_proof_object_nr_ejr
  ,t.checker_id                                            AS p_checker_id
  ,CAST(75 AS SMALLINT)                                    AS scenario_group_id
  ,t.store_id                                              AS c_store_id
  ,t.client_id                                             AS c_client_id
  ,t.pos_terminal_id                                       AS c_pos_terminal_id
  ,t.dat_formdate                                          AS c_dat_formdate
  ,t.time_receipt_ejr                                      AS c_time_receipt_ejr
  ,t.orig_receipt_nr_ejr                                   AS c_orig_receipt_nr_ejr
  ,t.checker_id                                            AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,t.total_value_void                                      AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_1 t
WHERE is_alk_tab = 1
UNION ALL
SELECT
   t.store_id                                              AS p_store_id
  ,t.client_id                                             AS p_client_id
  ,t.pos_terminal_id                                       AS p_pos_terminal_id
  ,t.dat_formdate                                          AS p_dat_formdate
  ,CAST(t.time_receipt_ejr    AS VARCHAR(8))               AS p_time_receipt_ejr
  ,CAST(t.orig_receipt_nr_ejr AS VARCHAR(13))              AS p_proof_object_nr_ejr
  ,t.checker_id                                            AS p_checker_id
  ,CAST(76 AS SMALLINT)                                    AS scenario_group_id
  ,t.store_id                                              AS c_store_id
  ,t.client_id                                             AS c_client_id
  ,t.pos_terminal_id                                       AS c_pos_terminal_id
  ,t.dat_formdate                                          AS c_dat_formdate
  ,t.time_receipt_ejr                                      AS c_time_receipt_ejr
  ,t.orig_receipt_nr_ejr                                   AS c_orig_receipt_nr_ejr
  ,t.checker_id                                            AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,t.total_value_void                                      AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_1 t
WHERE is_1_itm = 1
UNION ALL
SELECT
   t.store_id                                              AS p_store_id
  ,t.client_id                                             AS p_client_id
  ,t.pos_terminal_id                                       AS p_pos_terminal_id
  ,t.dat_formdate                                          AS p_dat_formdate
  ,CAST(t.time_receipt_ejr    AS VARCHAR(8))               AS p_time_receipt_ejr
  ,CAST(t.orig_receipt_nr_ejr AS VARCHAR(13))              AS p_proof_object_nr_ejr
  ,t.checker_id                                            AS p_checker_id
  ,CAST(21 AS SMALLINT)                                    AS scenario_group_id
  ,t.store_id                                              AS c_store_id
  ,t.client_id                                             AS c_client_id
  ,t.pos_terminal_id                                       AS c_pos_terminal_id
  ,t.dat_formdate                                          AS c_dat_formdate
  ,t.time_receipt_ejr                                      AS c_time_receipt_ejr
  ,t.orig_receipt_nr_ejr                                   AS c_orig_receipt_nr_ejr
  ,t.checker_id                                            AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,t.total_value_void                                      AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_1 t
 UNION ALL
SELECT
     atf.store_id                                         AS p_store_id
	,atf.client_id                                         AS p_client_id
	,atf.pos_terminal_id                                   AS p_pos_terminal_id
	,atf.dat_formdate                                      AS p_dat_formdate
	,CAST(atf.time_receipt_ejr AS VARCHAR(8))              AS p_time_receipt_ejr
	,CAST(atf.orig_receipt_nr_ejr AS VARCHAR(13))          AS p_proof_object_nr_ejr
	,atf.checker_id                                        AS p_checker_id
	,CAST(77 AS SMALLINT)                                  AS scenario_group_id            
	,atf.store_id                                          AS c_store_id
	,atf.client_id                                         AS c_client_id
	,atf.pos_terminal_id                                   AS c_pos_terminal_id
	,atf.dat_formdate                                      AS c_dat_formdate
	,atf.time_receipt_ejr                                  AS c_time_receipt_ejr
	,atf.orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
	,atf.checker_id                                        AS c_checker_id
	,CAST(atf.transactiontype_id AS CHAR(3))               AS c_transaction_type_id
	,CAST(1 AS BYTEINT)                                    AS resumed_trans_seqnr
	,atf.val_retail_ejr                                    AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 atf
   INNER JOIN p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 th_r
   ON th_r.client_id  = atf.client_id   
   WHERE atf.transactiontype_id IN( '100', '150')
   AND atf.cnt_selling_position_ejr = 0 
   AND atf.val_sc_deposit_back = 0
   AND atf.val_ke_deposit_back <> 0
   AND atf.cnt_return_ejr <= atf.cnt_deposit_ejr
   AND ABS(atf.val_retail_ejr) > th_r.deposit_noitm_tot_val
 UNION ALL
/* Geldruckgabe ohne Originalbon (manuell) */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(78 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ABS(vt1.val_retail_ejr)                                 AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
 LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt1
-- Get the value of return
   ON rt1.client_id           = vt1.client_id
  AND rt1.store_id            = vt1.store_id
  AND rt1.orig_receipt_nr_ejr = vt1.orig_receipt_nr_ejr
  AND rt1.pos_terminal_id     = vt1.pos_terminal_id
  AND rt1.dat_formdate        = vt1.dat_formdate
WHERE rt1.is_return_no_orig_receipt_man = 1
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(78 AS SMALLINT)                                    AS scenario_group_id
  ,rt2.store_id                                            AS c_store_id
  ,rt2.client_id                                           AS c_client_id
  ,rt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt2.dat_formdate                                        AS c_dat_formdate
  ,rt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,rt2.checker_id                                          AS c_checker_id
  ,CAST('100'  AS CHAR(3))                                 AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
WHERE rt2.is_return_no_orig_receipt_man = 1
UNION ALL
/* Geldruckgabe mehrerer Artikel_1 eines Originalbons */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(79 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ABS(vt1.val_retail_ejr)                                 AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
 LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt1
-- Get the value of return
   ON rt1.client_id           = vt1.client_id
  AND rt1.store_id            = vt1.store_id
  AND rt1.orig_receipt_nr_ejr = vt1.orig_receipt_nr_ejr
  AND rt1.pos_terminal_id     = vt1.pos_terminal_id
  AND rt1.dat_formdate        = vt1.dat_formdate
WHERE rt1.is_return_many_itm = 1
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(79 AS SMALLINT)                                    AS scenario_group_id
  ,st.store_id                                             AS c_store_id
  ,rt2.client_id                                           AS c_client_id
  ,rt2.s_pos_terminal_id_ejr                               AS c_pos_terminal_id
  ,rt2.s_dat_formdate_ejr                                  AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST('100'  AS CHAR(3))                                 AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
 INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st         /* Ermittlung der store_id */
 ON rt2.client_id              = st.client_id
 AND rt2.s_orig_store_nr_ejr   = CAST(st.orig_store_nr AS VARCHAR(100))
 LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- Get the value of time_receipt_ejr of original receipt
 ON  rt2.client_id             = vt2.client_id
 AND st.store_id               = vt2.store_id
 AND rt2.s_orig_receipt_nr_ejr = vt2.orig_receipt_nr_ejr
 AND rt2.s_pos_terminal_id_ejr = vt2.pos_terminal_id
 AND rt2.s_dat_formdate_ejr    = vt2.dat_formdate
WHERE rt2.is_return_many_itm = 1
UNION ALL
/* Geldruckgabe mehrerer Artikel_1 eines Originalbons - Geldruckgaben mit Ruckgabe aller Artikel_1 */


SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(80 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ABS(vt1.val_retail_ejr)                                 AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
 LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt1
-- Get the value of return
   ON rt1.client_id           = vt1.client_id
  AND rt1.store_id            = vt1.store_id
  AND rt1.orig_receipt_nr_ejr = vt1.orig_receipt_nr_ejr
  AND rt1.pos_terminal_id     = vt1.pos_terminal_id
  AND rt1.dat_formdate        = vt1.dat_formdate
WHERE rt1.is_return_same_itm_nb = 1
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(80 AS SMALLINT)                                    AS scenario_group_id
  ,st.store_id                                             AS c_store_id
  ,rt2.client_id                                           AS c_client_id
  ,rt2.s_pos_terminal_id_ejr                               AS c_pos_terminal_id
  ,rt2.s_dat_formdate_ejr                                  AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST('100'  AS CHAR(3))                                 AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
 INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS st         /* Ermittlung der store_id */
 ON rt2.client_id              = st.client_id
 AND rt2.s_orig_store_nr_ejr   = CAST(st.orig_store_nr AS VARCHAR(100))
 LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- Get the value of time_receipt_ejr of original receipt
 ON  rt2.client_id             = vt2.client_id
 AND st.store_id               = vt2.store_id
 AND rt2.s_orig_receipt_nr_ejr = vt2.orig_receipt_nr_ejr
 AND rt2.s_pos_terminal_id_ejr = vt2.pos_terminal_id
 AND rt2.s_dat_formdate_ejr    = vt2.dat_formdate
WHERE rt2.is_return_same_itm_nb = 1

UNION ALL

  /* Preisanzeigen mit NonFood Artikeln */

SELECT
   ta1.store_id                                            AS p_store_id
  ,ta1.client_id                                           AS p_client_id
  ,ta1.pos_terminal_id                                     AS p_pos_terminal_id
  ,ta1.dat_formdate                                        AS p_dat_formdate
  ,CAST(ta1.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(ta1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,ta1.checker_id                                          AS p_checker_id
  ,CAST(81 AS SMALLINT) 								   AS scenario_group_id
  ,ta1.store_id                                            AS c_store_id
  ,ta1.client_id                                           AS c_client_id
  ,ta1.pos_terminal_id                                     AS c_pos_terminal_id
  ,ta1.dat_formdate                                        AS c_dat_formdate
  ,ta1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,ta1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,ta1.checker_id                                          AS c_checker_id
  ,ta1.transactiontype_id                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS p_val_retail_ejr
FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 ta1
INNER JOIN p_lew_mart_msi.V_MAT0_ZKP_ETL_EJR_PRICE_INFO_EXTRACT_1 pr_inf
ON ta1.client_id = pr_inf.client_id
  AND ta1.store_id = pr_inf.store_id
  AND ta1.pos_terminal_id = pr_inf.pos_terminal_id
  AND ta1.orig_receipt_nr_ejr = pr_inf.orig_receipt_nr_ejr
  AND ta1.dat_formdate = pr_inf.dat_formdate
INNER JOIN p_lew_core_ac.v_wawi_itm_item_act_1               itm
ON ta1.client_id = itm.client_id 
  AND pr_inf.item_id = itm.item_sid
INNER JOIN p_lew_core_ac.v_wawi_itm_subitemgroup_1 		   wgi
ON itm.client_id = wgi.client_id
  AND itm.subitemgroup_id= wgi.subitemgroup_id
  AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end  --actual sub item_1 groups
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 ls
ON ls.client_id                                 = ta1.client_id
  AND  ls.store_id                                 = ta1.store_id
INNER JOIN p_lew_mart_msi_ac.v_ejr_lp_threshold_manual_1  AS tm 
ON tm.client_id =  ta1.client_id 
  AND tm.store_id = ta1.store_id
  AND tm.checker_id = ta1.checker_id
WHERE ta1.transactiontype_id IN (480) -- only show price ops
AND wgi.itemgroup_int_id IN (70) -- only NonFood
AND ta1.val_retail_ejr >= tm.mshow_price_val_nf_low -- only greater or equal to threshold value

UNION ALL

/* Preisanzeigen mit Alkoholartikeln OR mit Tabakartikeln */

SELECT
   ta1.store_id                                            AS p_store_id
  ,ta1.client_id                                           AS p_client_id
  ,ta1.pos_terminal_id                                     AS p_pos_terminal_id
  ,ta1.dat_formdate                                        AS p_dat_formdate
  ,CAST(ta1.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(ta1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,ta1.checker_id                                          AS p_checker_id
  ,CASE WHEN itm.subitemgroup_id IN (60,61,63) THEN 82
        WHEN itm.subitemgroup_id = 80 THEN 83
   END  AS scenario_group_id
  ,ta1.store_id                                            AS c_store_id
  ,ta1.client_id                                           AS c_client_id
  ,ta1.pos_terminal_id                                     AS c_pos_terminal_id
  ,ta1.dat_formdate                                        AS c_dat_formdate
  ,ta1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,ta1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,ta1.checker_id                                          AS c_checker_id
  ,ta1.transactiontype_id                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS p_val_retail_ejr
FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 ta1
INNER JOIN p_lew_mart_msi.V_MAT0_ZKP_ETL_EJR_PRICE_INFO_EXTRACT_1 pr_inf
ON ta1.client_id = pr_inf.client_id
  AND ta1.store_id = pr_inf.store_id
  AND ta1.pos_terminal_id = pr_inf.pos_terminal_id
  AND ta1.orig_receipt_nr_ejr = pr_inf.orig_receipt_nr_ejr
  AND ta1.dat_formdate = pr_inf.dat_formdate
INNER JOIN p_lew_mart_msi_ac.v_itm_item_1               itm
ON ta1.client_id = itm.client_id AND
   pr_inf.item_id = itm.item_id
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 ls
   ON ls.client_id                                 = ta1.client_id
  AND  ls.store_id                                 = ta1.store_id                                 
WHERE ta1.transactiontype_id IN (480) -- only show price ops
AND (itm.subitemgroup_id IN (60,61,63) -- only Alkoholwaren
  OR itm.subitemgroup_id = 80) -- only Tabakwaren 

UNION ALL

/* Preisanzeige Vorgange (aus Bonnumer) */

SELECT
 p_store_id
,p_client_id
,p_pos_terminal_id
,p_dat_formdate
,p_time_receipt_ejr
,p_proof_object_nr_ejr
,p_checker_id
,scenario_group_id
,c_store_id
,c_client_id
,c_pos_terminal_id
,c_dat_formdate
,c_time_receipt_ejr
,c_orig_receipt_nr_ejr
,c_checker_id
,c_transaction_type_id
,resumed_trans_seqnr
,p_val_retail_ejr
FROM
(
SELECT 
  store_id AS p_store_id
,client_id AS p_client_id
,pos_terminal_id AS p_pos_terminal_id
,dat_formdate AS p_dat_formdate
,time_receipt_ejr AS p_time_receipt_ejr
,CAST(orig_receipt_nr_ejr-ROW_NUMBER() OVER (PARTITION BY client_id,store_id,checker_id,dat_formdate ORDER BY orig_receipt_nr_ejr) AS VARCHAR(13)) AS p_proof_object_nr_ejr -- used to uniquely identify a series
,checker_id AS p_checker_id
,CAST(84 AS SMALLINT) AS scenario_group_id
,store_id                                            AS c_store_id
,client_id                                           AS c_client_id
,pos_terminal_id                                     AS c_pos_terminal_id
,dat_formdate                                        AS c_dat_formdate
,time_receipt_ejr                                    AS c_time_receipt_ejr
,orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
,checker_id                                          AS c_checker_id
,CAST('480' AS CHAR(3))                              AS c_transaction_type_id
,CAST(1 AS BYTEINT)                                  AS resumed_trans_seqnr
,CAST(0 AS DECIMAL(18,4))                            AS p_val_retail_ejr
FROM 
  (
  SELECT
   client_id
  ,store_id
  ,checker_id
  ,pos_terminal_id
  ,dat_formdate
  ,time_receipt_ejr
  , LAG(orig_receipt_nr_ejr) OVER (ORDER BY client_id, store_id, checker_id, dat_formdate, orig_receipt_nr_ejr) lprev
  ,LEAD(orig_receipt_nr_ejr) OVER (ORDER BY client_id, store_id, checker_id, dat_formdate, orig_receipt_nr_ejr) lnext
  ,orig_receipt_nr_ejr 
  FROM p_lew_mart_msi.v_ejr_all_transact_follower_1    a11
  WHERE transactiontype_id=480
  )
WHERE CASE WHEN orig_receipt_nr_ejr-lprev=1 OR lnext-orig_receipt_nr_ejr=1 THEN orig_receipt_nr_ejr ElSE NULL END IS NOT NULL -- only Sequences (Vorgange) 
) s84
INNER JOIN p_lew_mart_msi_ac.v_ejr_lp_threshold_manual_1  AS tm 
ON tm.client_id =  s84.p_client_id 
  AND tm.store_id = s84.p_store_id
  AND tm.checker_id = s84.p_checker_id
QUALIFY COUNT (*) OVER (PARTITION BY p_client_id, p_store_id, p_checker_id, p_dat_formdate, p_proof_object_nr_ejr) > tm.mshow_price_cnt_vg_infolge_low --take only amount of sequences greater than threshold

UNION ALL
/* AP0177990: Gleicher Bediener/gleicher Tag_1 + not DV */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(85 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
ON rt1.client_id                  = rl.client_id
  AND rt1.store_id                = rl.store_id
  AND rt1.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rt1.pos_terminal_id         = rl.pos_terminal_id
  AND rt1.time_receipt_ejr        = rl.time_receipt_ejr
  AND rt1.dat_formdate            = rl.dat_formdate
WHERE rt1.is_return_same_checker  = 1
  AND rt1.dat_formdate = rt1.s_dat_formdate_ejr
  AND rl.item_entry_method_cd_ejr = 'KE'                                     
  AND rl.item_entry_method_cd_ejr <> 'DV'
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(85 AS SMALLINT)                                    AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl 
ON rt2.client_id                  = rl.client_id
  AND rt2.store_id                = rl.store_id
  AND rt2.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
  AND rt2.pos_terminal_id         = rl.pos_terminal_id
  AND rt2.time_receipt_ejr        = rl.time_receipt_ejr
  AND rt2.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
  AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_same_checker  = 1
  AND rt2.dat_formdate = rt2.s_dat_formdate_ejr
  AND rl.item_entry_method_cd_ejr = 'KE'                                     
  AND rl.item_entry_method_cd_ejr <> 'DV'
/* AP0198116: Anzahl Geldrückgaben Bar */
UNION ALL
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(100 AS SMALLINT)                                   AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
    ON rt1.client_id                  = rl.client_id
    AND rt1.store_id                = rl.store_id
    AND rt1.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
    AND rt1.pos_terminal_id         = rl.pos_terminal_id
    AND rt1.time_receipt_ejr        = rl.time_receipt_ejr
    AND rt1.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1 p
    ON rt1.client_id                  = p.client_id
    AND rt1.store_id                = p.store_id
    AND rt1.orig_receipt_nr_ejr     = p.orig_receipt_nr_ejr
    AND rt1.pos_terminal_id         = p.pos_terminal_id
    AND rt1.time_receipt_ejr        = p.time_receipt_ejr
    AND rt1.dat_formdate            = p.dat_formdate
WHERE rt1.is_return_same_checker  = 1
  AND rt1.dat_formdate = rt1.s_dat_formdate_ejr
  AND p.tendertype_cd_ejr = 11
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(100 AS SMALLINT)                                   AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl 
    ON rt2.client_id                  = rl.client_id
    AND rt2.store_id                = rl.store_id
    AND rt2.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
    AND rt2.pos_terminal_id         = rl.pos_terminal_id
    AND rt2.time_receipt_ejr        = rl.time_receipt_ejr
    AND rt2.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
    ON rt2.s_client_id_ejr          = st.client_id
    AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
    ON rt2.client_id                = vt2.client_id
    AND st.store_id                  = vt2.store_id
    AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
    AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
    AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1 p
    ON rt2.client_id                  = p.client_id
    AND rt2.store_id                = p.store_id
    AND rt2.orig_receipt_nr_ejr     = p.orig_receipt_nr_ejr
    AND rt2.pos_terminal_id         = p.pos_terminal_id
    AND rt2.time_receipt_ejr        = p.time_receipt_ejr
    AND rt2.dat_formdate            = p.dat_formdate
WHERE rt2.is_return_same_checker  = 1
  AND rt2.dat_formdate = rt2.s_dat_formdate_ejr
  AND p.tendertype_cd_ejr = 11
UNION ALL
/* AP0198116: Anzahl Geldrückgaben EC-Karte */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(101 AS SMALLINT)                                   AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl
    ON rt1.client_id                  = rl.client_id
    AND rt1.store_id                = rl.store_id
    AND rt1.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
    AND rt1.pos_terminal_id         = rl.pos_terminal_id
    AND rt1.time_receipt_ejr        = rl.time_receipt_ejr
    AND rt1.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1 p
    ON rt1.client_id                  = p.client_id
    AND rt1.store_id                = p.store_id
    AND rt1.orig_receipt_nr_ejr     = p.orig_receipt_nr_ejr
    AND rt1.pos_terminal_id         = p.pos_terminal_id
    AND rt1.time_receipt_ejr        = p.time_receipt_ejr
    AND rt1.dat_formdate            = p.dat_formdate
WHERE rt1.is_return_same_checker  = 1
  AND rt1.dat_formdate = rt1.s_dat_formdate_ejr
  AND p.tendertype_cd_ejr = 12
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(101 AS SMALLINT)                                   AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 rl 
    ON rt2.client_id                  = rl.client_id
    AND rt2.store_id                = rl.store_id
    AND rt2.orig_receipt_nr_ejr     = rl.orig_receipt_nr_ejr
    AND rt2.pos_terminal_id         = rl.pos_terminal_id
    AND rt2.time_receipt_ejr        = rl.time_receipt_ejr
    AND rt2.dat_formdate            = rl.dat_formdate
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
    ON rt2.s_client_id_ejr          = st.client_id
    AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
    ON rt2.client_id                = vt2.client_id
    AND st.store_id                  = vt2.store_id
    AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
    AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
    AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_1 p
    ON rt2.client_id                  = p.client_id
    AND rt2.store_id                = p.store_id
    AND rt2.orig_receipt_nr_ejr     = p.orig_receipt_nr_ejr
    AND rt2.pos_terminal_id         = p.pos_terminal_id
    AND rt2.time_receipt_ejr        = p.time_receipt_ejr
    AND rt2.dat_formdate            = p.dat_formdate
WHERE rt2.is_return_same_checker  = 1
  AND rt2.dat_formdate = rt2.s_dat_formdate_ejr
  AND p.tendertype_cd_ejr = 12
UNION ALL
/* AP0198116: Geldrückgaben mit Originalbon vom anderen Tag_1 vom selben Bediener */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(102 AS SMALLINT)                                   AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
WHERE rt1.is_return_orig_same_checker  = 1
AND rt1.dat_formdate != rt1.s_dat_formdate_ejr
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(102 AS SMALLINT)                                    AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
  AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_orig_same_checker = 1
AND rt2.dat_formdate != rt2.s_dat_formdate_ejr
UNION ALL
/* AP0177990: Gleicher Bediener/gleicher Tag_1 unter Autorisierung */
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt1.time_receipt_ejr      AS VARCHAR(8))           AS p_time_receipt_ejr
  ,CAST(rt1.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(86 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
INNER JOIN p_lew_mart_msi_ac.v_ejr_lp_threshold_receipt_1  AS tm 
	ON tm.client_id = rt1.client_id
	WHERE rt1.is_return_same_checker  = 1
	AND rt1.dat_formdate = rt1.s_dat_formdate_ejr
	AND rt1.val_return_same_receipt BETWEEN tm.return_same_checker_val_ebb_m AND tm.return_same_checker_val_ebb_l
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(86 AS SMALLINT)                                    AS scenario_group_id
  ,COALESCE(vt2.store_id,rt2.store_id)                     AS c_store_id
  ,COALESCE(vt2.client_id,rt2.client_id)                   AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,COALESCE(vt2.dat_formdate,rt2.dat_formdate)             AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,vt2.checker_id                                          AS c_checker_id
  ,CAST(COALESCE(vt2.transactiontype_id, '100') AS CHAR(3))AS c_transaction_type_id
  ,CAST(2 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
	ON rt2.s_client_id_ejr          = st.client_id
	AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
INNER JOIN p_lew_mart_msi_ac.v_ejr_lp_threshold_receipt_1  AS tm 
	ON tm.client_id = rt2.client_id
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
-- left join to show all the returns, even if original receipt cannot be found
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_same_checker = 1
AND rt2.dat_formdate = rt2.s_dat_formdate_ejr
AND rt2.val_return_same_receipt BETWEEN tm.return_same_checker_val_ebb_m AND tm.return_same_checker_val_ebb_l
UNION ALL
SELECT
   rt1.store_id                                            AS p_store_id
  ,rt1.client_id                                           AS p_client_id
  ,rt1.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt1.dat_last_returndate                                 AS p_dat_formdate
  ,CAST((
   SELECT MIN(time_receipt_ejr)
   FROM p_lew_mart_msi.v_ejr_return_transact_1 
   WHERE is_return_same_checker  = 1
   AND s_orig_receipt_nr_ejr = rt1.s_orig_receipt_nr_ejr
   AND checker_id = rt1.checker_id
   AND dat_last_returndate = rt1.dat_last_returndate
   AND store_id = rt1.store_id
   AND client_id = rt1.client_id
   )   AS VARCHAR(8))                                      AS p_time_receipt_ejr
  -- for multiple returns: show the first return.
  -- in this way returns will be grouped by original receipt in Bonausdruck and multiple returns will be attached to the first return
  ,CAST((
   SELECT MIN(orig_receipt_nr_ejr)
   FROM p_lew_mart_msi.v_ejr_return_transact_1 
   WHERE is_return_same_checker  = 1
   AND s_orig_receipt_nr_ejr = rt1.s_orig_receipt_nr_ejr
   AND checker_id = rt1.checker_id
   AND dat_last_returndate = rt1.dat_last_returndate
   AND store_id = rt1.store_id
   AND client_id = rt1.client_id
   )                            AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt1.checker_id                                          AS p_checker_id
  ,CAST(87 AS SMALLINT)                                    AS scenario_group_id
  ,rt1.store_id                                            AS c_store_id
  ,rt1.client_id                                           AS c_client_id
  ,rt1.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt1.dat_formdate                                        AS c_dat_formdate
  ,rt1.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt1.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,rt1.checker_id                                          AS c_checker_id
  ,CAST('150' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt1
WHERE rt1.is_return_same_checker  = 1
AND rt1.dat_formdate = rt1.s_dat_formdate_ejr
UNION ALL
SELECT
   rt2.store_id                                            AS p_store_id
  ,rt2.client_id                                           AS p_client_id
  ,rt2.pos_terminal_id                                     AS p_pos_terminal_id
  ,rt2.dat_last_returndate                                 AS p_dat_formdate
  ,CAST(rt2.time_receipt_ejr    AS VARCHAR(8))             AS p_time_receipt_ejr
  ,CAST(rt2.orig_receipt_nr_ejr AS VARCHAR(13))            AS p_proof_object_nr_ejr
  ,rt2.checker_id                                          AS p_checker_id
  ,CAST(87 AS SMALLINT)                                    AS scenario_group_id
  ,rt2.store_id                                            AS c_store_id
  ,rt2.client_id                                           AS c_client_id
  ,vt2.pos_terminal_id                                     AS c_pos_terminal_id
  ,rt2.dat_formdate                                        AS c_dat_formdate
  ,vt2.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,rt2.s_orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,rt2.checker_id                                          AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(3 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM p_lew_mart_msi.v_ejr_return_transact_1 rt2
INNER JOIN p_lew_mart_msi.v_sys_revision_load_store_1 st
   ON rt2.s_client_id_ejr          = st.client_id
  AND rt2.s_orig_store_nr_ejr      = st.orig_store_nr
LEFT OUTER JOIN p_lew_mart_msi.v_ejr_all_transact_1 vt2
   ON rt2.client_id                = vt2.client_id
  AND st.store_id                  = vt2.store_id
  AND rt2.s_orig_receipt_nr_ejr    = vt2.orig_receipt_nr_ejr
  AND rt2.s_pos_terminal_id_ejr    = vt2.pos_terminal_id
  AND rt2.s_dat_formdate_ejr       = vt2.dat_formdate
WHERE rt2.is_return_same_checker = 1
AND rt2.dat_formdate = rt2.s_dat_formdate_ejr
-- remove duplicates
QUALIFY p_proof_object_nr_ejr = MIN(p_proof_object_nr_ejr) OVER(PARTITION BY rt2.client_id, rt2.store_id, rt2.checker_id, rt2.dat_formdate, rt2.s_orig_receipt_nr_ejr)
/* AP0182639 Storno Begünstigung Bonsumme <X LW + 1 Artikel_1 */
UNION ALL
SELECT
   ta.store_id                                             AS p_store_id
  ,ta.client_id                                            AS p_client_id
  ,ta.pos_terminal_id                                      AS p_pos_terminal_id
  ,ta.dat_formdate                                         AS p_dat_formdate
  ,CAST(ta.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(ta.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,ta.checker_id                                           AS p_checker_id
  ,CAST(88 AS SMALLINT)                                    AS scenario_group_id
  ,ta.store_id                                             AS c_store_id
  ,ta.client_id                                            AS c_client_id
  ,ta.pos_terminal_id                                      AS c_pos_terminal_id
  ,ta.dat_formdate                                         AS c_dat_formdate
  ,ta.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,ta.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,ta.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ta.total_value_void                                     AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_adv_1 ta
WHERE is_1_itm_2 = 1
/* AP0182639 Storno Bons außerhalb der Öffnungszeit */
UNION ALL
SELECT
   ta.store_id                                             AS p_store_id
  ,ta.client_id                                            AS p_client_id
  ,ta.pos_terminal_id                                      AS p_pos_terminal_id
  ,ta.dat_formdate                                         AS p_dat_formdate
  ,CAST(ta.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(ta.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,ta.checker_id                                           AS p_checker_id
  ,CAST(89 AS SMALLINT)                                    AS scenario_group_id
  ,ta.store_id                                             AS c_store_id
  ,ta.client_id                                            AS c_client_id
  ,ta.pos_terminal_id                                      AS c_pos_terminal_id
  ,ta.dat_formdate                                         AS c_dat_formdate
  ,ta.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,ta.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,ta.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ta.total_value_void                                     AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_adv_1 ta
WHERE is_outside_hours = 1
/* AP0182639 Storno Bons mit manuellem Rabatt */
UNION ALL
SELECT
   ta.store_id                                             AS p_store_id
  ,ta.client_id                                            AS p_client_id
  ,ta.pos_terminal_id                                      AS p_pos_terminal_id
  ,ta.dat_formdate                                         AS p_dat_formdate
  ,CAST(ta.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(ta.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,ta.checker_id                                           AS p_checker_id
  ,CAST(90 AS SMALLINT)                                    AS scenario_group_id
  ,ta.store_id                                             AS c_store_id
  ,ta.client_id                                            AS c_client_id
  ,ta.pos_terminal_id                                      AS c_pos_terminal_id
  ,ta.dat_formdate                                         AS c_dat_formdate
  ,ta.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,ta.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,ta.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ta.total_value_void                                     AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_adv_1 ta
WHERE is_man_discount = 1
/* AP0182639 Storno Beguenstigung */
UNION ALL
SELECT
   ta.store_id                                             AS p_store_id
  ,ta.client_id                                            AS p_client_id
  ,ta.pos_terminal_id                                      AS p_pos_terminal_id
  ,ta.dat_formdate                                         AS p_dat_formdate
  ,CAST(ta.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(ta.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,ta.checker_id                                           AS p_checker_id
  ,CAST(91 AS SMALLINT)                                    AS scenario_group_id
  ,ta.store_id                                             AS c_store_id
  ,ta.client_id                                            AS c_client_id
  ,ta.pos_terminal_id                                      AS c_pos_terminal_id
  ,ta.dat_formdate                                         AS c_dat_formdate
  ,ta.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,ta.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,ta.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ta.total_value_void                                     AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_adv_1 ta
/* AP0182639 Bons glatt bezahlt (Begünstigung) */
UNION ALL
SELECT
   ta.store_id                                             AS p_store_id
  ,ta.client_id                                            AS p_client_id
  ,ta.pos_terminal_id                                      AS p_pos_terminal_id
  ,ta.dat_formdate                                         AS p_dat_formdate
  ,CAST(ta.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(ta.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,ta.checker_id                                           AS p_checker_id
  ,CAST(92 AS SMALLINT)                                    AS scenario_group_id
  ,ta.store_id                                             AS c_store_id
  ,ta.client_id                                            AS c_client_id
  ,ta.pos_terminal_id                                      AS c_pos_terminal_id
  ,ta.dat_formdate                                         AS c_dat_formdate
  ,ta.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,ta.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,ta.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ta.total_value_void                                     AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_adv_1 ta
WHERE is_pay_exact = 1
/* AP0182639 Zwischensumme vor Storno Begünstigung */
UNION ALL
SELECT
   ta.store_id                                             AS p_store_id
  ,ta.client_id                                            AS p_client_id
  ,ta.pos_terminal_id                                      AS p_pos_terminal_id
  ,ta.dat_formdate                                         AS p_dat_formdate
  ,CAST(ta.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(ta.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,ta.checker_id                                           AS p_checker_id
  ,CAST(93 AS SMALLINT)                                    AS scenario_group_id
  ,ta.store_id                                             AS c_store_id
  ,ta.client_id                                            AS c_client_id
  ,ta.pos_terminal_id                                      AS c_pos_terminal_id
  ,ta.dat_formdate                                         AS c_dat_formdate
  ,ta.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,ta.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,ta.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ta.total_value_void                                     AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_adv_1 ta
WHERE is_subtotal_bef_storno = 1
/* AP0182639 Storno Begünstigung nicht autorisierungspflichtig */
UNION ALL
SELECT
   ta.store_id                                             AS p_store_id
  ,ta.client_id                                            AS p_client_id
  ,ta.pos_terminal_id                                      AS p_pos_terminal_id
  ,ta.dat_formdate                                         AS p_dat_formdate
  ,CAST(ta.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(ta.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,ta.checker_id                                           AS p_checker_id
  ,CAST(94 AS SMALLINT)                                    AS scenario_group_id
  ,ta.store_id                                             AS c_store_id
  ,ta.client_id                                            AS c_client_id
  ,ta.pos_terminal_id                                      AS c_pos_terminal_id
  ,ta.dat_formdate                                         AS c_dat_formdate
  ,ta.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,ta.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,ta.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ta.total_value_void                                     AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_adv_1 ta
WHERE is_void_not_authorised = 1
/* AP0182639 Storno Begünstigung ist höchster Einzelwer */
UNION ALL
SELECT
   ta.store_id                                             AS p_store_id
  ,ta.client_id                                            AS p_client_id
  ,ta.pos_terminal_id                                      AS p_pos_terminal_id
  ,ta.dat_formdate                                         AS p_dat_formdate
  ,CAST(ta.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(ta.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,ta.checker_id                                           AS p_checker_id
  ,CAST(95 AS SMALLINT)                                    AS scenario_group_id
  ,ta.store_id                                             AS c_store_id
  ,ta.client_id                                            AS c_client_id
  ,ta.pos_terminal_id                                      AS c_pos_terminal_id
  ,ta.dat_formdate                                         AS c_dat_formdate
  ,ta.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,ta.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,ta.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ta.total_value_void                                     AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_adv_1 ta
WHERE is_highest_val = 1
/* AP0182639 Storno Begünstigung Tabak/ Alkohol */
UNION ALL
SELECT
   ta.store_id                                             AS p_store_id
  ,ta.client_id                                            AS p_client_id
  ,ta.pos_terminal_id                                      AS p_pos_terminal_id
  ,ta.dat_formdate                                         AS p_dat_formdate
  ,CAST(ta.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(ta.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,ta.checker_id                                           AS p_checker_id
  ,CAST(96 AS SMALLINT)                                    AS scenario_group_id
  ,ta.store_id                                             AS c_store_id
  ,ta.client_id                                            AS c_client_id
  ,ta.pos_terminal_id                                      AS c_pos_terminal_id
  ,ta.dat_formdate                                         AS c_dat_formdate
  ,ta.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,ta.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,ta.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,ta.total_value_void                                     AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_void_transaction_adv_1 ta
WHERE is_alk_tab = 1
UNION ALL
/* Section for BBT-398: Bonabbruch + Kleinstbon (97) and Bonabbruch + Abmeldung (98) */
 SELECT
   st6.resumed_trans_store_id_ejr                          AS p_store_id
  ,st6.client_id                                           AS p_client_id
  ,st6.resumed_trans_terminal_id_ejr                       AS p_pos_terminal_id
  ,st6.resumed_trans_date_ejr                              AS p_dat_formdate
  ,CAST(st6.time_receipt_ejr  AS VARCHAR(8))               AS p_time_receipt_ejr
  ,CAST(st6.resumed_trans_receipt_nr_ejr AS VARCHAR(13))   AS p_proof_object_nr_ejr
  ,st6.checker_id                                          AS p_checker_id
  ,CASE WHEN st6.is_next_low_tran_cancelled = 1 THEN CAST(97 AS SMALLINT)
        WHEN st6.is_next_abmeld_cancelled   = 1 THEN CAST(98 AS SMALLINT)
    END                                                    AS scenario_group_id
  ,st6.st_loc_sid                                            AS c_store_id
  ,st6.client_id                                           AS c_client_id
  ,st6.pos_terminal_id                                     AS c_pos_terminal_id
  ,st6.dat_formdate                                        AS c_dat_formdate
  ,st6.time_receipt_ejr                                    AS c_time_receipt_ejr
  ,st6.orig_receipt_nr_ejr                                 AS c_orig_receipt_nr_ejr
  ,st6.checker_id                                          AS c_checker_id
  ,st6.transactiontype_id                                  AS c_transactiontype_id
  ,st6.resumed_trans_seqnr                                 AS resumed_trans_seqnr
  ,CASE WHEN resumed_trans_seqnr = 1 THEN val_susp_retail_ejr
                                     ELSE val_susp_next_retail_ejr
     END                                                    AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_cancelled_transact_1 st6
   WHERE st6.is_resumed_cancelled    = 1
     AND (st6.is_next_low_tran_cancelled = 1
      OR  st6.is_next_abmeld_cancelled   = 1 )
   UNION ALL
   -- Add skipped transactions
  SELECT DISTINCT
   abf.store_id                                          AS p_store_id
  ,abf.client_id                                         AS p_client_id
  ,abf.pos_terminal_id                                   AS p_pos_terminal_id
  ,abf.dat_formdate                                      AS p_dat_formdate
  ,CAST(abf.time_receipt_ejr AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(st.resumed_trans_receipt_nr_ejr AS VARCHAR(13))  AS p_proof_object_nr_ejr
  ,abf.checker_id                                        AS p_checker_id
  ,CASE WHEN st.is_next_low_tran_cancelled = 1 THEN CAST(97 AS SMALLINT)
        WHEN st.is_next_abmeld_cancelled   = 1 THEN CAST(98 AS SMALLINT)
     END                                   AS scenario_group_id            
  ,abf.store_id                                          AS c_store_id
  ,abf.client_id                                         AS c_client_id
  ,abf.pos_terminal_id                                   AS c_pos_terminal_id
  ,abf.dat_formdate                                      AS c_dat_formdate
  ,abf.time_receipt_ejr                                  AS c_time_receipt_ejr
  ,abf.orig_receipt_nr_ejr                               AS c_orig_receipt_nr_ejr
  ,abf.checker_id                                        AS c_checker_id
  ,CAST(abf.transactiontype_id AS CHAR(3))               AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                    AS resumed_trans_seqnr
  ,abf.val_retail_ejr                                    AS val_retail_ejr
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_1 abf
   INNER JOIN p_lew_mart_msi.v_ejr_cancelled_transact_1 st
   ON st.client_id = abf.client_id
   AND st.st_loc_sid = abf.store_id
   AND st.checker_id = abf.checker_id
   AND st.dat_formdate = abf.dat_formdate
  WHERE abf.transactiontype_id IN(400, 405, 420, 425, 430, 480)
  AND st.is_resumed_cancelled    = 1
  AND (st.is_next_low_tran_cancelled = 1 OR st.is_next_abmeld_cancelled   = 1 )
  QUALIFY abf.orig_receipt_nr_ejr > MIN(CASE WHEN st.transactiontype_id IN ('200') THEN st.orig_receipt_nr_ejr ELSE NULL END) OVER ( PARTITION BY st.client_id, st.st_loc_sid, st.checker_id, st.dat_formdate, st.resumed_trans_receipt_nr_ejr)
  -- between the Bonabbruch ...
  AND abf.orig_receipt_nr_ejr < MAX(CASE WHEN st.transactiontype_id IN ('100','101','200','201','410') THEN st.orig_receipt_nr_ejr ELSE NULL END) OVER ( PARTITION BY st.client_id, st.st_loc_sid, st.checker_id, st.dat_formdate, st.resumed_trans_receipt_nr_ejr) 
  -- and Kleinstbon oder Abmeldung
  /* AP0188368 Lidl Plus */
UNION ALL
SELECT
   lp.store_id                                             AS p_store_id
  ,lp.client_id                                            AS p_client_id
  ,lp.pos_terminal_id                                      AS p_pos_terminal_id
  ,lp.dat_formdate                                         AS p_dat_formdate
  ,CAST(lp.time_receipt_ejr    AS VARCHAR(8))              AS p_time_receipt_ejr
  ,CAST(lp.orig_receipt_nr_ejr AS VARCHAR(13))             AS p_proof_object_nr_ejr
  ,lp.checker_id                                           AS p_checker_id
  ,CAST(99 AS SMALLINT)                                    AS scenario_group_id
  ,lp.store_id                                             AS c_store_id
  ,lp.client_id                                            AS c_client_id
  ,lp.pos_terminal_id                                      AS c_pos_terminal_id
  ,lp.dat_formdate                                         AS c_dat_formdate
  ,lp.time_receipt_ejr                                     AS c_time_receipt_ejr
  ,lp.orig_receipt_nr_ejr                                  AS c_orig_receipt_nr_ejr
  ,lp.checker_id                                           AS c_checker_id
  ,CAST('100' AS CHAR(3))                                  AS c_transaction_type_id
  ,CAST(1 AS BYTEINT)                                      AS resumed_trans_seqnr
  ,CAST(0 AS DECIMAL(18,4))                                AS val_retail_ejr
 FROM P_LEW_MART_MSI.v_ejr_lidlplus_1 lp
   ) tr
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 revstr
   ON tr.c_store_id     = revstr.store_id
   AND tr.c_client_id   = revstr.client_id
   AND tr.c_dat_formdate BETWEEN revstr.dat_formdate_from AND revstr.dat_formdate_until
;