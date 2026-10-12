CREATE OR REPLACE VIEW ldl_data_production_etl.v_etl_artikel (cntry, artikelnr, dt, pr_dt) AS SELECT cntry,
 artikelnr,
 dt,
 DATE_ADD(dt, INTERVAL - 1 DAY) AS pr_dt
FROM (SELECT LEFT(ctrcode, 2) AS cntry,
   artikelnr,
   DATE(extraction_tmsp) AS dt
  FROM ldl_data_production_etl.artikel
  GROUP BY cntry,
   artikelnr,
   dt) AS t0;