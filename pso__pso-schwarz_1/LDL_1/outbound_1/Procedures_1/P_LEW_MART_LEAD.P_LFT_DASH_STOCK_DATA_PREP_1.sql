CREATE OR REPLACE PROCEDURE p_lew_mart_lead.p_lft_dash_stock_data_prep(IN PARAM1 STRING, IN PARAM2 STRING)
BEGIN
  DECLARE param1 STRING;
  DECLARE param2 STRING;
  DECLARE stmnt0 STRING;
  DECLARE rs0 ARRAY<JSON>;
  DECLARE LOOP_END STRING;
  DECLARE LOOP_ROW NUMERIC;
  DECLARE stmnt STRING;
  DECLARE rs_1 ARRAY<JSON>;
  DECLARE stmnt1 STRING;
  DECLARE iterator_rs0 INT64 DEFAULT -1;
  DECLARE iterator_rs INT64 DEFAULT -1;

  -- Fix: Declare variables before setting them
  SET param1 = PARAM1;
  SET param2 = PARAM2;

  -- Create Temp Table
  SET stmnt0 = '''CREATE OR REPLACE TEMPORARY TABLE v_stock_location_item_tmp_core ( client_id INTEGER, loc_sid INTEGER, item_sid INTEGER, dwh_cal_dt DATE, stock_calc_qty NUMERIC(29,5), stock_inv_qty NUMERIC(29,5), stock_real_qty NUMERIC(29,5), stock_inv_diff_calc NUMERIC(29,5), price NUMERIC(29,5), price_net NUMERIC(29,5), src_space_switch INTEGER, dwh_valid_from DATE, dwh_valid_to DATE ) ''';
  EXECUTE IMMEDIATE (stmnt0);

  -- Get Loop End Count
  SET stmnt0 = '''SELECT COUNT(1) AS cnt FROM p_lew_core_ac.v_cal_calendarday_1 AS CAL WHERE cal_dt BETWEEN 'param1' AND 'param2' ''';
  SET stmnt0 = REGEXP_REPLACE(stmnt0, 'param1', PARAM1);
  SET stmnt0 = REGEXP_REPLACE(stmnt0, 'param2', PARAM2);

  EXECUTE IMMEDIATE FORMAT("""
    SELECT ARRAY_AGG(JSON_ARRAY(%s))
    FROM (%s)
  """, 'cnt', stmnt0) INTO rs0;

  SET iterator_rs0 = iterator_rs0 + 1;
  SET LOOP_END = JSON_EXTRACT_SCALAR(rs0[SAFE_OFFSET(iterator_rs0)], '$[0]');
  SET LOOP_ROW = 0;

  -- Fix: Adjusted Target Temp Table, Source Table, and Quote Escaping inside the dynamic string
  SET stmnt = '''WITH BASE_SQL AS (SELECT """\nINSERT INTO v_stock_location_item_tmp_core\nSELECT\t\nhist.client_id AS client_id,\t\nhist.loc_sid AS loc_sid,\t\nhist.item_sid AS item_sid,\t\nCast(x!xdat_paramx!x as date) AS dwh_cal_dt,\t\nhist.calc_qty AS stock_calc_qty,\t\nhist.inv_qty AS stock_inv_qty,\t\nCASE WHEN IFNULL(diff_qty_inv_calc, 0) = 0\t\nTHEN hist.calc_qty\t\nELSE hist.inv_qty\t\nEND AS stock_real_qty,\t\nhist.diff_qty_inv_calc AS stock_inv_diff_calc,\t\nhist.price AS price,\t\nhist.price_net AS price_net,\t\nsrc_space_switch,\t\ndwh_valid_from,\t\ndwh_valid_to\t\nFROM p_lew_core_ac.v_item_location_stock_hist_1 AS hist\t\nWHERE Cast(x!xdat_paramx!x as date) BETWEEN hist.dwh_valid_from AND hist.dwh_valid_to\t;""" AS txt), T0 AS (SELECT REPLACE(txt, "x!x", "'") AS txt1 FROM BASE_SQL), DATES AS (SELECT cal_dt FROM p_lew_core_ac.v_cal_calendarday_1 AS CAL WHERE cal_dt BETWEEN 'param1' AND 'param2') SELECT REPLACE(t2.txt1, "dat_param", SUBSTR(CAST(t5.cal_dt AS STRING), 1, 10)) AS a0 FROM T0 AS t2 CROSS JOIN DATES AS t5 ORDER BY t5.cal_dt NULLS LAST ''';

  SET stmnt = REGEXP_REPLACE(stmnt, 'param1', PARAM1);
  SET stmnt = REGEXP_REPLACE(stmnt, 'param2', PARAM2);

  -- Extract the array of dynamically generated INSERT statements
  EXECUTE IMMEDIATE FORMAT("""
    SELECT ARRAY_AGG(JSON_ARRAY(%s))
    FROM (%s)
  """, 'a0', stmnt) INTO rs_1;

  -- Loop through and execute each generated INSERT statement
  WHILE (LOOP_ROW < CAST(LOOP_END AS INT64)) DO
      BEGIN
          SET iterator_rs = iterator_rs + 1;
          SET stmnt1 = JSON_EXTRACT_SCALAR(rs_1[SAFE_OFFSET(iterator_rs)], '$[0]');
          
          EXECUTE IMMEDIATE (stmnt1);
          
          SET LOOP_ROW = LOOP_ROW + 1;
      END;
  END WHILE;

END;