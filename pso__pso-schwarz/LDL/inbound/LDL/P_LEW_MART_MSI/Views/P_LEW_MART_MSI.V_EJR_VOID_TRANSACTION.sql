/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_EJR_VOID_TRANSACTION
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  10.01.2018    Michael Ueding           Lkp Key Map fuer wh_id
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY mit V_WAREHOUSE ersetzt
#  1.5  24.05.2021    Wandtke,Andrzej          AP0056037 20210428_2816_ZKP_Void_Tran: Add columns total_value_void, is_pay_exact, is_subtotal_bef_storno, is_void_not_authorised, is_highest_val, is_alk_tab, is_1_itm
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_VOID_TRANSACTION
         (	
             client_id	
             , store_id	
             , pos_terminal_id	
             , time_receipt_ejr	
             , dat_formdate	
             , orig_receipt_nr_ejr	
             , wh_id	
             , checker_id	
             , last_void_line_nr	
             , is_voided_after_subtotal	
             , cnt_void_after_subtotal	
             , is_sale_after_subtotal	
             , last_subtotal_line	
             , voided_value_aft_subtotal	
             , is_voided_value_aft_subtotal	
             , is_voided_item_innext
             , total_value_void 
             , is_pay_exact 
             , is_subtotal_bef_storno 
             , is_void_not_authorised
             , is_highest_val
             , is_alk_tab
             , is_1_itm
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
            ,ow.last_void_line_nr
            ,ow.is_voided_after_subtotal
            ,ow.cnt_void_after_subtotal
            ,ow.is_sale_after_subtotal
            ,ow.last_subtotal_line
            ,ow.voided_value_aft_subtotal
            ,ow.is_voided_value_aft_subtotal
            ,ow.is_voided_item_innext
            ,ow.total_value_void
            ,ow.is_pay_exact
            ,ow.is_subtotal_bef_storno
            ,ow.is_void_not_authorised
            ,ow.is_highest_val
            ,ow.is_alk_tab
            ,ow.is_1_itm
            FROM p_lew_mart_msi.t_msi_ejr_void_transaction ow	
            INNER JOIN p_lew_bil_ac.v_warehouse AS wh	
            ON wh.client_id = ow.client_id	
            AND wh.loc_sid_wh = ow.wh_loc_sid	
           AND wh.dwh_actual_fg = 1	
;