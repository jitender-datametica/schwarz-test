/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_VOID_TRANSACTION_ADV_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.01.2024    Szewczyk, Milosz        AP0182639
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_VOID_TRANSACTION_ADV_1
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
             ow.client_id
            ,ow.st_loc_sid AS store_id
            ,ow.pos_terminal_id
            ,time_receipt_ejr
            ,ow.dat_formdate
            ,ow.orig_receipt_nr_ejr
            ,wh.src_wh_id AS wh_id
            ,ow.checker_id
            ,ow.is_voided_after_subtotal
            ,ow.cnt_void_after_subtotal
            ,ow.is_voided_item_innext
            ,ow.total_value_void
            ,ow.is_pay_exact
            ,ow.is_subtotal_bef_storno
            ,ow.is_void_not_authorised
            ,ow.is_highest_val
            ,ow.is_alk_tab
			,ow.is_voided_value_aft_subtotal_2
			,ow.is_1_itm_2
			,ow.is_outside_hours
			,ow.is_man_discount
			,ow.cnt_void_ejr
			,ow.is_man_discount_item
            FROM p_lew_mart_msi.t_msi_ejr_void_transaction_adv_1 ow	
            INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh	
            ON wh.client_id = ow.client_id	
            AND wh.src_wh_id = ow.wh_loc_sid	
           AND wh.dwh_actual_fg = 1	
;