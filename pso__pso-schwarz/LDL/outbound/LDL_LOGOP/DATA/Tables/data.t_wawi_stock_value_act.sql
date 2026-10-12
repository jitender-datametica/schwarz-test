CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_stock_value_act AS
SELECT client_id,
 wawi_instanz_kzl,
 wh_nr,
 id,
 stock_area,
 cal_dt,
 itemnr,
 pieceqty_cal,
 pieceqty_real,
 pieceqty_ewmcalc,
 pieceqty_nf_under,
 pieceqty_nf_over,
 pieceqty_nf_nonrec,
 pieceqty_nf_zerodel,
 pieceqty_nf_sps_over,
 pieceqty_nf_sps_under,
 scn,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_wawi_stock_value
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND stock_area = 2
 AND cal_dt >= CAST('2025-03-01 00:00:00' AS DATETIME)
 AND NOT deleted_fg
 AND pieceqty_real IS NOT NULL;