/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_EJR_VOID_TRANSACTION_ADV_2
#----------------------------------------------------------------------------
# History:
#  1.0  11.01.2024    Szewczyk,Milosz            AP0182639 - New scenario Storno Beguenstigung
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_EJR_VOID_TRANSACTION_ADV_2
         (	
             client_id	
             , store_id	
             , pos_terminal_id	
             , time_receipt_ejr	
             , dat_formdate	
             , orig_receipt_nr_ejr	
             , wh_id	
             , checker_id	
             , is_voided_after_subtotal	
             , cnt_void_after_subtotal	
             , is_voided_item_innext
             , total_value_void 
             , is_pay_exact 
             , is_subtotal_bef_storno 
             , is_void_not_authorised
             , is_highest_val
             , is_alk_tab
			 , is_voided_value_aft_subtotal_2
			 , is_1_itm_2
			 , is_outside_hours
			 , is_man_discount
			 , cnt_void_ejr
			 , is_man_discount_item
         )	
         AS	
            SELECT	
             client_id	
             , store_id	
             , pos_terminal_id	
             , time_receipt_ejr	
             , dat_formdate	
             , orig_receipt_nr_ejr	
             , wh_id	
             , checker_id	
             , is_voided_after_subtotal	
             , cnt_void_after_subtotal	
             , is_voided_item_innext
             , total_value_void 
             , is_pay_exact 
             , is_subtotal_bef_storno 
             , is_void_not_authorised
             , is_highest_val
             , is_alk_tab
			 , is_voided_value_aft_subtotal_2
			 , is_1_itm_2
			 , is_outside_hours
			 , is_man_discount
			 , cnt_void_ejr
			 , is_man_discount_item
            FROM p_lew_mart_msi.V_EJR_VOID_TRANSACTION_ADV_2	
;