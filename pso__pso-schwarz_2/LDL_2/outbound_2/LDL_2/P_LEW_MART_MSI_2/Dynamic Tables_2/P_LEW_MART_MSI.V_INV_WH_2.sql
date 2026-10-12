CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_inv_wh_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT inv1.client_id,
 inv1.wh_id,
 inv1.inv_id,
 DATE_ADD(inv2.dat_formdate, INTERVAL 1 DAY) AS inv_start_date,
 inv1.dat_formdate AS inv_end_date
FROM (SELECT client_id,
   wh_id,
   inv_id,
   dat_formdate,
   RANK() OVER (PARTITION BY CAST(client_id AS STRING), wh_id ORDER BY dat_formdate IS NULL, dat_formdate) AS sort
  FROM (SELECT client_id,
     wh_id,
     inv_id,
     dat_formdate
    FROM ldl_p_lew_mart_msi.v_inv_item_wh_2
    WHERE inv_type = 'F'
    GROUP BY client_id,
     wh_id,
     dat_formdate,
     inv_id) AS t1_2) AS inv1
 LEFT JOIN (SELECT client_id,
   wh_id,
   inv_id,
   dat_formdate,
   RANK() OVER (PARTITION BY CAST(client_id AS STRING), wh_id ORDER BY dat_formdate IS NULL, dat_formdate) AS sort
  FROM (SELECT client_id,
     wh_id,
     inv_id,
     dat_formdate
    FROM ldl_p_lew_mart_msi.v_inv_item_wh_2
    WHERE inv_type = 'F'
    GROUP BY client_id,
     wh_id,
     dat_formdate,
     inv_id) AS t5) AS inv2 ON inv1.client_id = inv2.client_id AND inv1.wh_id = inv2.wh_id AND inv1.sort = inv2.sort + 1;