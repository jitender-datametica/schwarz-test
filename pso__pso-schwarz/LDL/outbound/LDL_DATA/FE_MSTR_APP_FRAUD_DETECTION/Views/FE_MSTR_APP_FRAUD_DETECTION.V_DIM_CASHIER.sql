CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_cashier (store_sid
OPTIONS(description='THE UNIQUE IDENTIFIER (SURROGATE KEY) FOR THE STORE WHERE THE RELATED CASH REGISTER EVENT HAPPENED.'),
cashier_nr
OPTIONS(description='THE NUMBER WHICH IDENTIFIES THE CASHIER. (THE NUMBER IS UNIQUE FOR A GIVEN STORE AND A DAY.)'),
cashier_desc OPTIONS(description='THE BUSINESS KEY OF A CASHIER'))
OPTIONS(DESCRIPTION = `THE DIMENSION VIEW FOR THE CASHIERS`) AS WITH CASHIER_DIM AS (SELECT store_nr,
   country_org_cd,
   cashier_nr
  FROM ldl_data_core_app_fraud_detection.t_cashier_encryption AS DIM
  WHERE bus_dt > DATE '2024-12-29'
  GROUP BY store_nr,
   country_org_cd,
   cashier_nr) (SELECT ORG.int_org_sid AS store_sid,
   t1.cashier_nr,
     ORG.curr_int_org_nr || '|' || t1.cashier_nr AS cashier_desc
  FROM (SELECT country_org_cd,
     store_nr,
     cashier_nr
    FROM CASHIER_DIM AS MAIN) AS t1
   INNER JOIN ldl_data_core_dim.t_dim_internal_organization AS ORG ON ORG.curr_int_org_nr = t1.country_org_cd || t1.store_nr
        AND ORG.dwh_valid_fg AND ORG.int_org_type_cd = 'STORE');