CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_bestandartikel (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
wawi_instanz_kzl STRING(3) NOT NULL,
wh_nr INTEGER NOT NULL,
datum DATETIME NOT NULL,
artikelnr STRING(18) NOT NULL,
retail_price BIGNUMERIC(30,10),
menge BIGNUMERIC(30,10) NOT NULL,
moving_stock BIGNUMERIC(30,10) NOT NULL,
scn BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, datum, artikelnr, wh_nr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.BESTANDARTIKEL table');