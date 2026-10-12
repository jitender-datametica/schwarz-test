CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_CNTR_TRANSACT as
   SELECT	
      loc_sid                    AS store_id,	
   client_id                  AS client_id,	
   register_id                AS pos_terminal_id,	
   dwh_cal_dt                 AS dat_formdate,	
   Cast(SUBSTRING(Cast(Cast(receipt_tmsp AS TIME(6)) AS VARCHAR(30)), 1, 8) AS TIME(0)) AS time_receipt_ejr,	
   receipt_id                 AS orig_receipt_nr_ejr,	
   timezone_id                AS timezone_cd,	
   receipt_dt                 AS dat_dayend,	
   cashier_id                 AS checker_id,	
   transaction_type_cd        AS transactiontype_id,	
   Cast(SUBSTRING(Cast(transaction_begin_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP) AS timestamp_begin_ejr,	
   Cast(SUBSTRING(Cast(transaction_end_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP) AS timestamp_end_ejr,	
   transaction_type_detail_id AS trans_detail_type_id,	
   authority_cd               AS authority_id,	
   dwh_load_id                AS load_id	
   FROM p_lew_core_ac.v_pos_ctrl_register_transaction	
;