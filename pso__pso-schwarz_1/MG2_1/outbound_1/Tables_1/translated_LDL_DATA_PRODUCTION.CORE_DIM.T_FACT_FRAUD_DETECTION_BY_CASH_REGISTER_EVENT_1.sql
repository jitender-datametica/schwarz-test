DROP TABLE IF EXISTS ldl_data_production_core_dim.t_fact_fraud_detection_by_cash_register_event_1;
CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_fact_fraud_detection_by_cash_register_event_1 (
cash_register_event_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related cash register event. Depending on the scenario, it references a retail event, a price lookup event or a technical cash register event.'),
cash_register_event_nr STRING(20) NOT NULL
OPTIONS(description='The sequence number of the cash register transaction. It is unique to the cash register, but might be re_1-cycled after some time.'),
event_start_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when the cash register event started.'),
bus_dt DATE NOT NULL OPTIONS(description='The business date on which the cash register event is counted.'),
cash_register_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the cash register which has created this transaction.'),
cash_register_nr STRING(20) NOT NULL
OPTIONS(description='The identifier (natural key) for the cash register which has created this transaction.'),
store_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the store where the related cash register event happened.'),
cashier_hash STRING(32) NOT NULL
OPTIONS(description='The encrypted number of the cashier. (The hash is unique for a given store and a day.)'),
txn_net_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The total net amount of the cash register transaction. (amount in the currency defined by the currency code)'),
txn_gross_val NUMERIC(29,5) NOT NULL
OPTIONS(description='The total gross amount of the cash register transaction. (amount in the currency defined by the currency code)'),
cancel_in_favour_gross_val NUMERIC(29,5)
OPTIONS(description='The total gross amount of those lines in this retail event, which have been cancelled and which qualify as the fraud scenario of friendly cancellations.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The code identifying the currency, according to ISO 4217.'),
cancel_in_favour_line_cnt INTEGER
OPTIONS(description='The number of those lines in this retail event which have been cancelled and which qualify as the fraud scenario of friendly cancellations.'),
cancel_last_pos_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the last position in this retail event was cancelled.'),
cancel_last_pos_alcohol_tobacco_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the last position in this retail event was for an alcohol or tobacco product and if this position was cancelled. This flag is a specialization of the scenario expressed by the cancel_last_pos_fg.'),
cancel_last_pos_exact_paym_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the last position in this retail event was cancelled and if the customer paid with the exact amount, so that no change was given. This flag is a specialization of the scenario expressed by the cancel_last_pos_fg.'),
cancel_last_pos_after_subtotal_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the last position in this retail event was cancelled after a subtotal amount was shown. This flag is a specialization of the scenario expressed by the cancel_last_pos_fg.'),
cancel_last_pos_highest_pos_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the last position in this retail event was cancelled and if this position was the one with the highest gross amount on the entire receipt.'),
cancel_last_pos_outside_opening_hr_fg BOOL
OPTIONS(description='An indicator showing, if the last position in this retail event was cancelled and if the receipt was created outside the official opening hours of the store.'),
cancel_last_and_other_pos_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the last several positions in this retail event were cancelled, including the last position.'),
cancel_in_favour_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this retail event classifies as the fraud scenario of friendly cancellations. (The cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt.)'),
cancel_in_favour_alcohol_tobacco_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this retail event contained at least one alcohol or tobacco product and if it classifies as the fraud scenario of a friendly cancellation. (The cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt .) This flag is a specialization of the scenario expressed by the cancel_in_favour_fg.'),
cancel_in_favour_exact_paym_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this retail event classifies as the fraud scenario of friendly cancellations and if the customer paid with the exact amount, so that no change was given. (A friendly cancellation means that the cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt.) This flag is a specialization of the scenario expressed by the cancel_in_favour_fg.'),
cancel_in_favour_after_subtotal_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this retail event classifies as the fraud scenario of friendly cancellations and if the cancellation happened after a subtotal amount was shown. (A friendly cancellation means that the cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt.) This flag is a specialization of the scenario expressed by the cancel_in_favour_fg.'),
cancel_in_favour_outside_opening_hr_fg BOOL
OPTIONS(description='An indicator showing, if this retail event classifies as the fraud scenario of friendly cancellations and if the transaction happened outside the regular opening hours of the store. (A friendly cancellation means that the cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt.) This flag is a specialization of the scenario expressed by the cancel_in_favour_fg.'),
cancel_in_favour_manual_discount_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this retail event classifies as the fraud scenario of friendly cancellations and if the retail event included a discount which was manually applied. (A friendly cancellation means that the cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt.) This flag is a specialization of the scenario expressed by the cancel_in_favour_fg.'),
cancel_in_favour_without_auth_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this retail event classifies as the fraud scenario of friendly cancellations and if the cancellation did not require an authorization. (A friendly cancellation means that the cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt.) This flag is a specialization of the scenario expressed by the cancel_in_favour_fg.'),
cancel_in_favour_highest_pos_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this retail event classifies as the fraud scenario of friendly cancellations and if the cancellation was for the position with the highest amount on the receipt. (A friendly cancellation means that the cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt.) This flag is a specialization of the scenario expressed by the cancel_in_favour_fg.'),
return_at_higher_than_sales_price_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a return line for a product that was returned at a higher price than it was bought.'),
return_at_higher_than_official_price_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a return line for a product that was returned without the original receipt and at a price that was higher than its (maximum) official sales_1 price.'),
return_same_prod_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a return line for a product  which has already been returned a at least once in the same week and at the same cashier. Textiles (sub item_1 groups 100, 101, 102, 105 and 106)  are not considered in this scenario.'),
return_mult_prod_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained returns of at least two products which have all been sold on the same original receipt.'),
return_mult_prod_full_qty_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained returns of at least two products which have all been sold on the same original receipt and then all quantities of all products are returned in the same return event.'),
return_same_receipt_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained returns for a receipt that has already been used for returns at least once in the past.'),
return_same_receipt_full_qty_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained returns for a receipt that has already been used for returns at least once in the past and if all products on this original sales_1 receipt have been returned in their full quantities in this retail event. (The receipt contains more than one item.)'),
return_same_receipt_same_cashier_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained returns for a receipt that has already been used for returns at least once in the past and if these return attemps happened with the same cashier who originally issued the receipt.'),
return_without_receipt_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a return without the original receipt. I.e. there was no receipt number or the receipt number could not be found.'),
return_without_receipt_ke_input_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a return without the original receipt. I.e. there was no receipt number or the receipt number could not be found. The returned product is manually entered (using input method type = KE.'),
return_without_receipt_dv_input_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a return without the original receipt. I.e. there was no receipt number or the receipt number could not be found. The returned product is manually entered (using input method type = DV.'),
return_not_on_receipt_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a return with an incorrect original receipt. I.e. the receipt number could be found, however the returned item_1 was not present on this receipt.'),
return_qty_invalid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a return of a product with higher quantity than shown on the original receipt.'),
return_without_auth_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a return that was not authorized. The retail event must also meet all of the following conditions. (1) There is more than one return on the receipt. (2) None of the returned products is on the following receipt. (3) The return amount is not identical to the amount of the following receipt. (4) If the following receipt contains only one product, this must be different from the products on the original receipt.'),
return_same_cashier_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained the return of a product that was bought at the same cashier.'),
return_same_cashier_diff_day_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained the return of a product that was bought at the same cashier, but on a different day.'),
return_same_cashier_and_day_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained the return of a product that was bought on the same day and at the same cashier.'),
return_same_cashier_and_day_card_paym_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained the return of a product that was bought on the same day and at the same cashier, and the refund was made to a card of the client.'),
return_same_cashier_and_day_cash_paym_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained the return of a product that was bought on the same day and at the same cashier, and the refund was made in cash.'),
return_same_cashier_and_day_without_auth_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained the return of a product that was bought on the same day and at the same cashier, and the return did not require authorization.'),
return_same_cashier_and_day_manual_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained the return of a product that was bought on the same day and at the same cashier, and the code of the returned item_1 was entered manually in the system. (Only prod_entry_method_cd = <KE>, by business requirement type <D>, which also represent manual entry, does not count.)'),
return_same_cashier_and_day_display_sel_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained the return of a product that was bought on the same day and at the same cashier and the product was selected from a list on the display of the cash register. (product entry method LS)'),
deposit_and_one_prod_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained a deposit return and exactly one additional sales_1 item.'),
deposit_only_manual_input_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event only contained a deposit return (and no other sales_1 lines) and if this deposit return was manually entered.'),
deposit_same_ean_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the same deposit receipt was scanned multiple times. (The receipt is identified by its EAN.)'),
price_info_mult_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if there were multiple (i.e. at least two) price information events in a row.'),
price_info_and_small_sale_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if a price information event was followed by a small sales_1 transaction.'),
price_info_and_logoff_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if a price information event was followed by a logoff from the cash register.'),
suspend_and_abort_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event was first suspended and subsequently aborted.'),
suspend_and_line_cancel_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event was first suspended and some lines were subsequently cancelled.'),
suspend_and_extend_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event was first suspended and subsequently extended by some more products.'),
suspend_unresolved_and_sale_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event was suspended and has never been resolved. The suspended transaction was followed by a sales_1 transaction.'),
suspend_unresolved_and_logoff_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail was suspended and never resolved. The cashier logged off right after suspending the transaction.'),
abort_and_sale_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event was aborted and if it was followed by a sales_1 transaction.'),
abort_and_logoff_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event was aborted and the cashier logged off right afterwards.'),
small_sale_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the retail event contained only one product and if the total value is less than a pre-defined threshold (e.g. 20c).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
cust_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer.'),
cust_ident_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the way how the customer identifies himself in the store, e.g. by his loyalty card.'),
cancel_in_favour_lidl_plus_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if this retail event classifies as the fraud scenario of friendly cancellations and if the customer used loyalty card, like Lidl Plus. A friendly cancellation means that the cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt.'),
event_end_tmsp TIMESTAMP OPTIONS(description='The point in time when the retail event ended.'),
cancel_last_pos_without_auth_fg BOOL
OPTIONS(description='An indicator showing, if the last position in this retail event was cancelled and if this cancellation happened without an authorization.'),
cancel_last_pos_single_pos_fg BOOL
OPTIONS(description='An indicator showing, if the last position in this retail event was cancelled and the receipt has only one retail line.'),
cancel_in_favour_single_pos_fg BOOL
OPTIONS(description='An indicator showing, if this retail event classifies as the fraud scenario of friendly cancellations and the receipt has only one retail line. (A friendly cancellation means that the cashier cancels certain expensive positions on the receipt, so that an accomplice gets them for free. In order to qualify, a minimum number of lines must be cancelled on the receipt.) This flag is a specialization of the scenario expressed by the cancel_in_favour_fg.'),
cancel_last_pos_gross_val NUMERIC(29,5)
OPTIONS(description='The total gross amount of those lines in this retail event, which have been cancelled as the last n positions on the receipt.'),
cancel_last_pos_line_cnt INTEGER
OPTIONS(description='The number of those lines in this retail event which have been cancelled as the last n positions on the receipt.'),
return_mult_prod_same_cashier_fg BOOL
OPTIONS(description='An indicator showing, if the retail event contained returns of at least two products which have all been sold on the same original receipt and the return and the original purchase have been made with the same cashier,'),
deposit_same_ean_gross_val NUMERIC(29,5)
OPTIONS(description='The total gross amount of those lines which qualify as the fraud scenario of a deposit return with the same EAN_1 (deposit_same_ean_fg). I.e. the same deposit receipt was scanned multiple times. (The receipt is identified by its EAN.) The scenario can span multiple receipts.'),
deposit_same_ean_line_cnt INTEGER
OPTIONS(description='The number of those lines which qualify as the fraud scenario of a deposit return with the same EAN_1 (deposit_same_ean_fg). I.e. the same deposit receipt was scanned multiple times. (The receipt is identified by its EAN.) The scenario can span multiple receipts.'),
event_outside_exact_opening_hr_fg BOOL
OPTIONS(description='An indicator showing, if the retail event took place outside the official opening hours of the store. (The exact opening and closing times are taken as criteria. No buffer time is taken into consideration.)'),
receipt_outside_opening_hr_fg BOOL
OPTIONS(description='An indicator showing, if the receipt was generated outside the official opening hours of the store. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'),
receipt_outside_opening_hr_cancel_fg BOOL
OPTIONS(description='An indicator showing, if the receipt was generated outside the official opening hours of the store and if it contained at least one position which was cancelled. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'),
receipt_outside_opening_hr_return_fg BOOL
OPTIONS(description='An indicator showing, if the receipt was generated outside the official opening hours of the store and if it contained at least one return position. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'),
receipt_outside_opening_hr_suspend_fg BOOL
OPTIONS(description='An indicator showing, if the receipt was generated outside the official opening hours of the store and if it was suspended. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'),
receipt_outside_opening_hr_abort_fg BOOL
OPTIONS(description='An indicator showing, if the receipt was generated outside the official opening hours of the store and if it was aborted. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'),
receipt_outside_opening_hr_deposit_only_fg BOOL
OPTIONS(description='An indicator showing, if the receipt was generated outside the official opening hours of the store and if it contained only deposit lines. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'),
receipt_outside_opening_hr_manual_deposit_fg BOOL
OPTIONS(description='An indicator showing, if the receipt was generated outside the official opening hours of the store and if it contained deposits which were manually entered. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'),
receipt_outside_opening_hr_manual_discount_fg BOOL
OPTIONS(description='An indicator showing, if the receipt was generated outside the official opening hours of the store and if it contained discounts which were manually entered. (A buffer of a few minutes before the opening time and after the closing time is allowed.)'),
deposit_same_val_man_fg BOOL
OPTIONS(description='An indicator showing, if the retail event contained a manual deposit return and is coupled with a following scanned deposit return'),
deposit_same_val_scan_fg BOOL
OPTIONS(description='An indicator showing, if the retail event is a scanned deposit return and is coupled with a preceding manual deposit return'),
PRIMARY KEY (cash_register_event_sid) NOT ENFORCED
) CLUSTER BY bus_dt
OPTIONS(description='A transactional fact holding those cash register events which have been classified as potential fraud. (This includes mostly retail events, i.e. sales_1 and returns, but also price information events and technical cash register events, such as logon and logoff.)');