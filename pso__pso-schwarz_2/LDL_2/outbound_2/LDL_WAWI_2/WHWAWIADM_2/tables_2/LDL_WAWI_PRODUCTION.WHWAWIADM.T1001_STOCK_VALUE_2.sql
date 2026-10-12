DROP TABLE IF EXISTS ldl_wawi_production_whwawiadm.t1001_stock_value_2;
--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE ldl_wawi_production_whwawiadm.t1001_stock_value_2 (
wawi_instanz_kzl STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr INTEGER NOT NULL,
c1001_id INTEGER NOT NULL,
c1001_stock_area INTEGER NOT NULL,
c1001_date DATETIME NOT NULL,
c1001_itemnr STRING(18) NOT NULL,
c1001_pieceqty_cal NUMERIC(12,3) NOT NULL,
c1001_pieceqty_real NUMERIC(12,3),
c1001_pieceqty_ewmcalc NUMERIC(12,3),
c1001_pieceqty_nf_under NUMERIC(12,3),
c1001_pieceqty_nf_over NUMERIC(12,3),
c1001_pieceqty_nf_nonrec NUMERIC(12,3),
c1001_pieceqty_nf_zerodel NUMERIC(12,3),
c1001_pieceqty_nf_sps_over NUMERIC(12,3),
c1001_pieceqty_nf_sps_under NUMERIC(12,3),
scn BIGNUMERIC(38,0) DEFAULT 0,
delete_fg STRING(1),
extraction_tmsp DATETIME,
PRIMARY KEY (c1001_id, wh_nr) NOT ENFORCED
) CLUSTER BY c1001_id, wh_nr;