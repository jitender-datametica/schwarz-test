CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.autdi_13_3 AS WITH DAYS AS (SELECT DATE_SUB(CURRENT_DATE,
    INTERVAL ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1) DAY) AS d_date
  FROM UNNEST(GENERATE_ARRAY(0, 29)) AS SEQ) (SELECT store_wh,
   country,
   store_nr,
   status,
   entrydate
  FROM (SELECT S.store_wh,
     S.country,
     S.store_nr,
      CASE
      WHEN IFNULL(CAST(vm.store AS STRING), 'YYYY') = CAST(vm.store AS STRING)
      THEN 1
      ELSE 0
      END AS status,
     t2.d_date AS entrydate,
     SP.store AS sp_store,
     SP.reports AS sp_reports
    FROM DAYS AS t2
     INNER JOIN ldl_autodispo_core.t_oracle_v_dim_store AS S ON TRUE
     LEFT JOIN (SELECT country,
       store,
       entrydate
      FROM ldl_autodispo_core.t_oracle_v_fk_mil AS VMIL
      WHERE CAST(entrydate AS DATE) >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
      GROUP BY country,
       store,
       entrydate) AS vm ON S.store_nr = vm.store AND S.country = vm.country AND CAST(vm.entrydate AS DATE) = t2.d_date
     LEFT JOIN ldl_autodispo_core.t_oracle_v_fk_rebuilds AS RB ON S.store_nr = RB.rb_store_nr AND S.country = RB.country
         AND t2.d_date BETWEEN DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(RB.rb_datefrom - 365.25 * 4712 - 1 AS INTEGER)
        DAY) AND (DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(RB.rb_dateto - 365.25 * 4712 - 3 AS INTEGER)
         DAY))
     LEFT JOIN ldl_autodispo_core.t_oracle_v_specialday AS SP ON S.store_nr = SP.store AND S.country = SP.country AND t2
        .d_date = SP.sp_day AND RB.rb_store_nr IS NULL
    WHERE S.store_nr <> 0
     AND S.deleted = 0) AS t8
  WHERE t8.sp_store IS NULL
   OR t8.sp_reports = 1);