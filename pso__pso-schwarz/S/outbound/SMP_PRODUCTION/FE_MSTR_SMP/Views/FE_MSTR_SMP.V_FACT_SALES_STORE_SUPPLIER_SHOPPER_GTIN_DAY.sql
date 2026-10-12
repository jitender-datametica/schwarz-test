CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_sales_store_supplier_shopper_gtin_day (division_id, country_id
, division_country_ref, day_dt, store_id_ref, supplier_id_ref, shopper_id_ref, gtin_id, art_id_ref, art_id_ref_kl,
cy_week, cy_month, cy_year, sales_gross_val, sales_net_val, sales_piece_qty, discount_piece_qty) AS
/* LEFT OUTER JOIN SMP_PRODUCTION.CORE_REL.t_country LAND
ON
FACT.DIVISION_COUNTRY_REF = LAND.DIVISION_COUNTRY_REF
AND FACT.DIVISION_ID = LAND.DIVISION_ID
AND FACT.COUNTRY_ID = LAND.COUNTRY_ID */
SELECT FACT.division_id,
 FACT.country_id,
 FACT.division_country_ref,
 FACT.day_dt,
 FACT.store_id_ref,
 FACT.supplier_id_ref,
 FACT.shopper_id_ref,
 FACT.gtin_id,
 FACT.art_id_ref,
  CASE
  WHEN FACT.division_id = 'KFL'
  THEN ART.kl_art_id
  ELSE FACT.art_id_ref
  END AS art_id_ref_kl,
 FACT.cy_week,
 FACT.cy_month,
 FACT.cy_year,
 FACT.sales_gross_val,
 FACT.sales_net_val,
 FACT.sales_piece_qty,
 FACT.discount_piece_qty
FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day AS FACT
 LEFT JOIN smp_production_data_shared_kfl.dbp_data_art AS ART ON FACT.division_id = 'KFL' AND FACT.division_country_ref
      = ART.mandant_id AND FACT.art_id_ref = ART.art_id AND FACT.day_dt >= ART.dat_von AND FACT.day_dt <= ART.dat_bis;