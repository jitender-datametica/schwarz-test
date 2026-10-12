DROP TABLE IF EXISTS ldl_wawi_production_whwawistd.t431_ststock;
--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE ldl_wawi_production_whwawistd.t431_ststock (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c431_storenr INTEGER NOT NULL,
c431_date DATETIME NOT NULL,
c431_itemnr STRING(14) NOT NULL,
c431_calc_stock BIGNUMERIC(30,10),
c431_diff BIGNUMERIC(30,10),
c431_inv_stock BIGNUMERIC(30,10),
c431_moddate DATETIME,
c431_inv_type INTEGER,
c431_calc_stock_old BIGNUMERIC(30,10),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c431_date, c431_itemnr, c431_storenr, wh_nr) NOT ENFORCED
) CLUSTER BY c431_date, c431_itemnr, c431_storenr;