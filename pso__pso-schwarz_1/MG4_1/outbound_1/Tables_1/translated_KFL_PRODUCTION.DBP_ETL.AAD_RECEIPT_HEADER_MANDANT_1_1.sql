CREATE OR REPLACE TABLE kfl_production_dbp_etl.aad_receipt_header_mandant_1_1 (
bon_id STRING(100) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'),
bon_nr INTEGER
OPTIONS(description='Die Bonnummer des Bons (ist eine_1 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_1 und Kasse unique).'),
kasse_nr INTEGER OPTIONS(description='Nummer der Kasse.'),
kassierer_nr STRING(4) OPTIONS(description='Nummer des Kassierers.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
bon_booking DATETIME
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_1 Kasse offline war.'),
scanned_empties_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='Amount of the scanned empties'),
manual_empties_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='Amount of the manually entered empties'),
ec_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='receipt total with EC payment method'),
cash_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='receipt total with cash payment method'),
giftcard_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='receipt total with gift card payment method'),
login_checkout_fg INTEGER OPTIONS(description='Indicates whether a cashier has logged on to the cash register'),
logout_checkout_fg INTEGER OPTIONS(description='Indicates whether a cashier has logged out from the cash register'),
last_sales_pos_id INTEGER OPTIONS(description='Indicates the last receipt line of a receipt'),
cancellation_amount_gross_local_val NUMERIC(18,4) OPTIONS(description='Indicates the cancelled amount'),
cancellation_pos_fg INTEGER OPTIONS(description='Indicates whether an item_1 has been cancelled on the receipt'),
cancel_fg INTEGER OPTIONS(description='Das Flag kennzeichnet einen Abbruchvorgang'),
cancelled_item_cnt INTEGER OPTIONS(description='cancelled_item_cnt'),
previous_bon_nr INTEGER OPTIONS(description='Indicates the previous receipt number'),
next_bon_nr INTEGER OPTIONS(description='Indicates the successor receipt number'),
schliessen_kassenschublade DATETIME
OPTIONS(description='Zeitstempel wird an der Kasse erzeugt, wenn die Kassenlade geschlossen wird.'),
training_fg INTEGER
OPTIONS(description='Das Flag kennzeichnet, ob die Transaktion im Trainings-Modus durchgefuehrt wurde.'),
item_reduction_amount_gross_local_val NUMERIC(18,4) OPTIONS(description='Indicates the reduced article value'),
item_reduction_min_pct_val NUMERIC(18,4) OPTIONS(description='Indicates if an article is reduced more than 50%'),
manual_debit_invoice_fg INTEGER OPTIONS(description='Indicates whether the Payment type is manual direct debit'),
barcode_empty_fg INTEGER OPTIONS(description='Indicates whether the receipt contains a barcode empty'),
last_cancelled_pos_id INTEGER OPTIONS(description='Indicates the last cancelled line of a receipt'),
last_sold_pos_id INTEGER OPTIONS(description='Indicates the last line of a receipt where an item_1 was purchased'),
reclamation_fg INTEGER DEFAULT 0 OPTIONS(description='Indicates when a receipt contains a reclamation'),
cancel_max_value_fg INTEGER DEFAULT 0 OPTIONS(description='Indicates when a receipt contains a reclamation'),
article_without_shop_bag_cnt INTEGER
OPTIONS(description='Indicates the number of items, excluding shopping bags within a receipt'),
shop_bag_in_receipt_cnt INTEGER OPTIONS(description='Indicates the number of shopping bags in a receipt'),
suspended_fg INTEGER OPTIONS(description='Flag: Kennzeichnung des Suspended-Status_1 der Transaktion. 1 = suspended'),
double_entry_fg INTEGER DEFAULT 0 OPTIONS(description='Indicates whether the receipt contains a double entry'),
wrong_plu_fg INTEGER DEFAULT 0 OPTIONS(description='Indicates if a receipt has been cancelled due to a PLU error'),
quantity_error_fg INTEGER DEFAULT 0
OPTIONS(description='Indicates if a receipt has been cancelled due to a quantity error'),
price_error_fg INTEGER DEFAULT 0 OPTIONS(description='Indicates if a receipt has been cancelled due to a price error'),
suspended_bon_nr INTEGER OPTIONS(description='Die Nummer des ausgesetzten Belegs'),
cancellation_after_sumbutton_sec INTEGER
OPTIONS(description='Time Difference in second between Sum Button pressed and cancellation'),
gift_lifetime_min INTEGER
OPTIONS(description='Time Difference in Minute between activation and redemption of gift card'),
identical_item_cnt INTEGER OPTIONS(description='Indicates the number of identical items'),
storno_pos_cnt INTEGER OPTIONS(description='Indicates the number of storno positions in a receipt'),
all_item_cnt INTEGER OPTIONS(description='Indicates the number of item_1 in a receipt'),
asc_receipt_row_nr INTEGER
OPTIONS(description='position number of the Receipt in ascending order of booking time within a defined partition'),
desc_receipt_row_nr INTEGER
OPTIONS(description='position number of the Receipt  in descending order of booking time within a defined partition'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id) NOT ENFORCED
) OPTIONS(description=' Contains aggregated receipt data for the implementation of the fraud detection scenarios');