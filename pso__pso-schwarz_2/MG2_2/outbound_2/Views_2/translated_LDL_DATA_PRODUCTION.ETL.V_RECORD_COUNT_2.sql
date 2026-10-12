-- on  mbdt.LAST_BUSS_DT = CRDAY.BUS_DT 


CREATE OR REPLACE VIEW ldl_data_production_etl.v_record_count_2 (bus_dt, target_table, today_reccount, prev_reccount) AS
SELECT CRDAY.bus_dt,
 COALESCE(CRDAY.tbl_name, PRDAY.tbl_name) AS target_table,
 COALESCE(CRDAY.today_reccount, 0) AS today_reccount,
 COALESCE(PRDAY.prev_reccount, 0) AS prev_reccount
FROM (SELECT bus_dt,
   tbl_name,
   tbl_rec_cnt AS today_reccount
  FROM ldl_data_production_etl.t_rec_cnt_2
  WHERE bus_dt = (SELECT MAX(bus_dt) AS last_buss_dt
     FROM ldl_data_production_etl.t_rec_cnt_2)) AS CRDAY
 FULL JOIN (SELECT bus_dt,
   tbl_name,
   tbl_rec_cnt AS prev_reccount
  FROM ldl_data_production_etl.t_rec_cnt_2
  WHERE bus_dt = (SELECT DATE_SUB(MAX(bus_dt), INTERVAL 1 DAY) AS last_buss_dt
     FROM ldl_data_production_etl.t_rec_cnt_2)) AS PRDAY ON CRDAY.tbl_name = PRDAY.tbl_name;