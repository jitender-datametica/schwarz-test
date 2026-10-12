CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_stock_changes_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_2 code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
c1003_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique ID, which is assigned automatically'),
sscc BIGNUMERIC(38,0) OPTIONS(description='ID from the T1010_SSCC table'),
stock_area BIGNUMERIC(38,0) OPTIONS(description='Sender ID from the T1000_STOCK_AREA table'),
rcv_stock_area BIGNUMERIC(38,0) OPTIONS(description='Recipient ID from the T1000_STOCK_AREA table'),
corrid BIGNUMERIC(38,0) OPTIONS(description='ID from the T1002_STOCK_CORRECTION table'),
formdate DATETIME OPTIONS(description='Document date'),
itemnr STRING(18) OPTIONS(description='Item_2 number from the ARTICLE table'),
pieceqty BIGNUMERIC(38,3)
OPTIONS(description='Difference quantity. Always refers to the C1003_STOCK_AREA column. A + value increases C1003_STOCK_AREA and a - value decreases C1003_RCV_STOCK_AREA. A - value increases the posting in reverse.'),
formno STRING(20) OPTIONS(description='Document number'),
formtype BIGNUMERIC(38,0) OPTIONS(description='Document type'),
dayend_status BIGNUMERIC(38,0) OPTIONS(description='TA status_2: 0 = not posted. 1 = TA snapshot. 2 = posted.'),
dayend_date DATETIME OPTIONS(description='Daily closing date'),
moduser STRING(30) OPTIONS(description='Last processor'),
moddate DATETIME OPTIONS(description='Date of change'),
scn BIGNUMERIC(38,0) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, c1003_id, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='WAWI - WHWAWIADM.T1003_STOCK_CHANGES. Detailed table of released stock changes from table T1002_STOCK_CORRECTION. These stock changes are taken into account_2 during a DAY run.');