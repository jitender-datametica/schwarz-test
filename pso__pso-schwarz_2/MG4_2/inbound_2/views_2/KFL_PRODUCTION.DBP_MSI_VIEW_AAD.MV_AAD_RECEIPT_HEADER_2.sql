create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_AAD_RECEIPT_HEADER_2(
	BON_ID,
	BON_DAT,
	WUP_ID,
	MANDANT_ID,
	BON_NR,
	KASSE_NR,
	KASSIERER_NR,
	WRG_ID,
	BON_BOOKING,
	SCANNED_EMPTIES_PAYM_GROSS_LOCAL_VAL,
	MANUAL_EMPTIES_PAYM_GROSS_LOCAL_VAL,
	EC_PAYM_GROSS_LOCAL_VAL,
	CASH_PAYM_GROSS_LOCAL_VAL,
	GIFTCARD_PAYM_GROSS_LOCAL_VAL,
	LOGIN_CHECKOUT_FG,
	LOGOUT_CHECKOUT_FG,
	LAST_SALES_POS_ID,
	CANCELLATION_AMOUNT_GROSS_LOCAL_VAL,
	CANCELLATION_POS_FG,
	CANCEL_FG,
	CANCELLED_ITEM_CNT,
	PREVIOUS_BON_NR,
	NEXT_BON_NR,
	SCHLIESSEN_KASSENSCHUBLADE,
	TRAINING_FG,
	ITEM_REDUCTION_AMOUNT_GROSS_LOCAL_VAL,
	ITEM_REDUCTION_MIN_PCT_VAL,
	MANUAL_DEBIT_INVOICE_FG,
	BARCODE_EMPTY_FG,
	LAST_CANCELLED_POS_ID,
	LAST_SOLD_POS_ID,
	RECLAMATION_FG,
	ARTICLE_WITHOUT_SHOP_BAG_CNT,
	SHOP_BAG_IN_RECEIPT_CNT,
	SUSPENDED_FG,
	DOUBLE_ENTRY_FG,
	WRONG_PLU_FG,
	QUANTITY_ERROR_FG,
	PRICE_ERROR_FG,
	SUSPENDED_BON_NR,
	CANCELLATION_AFTER_SUMBUTTON_SEC,
	GIFT_LIFETIME_MIN,
	IDENTICAL_ITEM_CNT,
	STORNO_POS_CNT,
	ALL_ITEM_CNT,
	ASC_RECEIPT_ROW_NR,
	DESC_RECEIPT_ROW_NR,
	CNT_ZEILE_HDR
) as





	SELECT 
      v01.bon_id
    , v01.bon_dat
    , v02.aktuell_wup_id AS wup_id
    , v01.mandant_id
    , v01.bon_nr
    , v01.kasse_nr
    , v01.kassierer_nr
    , v01.wrg_id
    , v01.bon_booking
    , v01.scanned_empties_paym_gross_local_val
    , v01.manual_empties_paym_gross_local_val
    , v01.ec_paym_gross_local_val
    , v01.cash_paym_gross_local_val
    , v01.giftcard_paym_gross_local_val
    , v01.login_checkout_fg
    , v01.logout_checkout_fg
    , v01.last_sales_pos_id
    , v01.cancellation_amount_gross_local_val
    , v01.cancellation_pos_fg
    , v01.cancel_fg
    , v01.cancelled_item_cnt
    , v01.previous_bon_nr
    , v01.next_bon_nr
    , v01.schliessen_kassenschublade
    , v01.training_fg
    , v01.item_reduction_amount_gross_local_val
    , v01.item_reduction_min_pct_val
    , v01.manual_debit_invoice_fg
    , v01.barcode_empty_fg
    , v01.last_cancelled_pos_id
    , v01.last_sold_pos_id
    , v01.reclamation_fg
    , v01.article_without_shop_bag_cnt
    , v01.shop_bag_in_receipt_cnt
    , v01.suspended_fg
    , v01.double_entry_fg
    , v01.wrong_plu_fg
    , v01.quantity_error_fg
    , v01.price_error_fg
    , v01.suspended_bon_nr
    , v01.cancellation_after_sumbutton_sec
    , v01.gift_lifetime_min
    , v01.identical_item_cnt
    , v01.storno_pos_cnt
    , v01.all_item_cnt
    , v01.ASC_RECEIPT_ROW_NR
    , v01.DESC_RECEIPT_ROW_NR
	, '1' AS CNT_ZEILE_HDR
FROM DBP_VIEW.V_AAD_RECEIPT_HEADER_2 v01

INNER JOIN dbp_view.v_wup_2 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;