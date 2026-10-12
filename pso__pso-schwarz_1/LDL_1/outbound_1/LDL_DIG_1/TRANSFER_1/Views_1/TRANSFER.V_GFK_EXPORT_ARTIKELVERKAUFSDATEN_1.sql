CREATE OR REPLACE VIEW ldl_dig_transfer.v_gfk_export_artikelverkaufsdaten_1 AS WITH CTE_DIM AS (SELECT PVR.wshop_cd,
   PV.prod_variant_sid,
   PV.prod_variant_nr,
   PV.main_ean_nr,
   PV.prod_variant_descr,
   FAM.prod_subgroup_cd,
   SGR.prod_subgroup_descr,
   REPLACE(PR.prod_family_cd, '.', '_') AS prod_family_cd,
   FAM.prod_family_descr,
   TDS.supplier_nr,
   TDS.supplier_name,
   BCL.brand_class_cd AS brand_class_descr,
   BRD.brand_name
  FROM ldl_dig_core.t_dim_product_variant_1 AS PV
   INNER JOIN ldl_dig_core.t_dim_product_1 AS PR ON PV.prod_sid = PR.prod_sid AND PV.dwh_valid_fg AND PR.dwh_valid_fg
   INNER JOIN ldl_dig_core.t_rel_product_variant_regional_1 AS PVR ON PV.prod_variant_sid = PVR.prod_variant_sid AND PVR.dwh_valid_fg
      AND PR.dwh_valid_fg
   LEFT JOIN ldl_dig_core.t_dim_supplier_1 AS TDS ON PV.main_supplier_sid = TDS.supplier_sid AND TDS.dwh_valid_fg
   LEFT JOIN ldl_dig_core.t_dim_brand_1 AS BRD ON PV.brand_sid = BRD.brand_sid AND BRD.dwh_valid_fg
   LEFT JOIN ldl_dig_core.t_dim_brand_classification_1 AS BCL ON BRD.brand_class_cd = BCL.brand_class_cd
   LEFT JOIN ldl_dig_core.t_dim_product_family_1 AS FAM ON PR.prod_family_cd = FAM.prod_family_cd
   LEFT JOIN ldl_dig_core.t_dim_product_subgroup_1 AS SGR ON FAM.prod_subgroup_cd = SGR.prod_subgroup_cd
   LEFT JOIN ldl_dig_core.t_dim_product_brick_code_1 AS PBC ON PR.prod_brick_cd = PBC.prod_brick_cd AND PBC.dwh_valid_fg
  WHERE PVR.wshop_cd IN (SELECT parameter_value_char
     FROM ldl_dig_meta.t_report_parameter_1
     WHERE report = 'GFK_Export'
      AND parameter_type = 'filter'
      AND parameter_name = 'wshop_cd')
   AND PV.prod_food_class_cd IN (SELECT parameter_value_char
     FROM ldl_dig_meta.t_report_parameter_1
     WHERE report = 'GFK_Export'
      AND parameter_type = 'filter'
      AND parameter_name = 'prod_food_class_cd')
   AND PV.prod_assortment_class_cd IN (SELECT parameter_value_char
     FROM ldl_dig_meta.t_report_parameter_1
     WHERE report = 'GFK_Export'
      AND parameter_type = 'filter'
      AND parameter_name = 'prod_assortment_class_cd')
   AND PBC.prod_gs1_lvl1_brick_cd IN (SELECT parameter_value_char
     FROM ldl_dig_meta.t_report_parameter_1
     WHERE report = 'GFK_Export'
      AND parameter_type = 'filter'
      AND parameter_name = 'prod_gs1_lvl1_brick_cd')), CTE_FACTS_ORDERS AS (SELECT COL.cust_order_dt,
   COL.wshop_cd,
   COL.prod_variant_sid,
   SUM(COL.prod_qty) AS prod_qty,
   SUM(COL.prod_price_gross_local_val / CER.exchange_rate) AS prod_price_gross_local_val
  FROM ldl_dig_core.t_fact_customer_order_line_1 AS COL
   LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate_1 AS CER ON COL.curr_cd = CER.from_curr_cd AND COL.cust_order_dt
       BETWEEN CER.active_from_dt AND CER.active_to_dt AND CER.curr_exchange_rate_type_cd = 'F' AND CER.to_curr_cd =
     'EUR'
  WHERE COL.is_part_of_bundle_pos_cnt_fg
   AND NOT COL.is_order_cancel_fg
  GROUP BY COL.cust_order_dt,
   COL.wshop_cd,
   COL.prod_variant_sid), CTE_FACTS_RETURNS AS (SELECT COR.cust_order_return_dt,
   COR.wshop_cd,
   COR.prod_variant_sid,
   SUM(COR.prod_qty) AS prod_qty,
   SUM(COR.prod_price_gross_local_val / CER0.exchange_rate) AS prod_price_gross_local_val
  FROM ldl_dig_core.t_fact_customer_return_line_1 AS COR
   LEFT JOIN ldl_dig_core.t_fact_currency_exchange_rate_1 AS CER0 ON COR.curr_cd = CER0.from_curr_cd AND COR.cust_order_dt
       BETWEEN CER0.active_from_dt AND CER0.active_to_dt AND CER0.curr_exchange_rate_type_cd = 'F' AND CER0.to_curr_cd =
     'EUR'
  GROUP BY COR.cust_order_return_dt,
   COR.wshop_cd,
   COR.prod_variant_sid), CTE_FACTS AS (SELECT COALESCE(col.cust_order_dt, cor.cust_order_return_dt) AS cal_dt,
   COALESCE(col.wshop_cd, cor.wshop_cd) AS wshop_cd,
   COALESCE(col.prod_variant_sid, cor.prod_variant_sid) AS prod_variant_sid,
   ROUND(CAST(IFNULL(col.prod_qty, 0) - IFNULL(cor.prod_qty, 0) AS BIGNUMERIC), 2) AS sales_qty_ac_ar,
   CAST(IFNULL(col.prod_price_gross_local_val, 0) - IFNULL(cor.prod_price_gross_local_val, 0) AS BIGNUMERIC) AS
   gross_sales_revenue_eur_ac_ar,
   CAST(IFNULL(IF(ROUND(SAFE_CAST(IFNULL(col.prod_qty, 0) - IFNULL(cor.prod_qty, 0) as BIGNUMERIC), 2) = 0, 0, SAFE_DIVIDE(SAFE_CAST(IFNULL(col.prod_price_gross_local_val, 0) - IFNULL(cor.prod_price_gross_local_val, 0) as BIGNUMERIC), ROUND(SAFE_CAST(IFNULL(col.prod_qty, 0) - IFNULL(cor.prod_qty, 0
           ) as BIGNUMERIC), 2))), 0) AS BIGNUMERIC) AS avg_sales_gross_unit_price_eur
  FROM CTE_FACTS_ORDERS AS col
   FULL JOIN CTE_FACTS_RETURNS AS cor ON col.wshop_cd = cor.wshop_cd AND col.cust_order_dt = cor.cust_order_return_dt
    AND col.prod_variant_sid = cor.prod_variant_sid) (SELECT dim.wshop_cd,
   facts.cal_dt,
   dim.prod_variant_nr,
   dim.main_ean_nr,
   dim.prod_variant_descr,
   dim.prod_subgroup_cd,
   dim.prod_subgroup_descr,
   dim.prod_family_cd,
   dim.prod_family_descr,
   dim.supplier_nr,
   dim.supplier_name,
   dim.brand_class_descr,
   dim.brand_name,
   facts.sales_qty_ac_ar,
   facts.gross_sales_revenue_eur_ac_ar,
   facts.avg_sales_gross_unit_price_eur
  FROM CTE_DIM AS dim
   INNER JOIN CTE_FACTS AS facts ON dim.wshop_cd = facts.wshop_cd AND dim.prod_variant_sid = facts.prod_variant_sid);