CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital_fraud.v_dim_customer_1 AS WITH CTE_COL AS (SELECT cust_sid,
    MAX(cust_order_dt) >= DATE_ADD(CURRENT_DATE, INTERVAL - 14 DAY) AS placed_order_in_last_two_weeks_fg
  FROM ldl_dig_fe_mstr_lidldigital_fraud.v_fact_customer_order_line_1
  GROUP BY cust_sid), CTE_MATCH_ADDRESSES_TO_CUSTOMERS AS (SELECT COL.cust_sid,
   ADDR.addr_string
  FROM ldl_dig_lec_share.v_fact_customer_order_line_1 AS COL
   INNER JOIN ldl_dig_fe_mstr_lidldigital_fraud.v_dim_address_1 AS ADDR ON COL.billing_addr_sid = ADDR.addr_sid
   INNER JOIN ldl_dig_lec_share.v_dim_customer_1 AS CUST ON COL.cust_sid = CUST.cust_sid AND CUST.dwh_valid_fg
  GROUP BY COL.cust_sid,
   ADDR.addr_string), CTE_CUSTOMERS_SHARING_ADDRESSES_WITH_MORE_THAN_2_OTHERS AS (SELECT A.cust_sid
  FROM CTE_MATCH_ADDRESSES_TO_CUSTOMERS AS A
   INNER JOIN (SELECT addr_string,
     COUNT(DISTINCT cust_sid) AS count_cust_sid
    FROM CTE_MATCH_ADDRESSES_TO_CUSTOMERS
    GROUP BY addr_string
    HAVING count_cust_sid > 2) AS B ON A.addr_string = B.addr_string
  GROUP BY A.cust_sid) (-- if the cust_sid appears in CTE_SHARED, it uses the same address_1 as at least 2 other customers

  SELECT DIM_CUST.cust_sid,
   DIM_CUST.cust_nr,
   DIM_CUST.cust_salutation,
   DIM_CUST.cust_first_name,
   DIM_CUST.cust_last_name,
   DIM_CUST.cust_birth_dt,
   DIM_CUST.cust_age,
   DIM_CUST.cust_type_cd,
   DIM_CUST.cust_org_type_cd,
   DIM_CUST.cust_company_name,
   DIM_CUST.cust_billing_addr_sid,
   DIM_CUST.phone_nr,
   DIM_CUST.email,
   DIM_CUST.cust_blocked_reason_cd,
   DIM_CUST.cust_lan_cd,
   DIM_CUST.cust_sso_id,
   DIM_CUST.cust_creation_dt,
   DIM_CUST.cust_registration_dt,
   DIM_CUST.cust_acct_id,
   DIM_CUST.is_cust_adv_blocked_fg,
   DIM_CUST.email_pcu,
   DIM_CUST.cust_sso_id_pcu,
   DIM_CUST.is_cust_blocked_pcu_fg,
   DIM_CUST.is_cust_deleted_pcu_fg,
    DIM_CUST.cust_creation_dt >= DATE_ADD(CURRENT_DATE, INTERVAL - 90 DAY) AS created_in_last_three_months_fg,
   IFNULL(CTE_COL.placed_order_in_last_two_weeks_fg, FALSE) AS placed_order_in_last_two_weeks_fg,
   IF(t11.cust_sid IS NULL, FALSE, TRUE) AS shares_address_fg
  FROM ldl_dig_fe_mstr_lidldigital.v_dim_customer_1 AS DIM_CUST
   LEFT JOIN CTE_COL AS CTE_COL ON DIM_CUST.cust_sid = CTE_COL.cust_sid
   LEFT JOIN (SELECT DISTINCT *
    FROM CTE_CUSTOMERS_SHARING_ADDRESSES_WITH_MORE_THAN_2_OTHERS AS CTE_SHARED) AS t11 ON DIM_CUST.cust_sid = t11.cust_sid
    );