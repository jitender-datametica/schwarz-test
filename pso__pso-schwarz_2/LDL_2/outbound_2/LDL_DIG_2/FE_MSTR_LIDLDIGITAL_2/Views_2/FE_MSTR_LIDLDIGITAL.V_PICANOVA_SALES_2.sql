CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_picanova_sales_2 (sku, client, client_sort, doctype, orderdatekey,
revenuebeforediscount, couponvalue, ordernumber, paymentmethod, processor, quantity, vouchercampaignid, clientproduct,
commissionnet, discountcodeid, couponcode, vouchercampaignname) AS SELECT sku,
  CASE
  WHEN LENGTH(IFNULL(client, '')) = 0
  THEN 'Sonstiges'
  ELSE CAST(client AS STRING)
  END AS clientx,
  CASE
  WHEN CASE
    WHEN LENGTH(IFNULL(client, '')) = 0
    THEN 'Sonstiges'
    ELSE CAST(client AS STRING)
    END = 'DE'
  THEN '0'
  WHEN CASE
    WHEN LENGTH(IFNULL(client, '')) = 0
    THEN 'Sonstiges'
    ELSE CAST(client AS STRING)
    END = 'Sonstiges'
  THEN 'Z'
  ELSE CAST(client AS STRING)
  END AS client_sort,
  CASE
  WHEN LOWER(doctype) = 'order'
  THEN 'order'
  ELSE ''
  END AS doctype,
 DATE(SAFE.PARSE_DATETIME('%d.%m.%Y', orderdatekey)) AS orderdatekey,
 ROUND(SAFE_CAST(CASE
    WHEN LOWER(prod_type) = 'shipping'
    THEN ''
    WHEN LOWER(prod_type) = 'coupon'
    THEN ''
    WHEN LOWER(prod_type) = 'fullrefund'
    THEN ''
    WHEN LOWER(prod_type) = 'partrefund'
    THEN ''
    ELSE CAST(revenuenetbeforediscount AS STRING)
    END AS BIGNUMERIC), 5) AS revenuenetbeforediscount,
 ABS(ROUND(SAFE_CAST(CASE
     WHEN LOWER(prod_type) = 'coupon'
     THEN CAST(revenuenetbeforediscount AS STRING)
     ELSE ''
     END AS BIGNUMERIC), 5)) AS couponvalue,
  CASE
  WHEN LOWER(prod_type) = 'shipping'
  THEN ''
  WHEN LOWER(prod_type) = 'coupon'
  THEN ''
  WHEN LOWER(prod_type) = 'fullrefund'
  THEN ''
  WHEN LOWER(prod_type) = 'partrefund'
  THEN ''
  ELSE CAST(ordernumber AS STRING)
  END AS ordernumber,
 paymentmethod,
 LEFT(processor, 8) AS processor,
 ROUND(SAFE_CAST(CASE
    WHEN LOWER(prod_type) = 'shipping'
    THEN ''
    WHEN LOWER(prod_type) = 'coupon'
    THEN ''
    WHEN LOWER(prod_type) = 'fullrefund'
    THEN ''
    WHEN LOWER(prod_type) = 'partrefund'
    THEN ''
    ELSE CAST(quantity AS STRING)
    END AS BIGNUMERIC), 5) AS quantity,
 vouchercampaignid,
 platform AS clientproduct,
 ROUND(SAFE_CAST(commissionnet AS BIGNUMERIC), 5) AS commissionnet,
 discountcodeid,
 MAX(TRIM(couponcode)) OVER (PARTITION BY ordernumber, orderdatekey RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS couponcode,
 MAX(TRIM(vouchercampaignname)) OVER (PARTITION BY ordernumber, orderdatekey RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS vouchercampaignname
FROM ldl_dig_fe_mstr_lidldigital.t_picanova_sales_2;