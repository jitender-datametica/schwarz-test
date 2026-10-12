/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI_AC.V_REF_EJR_LP_RECEIPT_PRINT_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.6  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.7  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.8  25.04.2018    Wieber.Harald            Update Release 3.5
#  1.9  03.05.2018    Wieber.Harald            Release 3.6
# 1.10  17.05.2018    Wieber,Harald            Update Release 3.8
# 1.11  06.04.2023    Wandtke,Andrzej          AP0152808 : Add column no_original_receipt_text
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_EJR_LP_RECEIPT_PRINT_2
(
client_id
, language_id
, price_text
, cash_desk_text
, total_text
, vatp_text
, netto_text
, amount_text
, rr_text
, r_text
, text_text
, brutto_text
, vat_text
, receipt_text
, product_text
, receipt_value_text
, tender_text
, wawi_text
, return_reason_text
, approver_text
, store_text
, date_text
, original_receipt_text
, no_original_receipt_text
 )
AS
   SELECT
     client_id
    ,language_id
    ,price_text
    ,cash_desk_text
    ,total_text
    ,vatp_text
    ,netto_text
    ,amount_text
    ,rr_text
    ,r_text
    ,text_text
    ,brutto_text
    ,vat_text
    ,receipt_text
    ,product_text
    ,receipt_value_text
    ,tender_text
    ,wawi_text
    ,return_reason_text
    ,approver_text
    ,store_text
    ,date_text
    ,original_receipt_text
    ,no_original_receipt_text   
   FROM p_lew_mart_msi.v_ref_ejr_lp_receipt_print_2;