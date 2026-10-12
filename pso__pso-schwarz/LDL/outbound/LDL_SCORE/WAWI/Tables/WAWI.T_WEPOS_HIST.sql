CREATE TABLE IF NOT EXISTS ldl_score_wawi.t_wepos_hist (
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number. Original name: gesellschaftsnr'),
wawi_instanz_kzl STRING(3) NOT NULL,
id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identification number that is assigned by the system when the goods are entered.'),
artikelnr STRING(18) NOT NULL OPTIONS(description='Long item number'),
lagerortnr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Storage location number of the company in which the incoming goods are recorded and must be maintained in the eGIN module in the administration mask.'),
debit_note BIGNUMERIC(38,0)
OPTIONS(description='If a debit note was generated when the invoice was entered. 0: no, no debit note. 1: yes, debit note was generated'),
nr BIGNUMERIC(38,0) OPTIONS(description='Type of transport'),
anlieferungsartkzl STRING(3) OPTIONS(description='Type of delivery'),
landkzl STRING(3) OPTIONS(description='Country of origin of the item.'),
waehrungsknz BIGNUMERIC(38,0) OPTIONS(description='Currency code that is stored for the purchase conditions.'),
mengekarton BIGNUMERIC(38,0) OPTIONS(description='Quantity of boxes delivered.'),
dispolfdnrartikel BIGNUMERIC(38,0)
OPTIONS(description='Consecutive numbers that are assigned by the dispo module when the order is generated.'),
link_posnr2 BIGNUMERIC(38,0),
container_deposit BIGNUMERIC(38,10) OPTIONS(description='The deposit amount per item. 0: there is no deposit item'),
ekpstueckland BIGNUMERIC(38,10)
OPTIONS(description='Purchase price in local currency with the exchange rate on the goods-in receipt date.'),
ekpstueckekland BIGNUMERIC(38,10)
OPTIONS(description='Purchase price in the suppliers currency with the exchange rate on the goods-in receipt date.'),
ekpstueckdm BIGNUMERIC(38,10) OPTIONS(description='Purchase price in Euros (currency of Lidl International)'),
sumekpland BIGNUMERIC(38,10)
OPTIONS(description='Total amount (case content * carton quantity + single item) Purchase price of the item in local currency. Goods-in receipt quantity in pieces * EKPSTUECKLAND'),
sumekpdm BIGNUMERIC(38,10),
sumekpekland BIGNUMERIC(38,10)
OPTIONS(description='Total amount (case content * carton quantity + individual item) Purchase price in the suppliers currency. Quantity of goods received in pieces * EKPSTUECKEKLAND'),
sumvkpnorm BIGNUMERIC(38,10)
OPTIONS(description='Total amount (case content * carton quantity + single item) selling price of the item. Goods-in receipt quantity in pieces * VKPNORMSTUECK is filled in by DAY'),
teillieferung BIGNUMERIC(38,0)
OPTIONS(description='Indicator for partial delivery. 0 = no partial delivery. 1 = partial delivery'),
status BIGNUMERIC(38,0)
OPTIONS(description='Specification of the status, which is important for invoice verification. Status 1 is set after DAY has run'),
mindesthaltbarkeit DATE OPTIONS(description='Best before date of the item'),
datum DATETIME OPTIONS(description='Processing date of the goods-in receipts (set by DAY, DHQ)'),
bediener STRING(25) OPTIONS(description='User who logged on to the incoming goods module, DHQ or REP'),
rechposnr BIGNUMERIC(38,0)
OPTIONS(description='Number assigned by the system that is generated for different invoice items when the invoice is entered.'),
weposart BIGNUMERIC(38,0) OPTIONS(description='Goods-in receipt type, which are divided into 16 types'),
tgstatus BIGNUMERIC(38,0)
OPTIONS(description='Shows the status of the processing of the goods receipt in the daily closing. '),
weight_value BIGNUMERIC(38,10) OPTIONS(description='The weight is saved in this column'),
mwstschl BIGNUMERIC(38,0)
OPTIONS(description='contains the value-added (VAT) tax key for this article, which is used to assign the VAT rate.'),
todo BIGNUMERIC(38,0)
OPTIONS(description='To be seen in connection with the STATUS column; is important when auditing the invoice. The column is for, among other things, the report REP10 - Complete overview of evaluated price differences.'),
oldstatus BIGNUMERIC(38,0),
ra_posnr BIGNUMERIC(38,0) OPTIONS(description='Consecutive numbers that are assigned as part of the invoice entry.'),
ra_id BIGNUMERIC(38,0) OPTIONS(description='Indicates the number of the batch in which the invoice was entered.'),
krednr STRING(7) OPTIONS(description='Number of the supplier who issues the invoice for this line.'),
zollnr STRING(5) OPTIONS(description='All SK (WEPOSARTEN 4,5,7,8) have a value in this column, C307_SPSUBNR'),
dex_status BIGNUMERIC(38,0),
wekorrdatum DATE OPTIONS(description='Posting date of the goods-in receipt.'),
ret_vatmultiplier BIGNUMERIC(38,4) OPTIONS(description='Divisor for calculating the net amount. '),
wedatum DATE,
spcondnr BIGNUMERIC(38,0) OPTIONS(description='Which special condition is involved.'),
matchable BIGNUMERIC(38,0)
OPTIONS(description='If goods-in receipt items are matchable, i.e. can be compared with invoices in the inspection.'),
includemargin BIGNUMERIC(38,0)
OPTIONS(description='Shows the range relevance of the individual prices and conditions, which are taken into account in later evaluations.'),
bev_tax BIGNUMERIC(38,10)
OPTIONS(description='Divisor for calculating the retail price without beverage tax (Only AT). This value is set by DAY.'),
vkpnormstueck BIGNUMERIC(38,10) OPTIONS(description='Sales price per piece in local currency, is set by DAY'),
item_category BIGNUMERIC(38,0)
OPTIONS(description='Article category for VAT determination. The value is linked to the T007_DESCRIPTIONS.C007_ID column. For correct determination, the column C007_Type must be restricted to ItemCategory.'),
change_id BIGNUMERIC(38,0)
OPTIONS(description='This is filled in during repricing; each time the DHQ module is restarted, the next CHANGE_ID is read from the ID table, parameter REPRU_CHANGE_ID'),
splitlinkposnr BIGNUMERIC(38,0)
OPTIONS(description='Baseline of the goods-in receipt from a splitting (remains, unlike the LINK_POSNR with repricing)'),
split_type BIGNUMERIC(38,0) OPTIONS(description='Specifies what type of splitting was done.'),
valid_from DATE
OPTIONS(description='The VALID_FROM column defines when a data record begins to be valid. Typically this is the date of the goods-in receipt and is, at the latest, the date of the goods-in receipt evaluation in DHQ'),
valid_until DATE OPTIONS(description='The VALID_UNTIL column defines until when a record is valid.'),
item_facility STRING(20),
pallet_factor BIGNUMERIC(38,0) OPTIONS(description='Incoming goods pallet factor measured during counting'),
link_posnr BIGNUMERIC(38,0) OPTIONS(description='Line reference number within this goods-in receipt ID.'),
adjust_stock STRING(1) OPTIONS(description='Indicator for inventory correction in an RS.'),
issue_slip STRING(30) OPTIONS(description='Delivery slip number.'),
satas_entree STRING(21) OPTIONS(description='SATAS number.'),
rcv_unit_type BIGNUMERIC(38,0),
item_facility2 STRING(20),
item_facility3 STRING(20),
decimalcase BIGNUMERIC(38,3) OPTIONS(description='Contents of cases.'),
mengestueck BIGNUMERIC(38,10) OPTIONS(description='Quantity delivered single item;'),
pricecond_value BIGNUMERIC(38,10)
OPTIONS(description='Value of the weight condition at the time the goods are received.'),
posnr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item no. - consecutive no. Within the ID no.'),
ewm_send_flag BIGNUMERIC(38,0) OPTIONS(description='Flag to mark already sent corrections to EWM'),
cw_caseqty BIGNUMERIC(38,0) OPTIONS(description='Catchweight Case Qty from EWM'),
lpv INTEGER,
scn BIGNUMERIC(38,0),
scaleqty BIGNUMERIC(30,10),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_id, artikelnr, id, lagerortnr, posnr, wawi_instanz_kzl, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='WAWI - Detailed table for goods-in receipts.');