--==============================================================
-- Table: aad_receipt_header_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_receipt_header_1
   generated from Powerdesigner on Mittwoch, 26. Juli 2023 11:39:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_receipt_header_1 (
bon_id STRING(100) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
bon_dat DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'),
bon_nr BIGNUMERIC(38,0)
OPTIONS(description='Die Bonnummer des Bons (ist eine_1 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_1 und Kasse unique).'),
kasse_nr BIGNUMERIC(38,0) OPTIONS(description='Nummer der Kasse.'),
kassierer_nr STRING(4) OPTIONS(description='Nummer des Kassierers.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
bon_booking DATETIME
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_1 Kasse offline war.'),
bon_storno_fg BIGNUMERIC(38,0)
OPTIONS(description='Das Flag kennzeichnet, ob die Bon storniert würde order nicht  (1 wenn Storniert, 0 wenn nicht). Es ist wenn die Bon an der Info-Kasse zurückgegeben wird bzw. Retourniert wird (kann sowohl ein Verkaufsbon sein als auch eine_1 Retoure), und die werden wiederum in Storno Tabelle (ods_bon_storno_1) abgespeichert.'),
scanned_empties_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='Amount of the scanned empties'),
manual_empties_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='Amount of the manually entered empties'),
ec_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='receipt total with EC payment method'),
cash_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='receipt total with cash payment method'),
giftcard_paym_gross_local_val NUMERIC(18,4) OPTIONS(description='receipt total with gift card payment method'),
login_checkout_fg BIGNUMERIC(38,0) OPTIONS(description='Indicates whether a cashier has logged on to the cash register'),
logout_checkout_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicates whether a cashier has logged out from the cash register'),
last_sales_pos_id BIGNUMERIC(38,0) OPTIONS(description='Indicates the last receipt line of a receipt'),
cancellation_amount_gross_local_val NUMERIC(18,4) OPTIONS(description='Indicates the cancelled amount'),
cancellation_pos_fg BIGNUMERIC(38,0) OPTIONS(description='Indicates whether an item_1 has been cancelled on the receipt'),
cancel_fg BIGNUMERIC(38,0) OPTIONS(description='Das Flag kennzeichnet einen Abbruchvorgang'),
cancelled_item_cnt BIGNUMERIC(38,0) OPTIONS(description='cancelled_item_cnt'),
previous_bon_nr BIGNUMERIC(38,0) OPTIONS(description='Indicates the previous receipt number'),
next_bon_nr BIGNUMERIC(38,0) OPTIONS(description='Indicates the successor receipt number'),
schliessen_kassenschublade DATETIME
OPTIONS(description='Zeitstempel wird an der Kasse erzeugt, wenn die Kassenlade geschlossen wird.'),
training_fg BIGNUMERIC(38,0)
OPTIONS(description='Das Flag kennzeichnet, ob die Transaktion im Trainings-Modus durchgefuehrt wurde.'),
item_reduction_amount_gross_local_val NUMERIC(18,4) OPTIONS(description='Indicates the reduced article value'),
item_reduction_min_pct_val NUMERIC(18,4) OPTIONS(description='Indicates if an article is reduced more than 50%'),
manual_debit_invoice_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicates whether the Payment type is manual direct debit'),
barcode_empty_fg BIGNUMERIC(38,0) OPTIONS(description='Indicates whether the receipt contains a barcode empty'),
last_cancelled_pos_id BIGNUMERIC(38,0) OPTIONS(description='Indicates the last cancelled line of a receipt'),
last_sold_pos_id BIGNUMERIC(38,0)
OPTIONS(description='Indicates the last line of a receipt where an item_1 was purchased'),
reclamation_fg BIGNUMERIC(38,0) OPTIONS(description='Indicates when a receipt contains a reclamation'),
article_without_shop_bag_cnt BIGNUMERIC(38,0)
OPTIONS(description='Indicates the number of items, excluding shopping bags within a receipt'),
shop_bag_in_receipt_cnt BIGNUMERIC(38,0) OPTIONS(description='Indicates the number of shopping bags in a receipt'),
suspended_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Kennzeichnung des Suspended-Status_1 der Transaktion. 1 = suspended'),
double_entry_fg BIGNUMERIC(38,0) OPTIONS(description='Indicates whether the receipt contains a double entry'),
wrong_plu_fg BIGNUMERIC(38,0) OPTIONS(description='Indicates if a receipt has been cancelled due to a PLU error'),
quantity_error_fg BIGNUMERIC(38,0)
OPTIONS(description='Indicates if a receipt has been cancelled due to a quantity error'),
price_error_fg BIGNUMERIC(38,0) OPTIONS(description='Indicates if a receipt has been cancelled due to a price error'),
suspended_bon_nr BIGNUMERIC(38,0) OPTIONS(description='Die Nummer des ausgesetzten Belegs'),
cancellation_after_sumbutton_sec BIGNUMERIC(38,0)
OPTIONS(description='Time Difference in second between Sum Button pressed and cancellation'),
gift_lifetime_min BIGNUMERIC(38,0)
OPTIONS(description='Time Difference in Minute between activation and redemption of gift card'),
identical_item_cnt BIGNUMERIC(38,0) OPTIONS(description='Indicates the number of identical items'),
storno_pos_cnt BIGNUMERIC(38,0) OPTIONS(description='Indicates the number of storno positions in a receipt'),
all_item_cnt BIGNUMERIC(38,0) OPTIONS(description='Indicates the number of item_1 in a receipt'),
asc_receipt_row_nr BIGNUMERIC(38,0)
OPTIONS(description='position number of the Receipt in ascending order of booking time within a defined partition'),
desc_receipt_row_nr BIGNUMERIC(38,0)
OPTIONS(description='position number of the Receipt  in descending order of booking time within a defined partition'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (bon_id, bon_dat, wup_id, mandant_id) NOT ENFORCED
) OPTIONS(description=' Contains aggregated receipt data for the implementation of the fraud detection scenarios');