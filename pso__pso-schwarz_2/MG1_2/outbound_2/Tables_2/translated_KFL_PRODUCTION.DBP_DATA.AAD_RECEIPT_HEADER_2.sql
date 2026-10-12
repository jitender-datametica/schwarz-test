CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.AAD_RECEIPT_HEADER_2 (
BON_ID STRING(100) NOT NULL OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'),
BON_DAT DATE NOT NULL OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
BON_NR INTEGER
OPTIONS(description='Die Bonnummer des Bons (ist eine_2 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_2 und Kasse unique).'),
KASSE_NR INTEGER OPTIONS(description='Nummer der Kasse.'),
KASSIERER_NR STRING(4) OPTIONS(description='Nummer des Kassierers.'),
WRG_ID STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
BON_BOOKING DATETIME
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_2 Kasse offline war.'),
SCANNED_EMPTIES_PAYM_GROSS_LOCAL_VAL NUMERIC(18,4) OPTIONS(description='Amount of the scanned empties'),
MANUAL_EMPTIES_PAYM_GROSS_LOCAL_VAL NUMERIC(18,4) OPTIONS(description='Amount of the manually entered empties'),
EC_PAYM_GROSS_LOCAL_VAL NUMERIC(18,4) OPTIONS(description='receipt total with EC payment method'),
CASH_PAYM_GROSS_LOCAL_VAL NUMERIC(18,4) OPTIONS(description='receipt total with cash payment method'),
GIFTCARD_PAYM_GROSS_LOCAL_VAL NUMERIC(18,4) OPTIONS(description='receipt total with gift card payment method'),
LOGIN_CHECKOUT_FG INTEGER OPTIONS(description='Indicates whether a cashier has logged on to the cash register'),
LOGOUT_CHECKOUT_FG INTEGER OPTIONS(description='Indicates whether a cashier has logged out from the cash register'),
LAST_SALES_POS_ID INTEGER OPTIONS(description='Indicates the last receipt line of a receipt'),
CANCELLATION_AMOUNT_GROSS_LOCAL_VAL NUMERIC(18,4) OPTIONS(description='Indicates the cancelled amount'),
CANCELLATION_POS_FG INTEGER OPTIONS(description='Indicates whether an item_2 has been cancelled on the receipt'),
CANCEL_FG INTEGER OPTIONS(description='Das Flag kennzeichnet einen Abbruchvorgang'),
CANCELLED_ITEM_CNT INTEGER OPTIONS(description='cancelled_item_cnt'),
PREVIOUS_BON_NR INTEGER OPTIONS(description='Indicates the previous receipt number'),
NEXT_BON_NR INTEGER OPTIONS(description='Indicates the successor receipt number'),
SCHLIESSEN_KASSENSCHUBLADE DATETIME
OPTIONS(description='Zeitstempel wird an der Kasse erzeugt, wenn die Kassenlade geschlossen wird.'),
TRAINING_FG INTEGER
OPTIONS(description='Das Flag kennzeichnet, ob die Transaktion im Trainings-Modus durchgefuehrt wurde.'),
ITEM_REDUCTION_AMOUNT_GROSS_LOCAL_VAL NUMERIC(18,4) OPTIONS(description='Indicates the reduced article value'),
ITEM_REDUCTION_MIN_PCT_VAL NUMERIC(18,4) OPTIONS(description='Indicates if an article is reduced more than 50%'),
MANUAL_DEBIT_INVOICE_FG INTEGER OPTIONS(description='Indicates whether the Payment type is manual direct debit'),
BARCODE_EMPTY_FG INTEGER OPTIONS(description='Indicates whether the receipt contains a barcode empty'),
LAST_CANCELLED_POS_ID INTEGER OPTIONS(description='Indicates the last cancelled line of a receipt'),
LAST_SOLD_POS_ID INTEGER OPTIONS(description='Indicates the last line of a receipt where an item_2 was purchased'),
RECLAMATION_FG INTEGER OPTIONS(description='Indicates when a receipt contains a reclamation'),
ARTICLE_WITHOUT_SHOP_BAG_CNT INTEGER
OPTIONS(description='Indicates the number of items, excluding shopping bags within a receipt'),
SHOP_BAG_IN_RECEIPT_CNT INTEGER OPTIONS(description='Indicates the number of shopping bags in a receipt'),
SUSPENDED_FG INTEGER OPTIONS(description='Flag: Kennzeichnung des Suspended-Status_2 der Transaktion. 1 = suspended'),
DOUBLE_ENTRY_FG INTEGER OPTIONS(description='Indicates whether the receipt contains a double entry'),
WRONG_PLU_FG INTEGER OPTIONS(description='Indicates if a receipt has been cancelled due to a PLU error'),
QUANTITY_ERROR_FG INTEGER OPTIONS(description='Indicates if a receipt has been cancelled due to a quantity error'),
PRICE_ERROR_FG INTEGER OPTIONS(description='Indicates if a receipt has been cancelled due to a price error'),
SUSPENDED_BON_NR INTEGER OPTIONS(description='Die Nummer des ausgesetzten Belegs'),
CANCELLATION_AFTER_SUMBUTTON_SEC INTEGER
OPTIONS(description='Time Difference in second between Sum Button pressed and cancellation'),
GIFT_LIFETIME_MIN INTEGER
OPTIONS(description='Time Difference in Minute between activation and redemption of gift card'),
IDENTICAL_ITEM_CNT INTEGER OPTIONS(description='Indicates the number of identical items'),
STORNO_POS_CNT INTEGER OPTIONS(description='Indicates the number of storno positions in a receipt'),
ALL_ITEM_CNT INTEGER OPTIONS(description='Indicates the number of item_2 in a receipt'),
ASC_RECEIPT_ROW_NR INTEGER
OPTIONS(description='position number of the Receipt in ascending order of booking time within a defined partition'),
DESC_RECEIPT_ROW_NR INTEGER
OPTIONS(description='position number of the Receipt  in descending order of booking time within a defined partition'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (BON_ID, BON_DAT, WUP_ID, MANDANT_ID) NOT ENFORCED
) OPTIONS(description=' Contains aggregated receipt data for the implementation of the fraud detection scenarios');