CREATE TABLE IF NOT EXISTS ldl_score_wawi.t_bestandartikel_hist_2 (
wawi_instanz_kzl STRING(3) NOT NULL,
wh_nr INTEGER NOT NULL,
datum DATETIME NOT NULL,
artikelnr STRING(18) NOT NULL,
retail_price BIGNUMERIC(30,10),
menge BIGNUMERIC(30,10) NOT NULL,
moving_stock BIGNUMERIC(30,10) NOT NULL,
scn BIGNUMERIC(38,0),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wawi_instanz_kzl, datum, artikelnr, wh_nr, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.BESTANDARTIKEL_2 table');