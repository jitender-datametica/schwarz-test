CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_bestandartikel_act_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_nr INTEGER NOT NULL,
artikelnr STRING(18) NOT NULL,
menge BIGNUMERIC(30,10) NOT NULL,
retail_price BIGNUMERIC(30,10) NOT NULL,
scn BIGNUMERIC(38,0) NOT NULL,
datum DATETIME NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
deleted_fg BOOL NOT NULL,
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, datum, artikelnr, wh_nr) NOT ENFORCED
) CLUSTER BY client_id, wh_nr, datum
OPTIONS(description='Based on WAWI - WHWAWIADM.BESTANDARTIKEL_2 table - only active items included');