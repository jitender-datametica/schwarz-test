CREATE OR REPLACE VIEW ldl_dig_fe_shs.v_refdata_negativcheck_datumsformat2_version2_2 AS WITH CUST_IDS AS (SELECT DISTINCT
   FOD.cust_sid AS id
  FROM ldl_dig_core.t_fact_customer_financial_order_2 AS FO
   LEFT JOIN ldl_dig_core.t_fact_customer_financial_order_debt_2 AS FOD ON FO.cust_order_install_nr = FOD.cust_order_install_nr
      AND FOD.dwh_valid_fg
   LEFT JOIN ldl_dig_core.t_fact_customer_order_installment_2 AS OI ON FO.cust_order_install_nr = OI.cust_order_install_nr
       AND FOD.debt_collection_item_nr = OI.debt_collection_item_nr AND OI.dwh_valid_fg
  WHERE FO.dwh_valid_fg
   AND FO.debt_collection_start_dt > DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
   AND NOT OI.is_settl_fg) (SELECT t2.id,
   CUST.cust_first_name AS firstname,
   CUST.cust_last_name AS lastname,
   CUST.cust_birth_dt AS dateofbirth,
   ADDR.country_name AS country_2,
   ADDR.zip_cd AS zipcode,
   ADDR.city_name AS city,
   ADDR.street_name AS streetname,
   ADDR.house_nr AS streetnumber,
   ADDR.addr_suffix AS addresssuffix,
   'RA_2' AS adresstyp
  FROM CUST_IDS AS t2
   LEFT JOIN ldl_dig_core.t_dim_customer_2 AS CUST ON t2.id = CUST.cust_sid
   LEFT JOIN ldl_dig_core.t_dim_address_2 AS ADDR ON CUST.cust_billing_addr_sid = ADDR.addr_sid AND ADDR.dwh_valid_fg
  WHERE CUST.dwh_valid_fg
   AND ADDR.country_name = 'DE');