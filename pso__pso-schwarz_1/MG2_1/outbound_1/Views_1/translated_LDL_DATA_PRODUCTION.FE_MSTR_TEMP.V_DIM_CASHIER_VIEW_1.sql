CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_temp.v_dim_cashier_view_1 AS WITH cashier_dim AS (SELECT store_nr,
   country_org_cd,
   cashier_nr
  FROM ldl_data_production_core_app_fraud_detection.t_cashier_encryption_1 AS dim
  WHERE bus_dt > DATE '2024-12-29'
  GROUP BY store_nr,
   country_org_cd,
   cashier_nr) (SELECT org.store_sid,
   t1.cashier_nr,
     org.curr_store_nr || '|' || t1.cashier_nr AS cashier_desc
  FROM (SELECT country_org_cd,
     store_nr,
     cashier_nr
    FROM cashier_dim AS MAIN) AS t1_1
   INNER JOIN ldl_data_production_fe_mstr_app_fraud_detection.v_dim_store_1 AS org ON org.curr_store_nr = t1.country_org_cd
        || t1.store_nr AND org.dwh_valid_fg AND org.int_org_type_cd = 'STORE');