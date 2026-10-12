CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_dispopos (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
po_nr STRING(12) NOT NULL
OPTIONS(description='Order number: supplier number (4), delivery date (6), consecutive number (2)'),
artikelnr STRING(18) NOT NULL OPTIONS(description='nine-digit article number - ARTICLE.Article no'),
lfdnr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The ORADBC W00.00.37 changes the data format from Number (2.0) to Number (3.0) - WEPOS.DispoLfdNrArtikel'),
disponr BIGNUMERIC(38,0)
OPTIONS(description='Order quantity unit: 0 = boxes; 1 = layer; 2 = Düsseldorf; 3 = pallet; 4 = piece (not supported by DIS); Is recoded via table DISPOEINHEIT'),
menge BIGNUMERIC(38,0) OPTIONS(description='Order quantity in order unit'),
liefdatum DATETIME OPTIONS(description='Delivery date'),
liefzeit DATETIME OPTIONS(description='Time for delivery'),
menge2 BIGNUMERIC(38,0) OPTIONS(description='Received quantity for GR split. Is filled by eGIN for partial deliveries'),
datum DATETIME OPTIONS(description='Creation date'),
bediener STRING(8) OPTIONS(description='User (replenishment planner)'),
datumm2 DATETIME OPTIONS(description='Change date QUANTITY2'),
bedienerm2 STRING(8) OPTIONS(description='User QUANTITY2. Is filled by eGIN for partial deliveries'),
knzteil BIGNUMERIC(38,0) OPTIONS(description='Is filled by eGIN for partial deliveries. Default value = 0'),
status BIGNUMERIC(38,0)
OPTIONS(description='0 = order open; 1 = order after quantity correction; 2 = order closed; 9 = Order deleted'),
kartonfakt BIGNUMERIC(38,0) OPTIONS(description='Pallet factor of the ordered order unit'),
diff_we BIGNUMERIC(38,0) OPTIONS(description=''),
c126_org_order_qty BIGNUMERIC(38,10) OPTIONS(description='Delivery quantity'),
c126_org_del_date DATETIME OPTIONS(description='Delivery date'),
c126_taskid BIGNUMERIC(38,0) OPTIONS(description='Is filled by eGIN as part of the WE'),
c126_deltime_until DATETIME OPTIONS(description='Delivery time'),
c126_decimalcase BIGNUMERIC(38,3) OPTIONS(description='Decimal case content'),
c126_desadv_comment STRING(500)
OPTIONS(description='Free text in which the dispatchers can maintain how the difference should be handled. Is displayed in eGIN during clarification with the MRP information flag.'),
c126_desadv_status BIGNUMERIC(38,0)
OPTIONS(description='Status DESADV (in the context of clarification of differences). Comment that is maintained by SC as part of the clarification of differences between DESADV and ORDER'),
scn BIGNUMERIC(38,0) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, po_nr, artikelnr, lfdnr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.DISPOPOS.');