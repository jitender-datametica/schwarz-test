CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_PAYMENT_NTR_1 as
         /*	
         #DescStart#	
         #$Revision: 8128 $, $LastChangedBy: hwieber $	
         #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
         #DescEnd#	
         */	
         SELECT	
            loc_sid                    AS store_id,	
         client_id                  AS client_id,	
         register_id                AS pos_terminal_id,	
         dwh_cal_dt                 AS dat_formdate,	
         Cast(SUBSTRING(Cast(Cast(receipt_tmsp AS TIME(6)) AS VARCHAR(30)), 1, 8) AS TIME(0)) AS time_receipt_ejr,	
         receipt_id                 AS orig_receipt_nr_ejr,	
         receiptline_nr             AS orig_receipt_serial_nr_ejr,	
         timezone_id                AS timezone_cd,	
         receipt_dt                 AS dat_dayend,	
         cashier_id                 AS checker_id,	
         transaction_type_cd        AS transactiontype_id,	
         payment_fg                 AS cnt_payment_ejr,	
         payment_val                AS val_retail_payment_ejr,	
         tendertype_ejr_cd          AS tendertype_cd_ejr	
         FROM p_lew_core_ac.v_pos_ctrl_payment_1	
	
         WHERE turnover_relevant_fg = 0 -- Not Turnover Relevant	
         ;