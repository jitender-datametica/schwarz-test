/* Used for Artikelstamm dossier.
	MSTR does not CROSS JOIN the 5 tables with full outer CROSS JOIN.
	In order to not lose any data, this view is created. */
CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_article_master_2 AS
-- a similar column also exists coming from FACT_PPSIGV
 -- a similar column also exists coming from FACT_PPSIGV

-- this section is kept for a transition period. it can be removed once the MSTR reports referencing this view have switched to using the new columns

-- end section

-- data for this column is only available for GC. because FACT_PPS contains additional columns that we always want to see (SUPPLIER_SID), we cannot filter in the CROSS JOIN, so we do it here (NBI-5555)

-- data for this column is only available for GC. because FACT_PPS contains additional columns that we always want to see (SUPPLIER_SID), we cannot filter in the CROSS JOIN, so we do it here (NBI-5555)

-- this section is kept for a transition period. it can be removed once the MSTR reports referencing this view have switched to using the new columns

-- end section

-- this section is kept for a transition period. it can be removed once the MSTR reports referencing this view have switched to using the new columns

-- end section

-- AND FACT_PPS.GC_LC_CD = COALESCE(FACT_PPC.GC_LC_CD, FACT_PPSIGV.GC_LC_CD) -- FACT_PPS contains data that we always want to see (SUPPLIER_SID) and prices we only want to see if GC_LC_CD = 'GC'. To achieve this, we filter the prices above. (NBI-5555)

SELECT COALESCE(FACT_PA.wshop_cd, REL_PVA.wshop_cd, FACT_PPC.wshop_cd, FACT_PPSIGV.wshop_cd, FACT_PPS.wshop_cd) AS
 wshop_cd,
 FACT_PA.cal_dt AS cal_dt_product_availability,
 COALESCE(FACT_PA.prod_variant_sid, REL_PVA.prod_variant_sid, FACT_PPC.prod_variant_sid, FACT_PPSIGV.prod_variant_sid,
  FACT_PPS.prod_variant_sid) AS prod_variant_sid,
 COALESCE(FACT_PA.prod_variant_nr, REL_PVA.prod_variant_nr) AS prod_variant_nr,
 FACT_PA.is_orderable_fg,
 FACT_PA.is_visible_fg,
 IF(FACT_PA.is_replenishment_considered_fg IS NULL, NULL, IF(FACT_PA.is_replenishment_considered_fg, 'YES', 'NO')) AS
 is_replenishment_considered_fg,
 FACT_PA.is_avail_in_store_fg,
 FACT_PA.is_in_stock_fg,
 FACT_PA.avail_lvl,
 FACT_PA.prod_orderable_lvl_cd,
 FACT_PA.src_catalog_name,
 FACT_PA.is_in_promo_fg,
 FACT_PA.max_order_qty,
 FACT_PA.total_stock_qty,
 FACT_PA.locale_name,
 FACT_PA.is_legacy_fg,
 FACT_PA.is_sold_out_fg,
 REL_PVA.reg_prod_variant_name,
 REL_PVA.reg_prod_variant_descr,
 IFNULL(REL_PVA.prod_sid, -1) AS prod_sid,
 IFNULL(REL_PVA.prod_nr, '-1') AS prod_nr,
 REL_PVA.reg_prod_name,
 REL_PVA.prod_tgt_delivery_time,
 IFNULL(REL_PVA.tax_class_cd, '-1') AS tax_class_cd,
 REL_PVA.material_pos_type_cd,
 REL_PVA.delivery_src_type_cd,
 IFNULL(REL_PVA.shop_cat_sid, -1) AS shop_cat_sid,
 REL_PVA.shop_cat_name,
 IFNULL(REL_PVA.shop_cat_lvl4_sid, -1) AS shop_cat_lvl4_sid,
 REL_PVA.shop_cat_lvl4_name,
 IFNULL(REL_PVA.shop_cat_lvl3_sid, -1) AS shop_cat_lvl3_sid,
 REL_PVA.shop_cat_lvl3_name,
 IFNULL(REL_PVA.shop_cat_lvl2_sid, -1) AS shop_cat_lvl2_sid,
 REL_PVA.shop_cat_lvl2_name,
 IFNULL(REL_PVA.shop_cat_lvl1_sid, -1) AS shop_cat_lvl1_sid,
 REL_PVA.shop_cat_lvl1_name,
 IFNULL(REL_PVA.prod_online_status_cd, '-1') AS prod_online_status_cd,
 IFNULL(REL_PVA.prod_listing_status_cd, '-1') AS prod_listing_status_cd,
 FACT_PPC.tax_class_pct,
 IFNULL(FACT_PPC.curr_cd, '-1') AS product_pricing_condition_curr_cd,
 FACT_PPC.vkp_price_gross_val,
 FACT_PPC.vkp_price_net_val,
 FACT_PPC.akp_price_gross_val,
 FACT_PPC.akp_price_net_val,
 FACT_PPC.uvp_price_gross_val,
 FACT_PPC.stp_price_gross_val,
 FACT_PPC.vkz1_price_gross_val,
 FACT_PPC.vkz2_price_gross_val,
 FACT_PPC.ivp_price_gross_val,
 FACT_PPC.zvp_price_gross_val,
 IFNULL(FACT_PPC.vkp_curr_cd, '-1') AS vkp_curr_cd,
 FACT_PPC.vkp_price_gross_local_val,
 FACT_PPC.vkp_price_gross_eur_val,
 FACT_PPC.vkp_price_net_local_val,
 FACT_PPC.vkp_price_net_eur_val,
 IFNULL(FACT_PPC.akp_curr_cd, '-1') AS akp_curr_cd,
 FACT_PPC.akp_price_gross_local_val,
 FACT_PPC.akp_price_gross_eur_val,
 FACT_PPC.akp_price_net_local_val,
 FACT_PPC.akp_price_net_eur_val,
 IFNULL(FACT_PPC.uvp_curr_cd, '-1') AS uvp_curr_cd,
 FACT_PPC.uvp_price_gross_local_val,
 FACT_PPC.uvp_price_gross_eur_val,
 IFNULL(FACT_PPC.stp_curr_cd, '-1') AS stp_curr_cd,
 FACT_PPC.stp_price_gross_local_val,
 FACT_PPC.stp_price_gross_eur_val,
 IFNULL(FACT_PPC.vkz1_curr_cd, '-1') AS vkz1_curr_cd,
 FACT_PPC.vkz1_price_gross_local_val,
 FACT_PPC.vkz1_price_gross_eur_val,
 IFNULL(FACT_PPC.vkz2_curr_cd, '-1') AS vkz2_curr_cd,
 FACT_PPC.vkz2_price_gross_local_val,
 FACT_PPC.vkz2_price_gross_eur_val,
 IFNULL(FACT_PPC.ivp_curr_cd, '-1') AS ivp_gross_curr_cd,
 FACT_PPC.ivp_price_gross_local_val,
 FACT_PPC.ivp_price_gross_eur_val,
 IFNULL(FACT_PPC.zvp_curr_cd, '-1') AS zvp_curr_cd,
 FACT_PPC.zvp_price_gross_local_val,
 FACT_PPC.zvp_price_gross_eur_val,
 FACT_PPSIGV.cal_dt AS cal_dt_product_price_sale_ivp_gld_vkp,
 IFNULL(FACT_PPSIGV.curr_cd, '-1') AS gld_curr_cd,
 FACT_PPSIGV.gld_price_net_val,
 IFNULL(FACT_PPSIGV.curr_cd, '-1') AS ivp_net_curr_cd,
 FACT_PPSIGV.ivp_price_net_val,
 IFNULL(FACT_PPSIGV.curr_cd, '-1') AS last_vkp_curr_cd,
 FACT_PPSIGV.vkp_price_net_val AS last_vkp_price_net_val,
 FACT_PPSIGV.vkp_price_gross_val AS last_vkp_price_gross_val,
 IFNULL(FACT_PPS.supplier_sid, -1) AS supplier_sid,
 IF(COALESCE(FACT_PPC.gc_lc_cd, FACT_PPSIGV.gc_lc_cd, FACT_PPS.gc_lc_cd) = 'GC', FACT_PPS.ekp_price_val, NULL) AS
 ekp_price_val,
 IF(COALESCE(FACT_PPC.gc_lc_cd, FACT_PPSIGV.gc_lc_cd, FACT_PPS.gc_lc_cd) = 'GC', FACT_PPS.fkz_price_val, NULL) AS
 fkz_price_val,
 FACT_PPS.ekp_price_eur_val,
 FACT_PPS.fkz_price_eur_val,
 COALESCE(FACT_PPC.gc_lc_cd, FACT_PPSIGV.gc_lc_cd, FACT_PPS.gc_lc_cd, 'GC') AS gc_lc_cd,
 FACT_PPSIGV.gld_price_net_eur_val,
 FACT_PPSIGV.gld_price_net_local_val,
 FACT_PPSIGV.ivp_price_net_eur_val,
 FACT_PPSIGV.ivp_price_net_local_val,
 FACT_PPSIGV.vkp_price_net_local_val AS last_vkp_price_net_local_val,
 FACT_PPSIGV.vkp_price_net_eur_val AS last_vkp_price_net_eur_val,
 FACT_PPSIGV.vkp_price_gross_local_val AS last_vkp_price_gross_local_val,
 FACT_PPSIGV.vkp_price_gross_eur_val AS last_vkp_price_gross_eur_val
FROM ldl_dig_fe_mstr_lidldigital.v_fact_product_availability_active_2 AS FACT_PA
 FULL JOIN ldl_dig_fe_mstr_lidldigital.v_rel_product_variant_regional_2 AS REL_PVA ON FACT_PA.prod_variant_sid = REL_PVA.prod_variant_sid
    AND FACT_PA.wshop_cd = REL_PVA.wshop_cd
 FULL JOIN ldl_dig_fe_mstr_lidldigital.v_fact_product_pricing_condition_2 AS FACT_PPC ON FACT_PPC.prod_variant_sid =
   COALESCE(FACT_PA.prod_variant_sid, REL_PVA.prod_variant_sid) AND FACT_PPC.wshop_cd = COALESCE(FACT_PA.wshop_cd,
    REL_PVA.wshop_cd)
 FULL JOIN ldl_dig_fe_mstr_lidldigital.v_fact_product_price_sale_ivp_gld_vkp_2 AS FACT_PPSIGV ON FACT_PPSIGV.prod_variant_sid
     = COALESCE(FACT_PA.prod_variant_sid, REL_PVA.prod_variant_sid, FACT_PPC.prod_variant_sid) AND FACT_PPSIGV.wshop_cd
    = COALESCE(FACT_PA.wshop_cd, REL_PVA.wshop_cd, FACT_PPC.wshop_cd) AND FACT_PPC.gc_lc_cd = FACT_PPSIGV.gc_lc_cd
 FULL JOIN ldl_dig_fe_mstr_lidldigital.v_fact_product_price_supplier_2 AS FACT_PPS ON FACT_PPS.prod_variant_sid = COALESCE(FACT_PA
    .prod_variant_sid, REL_PVA.prod_variant_sid, FACT_PPC.prod_variant_sid, FACT_PPSIGV.prod_variant_sid) AND FACT_PPS.wshop_cd
    = COALESCE(FACT_PA.wshop_cd, REL_PVA.wshop_cd, FACT_PPC.wshop_cd, FACT_PPSIGV.wshop_cd);