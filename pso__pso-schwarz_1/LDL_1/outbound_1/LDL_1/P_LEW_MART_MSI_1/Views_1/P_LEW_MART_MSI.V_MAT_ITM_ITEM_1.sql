/* DescStart
 $Revision: 14708 $, $LastChangedBy: tbachmann $
 #  1.1  03.01.2025    Yeddulapalli, Bharat   AP0097106: ADO 703883: Nettogewicht
 SubjectAreas: Artikelstamm
 DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_itm_item_1 AS
/* bevorzugt DAT_VALID_FROM aus T_WAWI_ITM_ITEM_ACT_1 nehmen, damit bei Dummy_1 Artikeln (CASE_SIZE = -1) der spätere, aktualisierte Fachschlüssel hochgereicht wird */
/* posc.age_rating_cd, interpretieren, wenn daten da sind, Kennzeichen hÃÿngt an loc. MIN, MAX, AVG? */ SELECT COALESCE(ibr
  .brand_descr, WAWI.brand_1, '--') AS brand_1,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.buying_list_orderset_nr
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS buying_list_orderset_nr,
 CAST(COALESCE(WAWI.case_size_dec, umg.conv_to_base_numerator / CASE
     WHEN umg.conv_to_base_denominator = 0
     THEN NULL
     ELSE umg.conv_to_base_denominator
     END, umg2.conv_to_base_numerator, WAWI.case_size) AS NUMERIC) AS case_size,
 A.client_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.country_cd
  ELSE C3.src_country_lidl_cd
  END AS country_cd,
 COALESCE(WAWI.dat_valid_from, A.src_dat_valid_from, dwf1.src_dat_valid_from, dwf2.src_dat_valid_from, PARSE_DATE('%d.%m.%Y'
   , '31.12.9999')) AS dat_valid_from,
 CAST(A.item_sid AS BIGNUMERIC) AS item_id,
 ROUND(SAFE_CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd, A.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.orig_item_nr_int
  ELSE COALESCE(ROUND(SAFE_CAST(A.item_eks_cd AS BIGNUMERIC), 0), - 1)
  END AS orig_item_nr_int,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.add_docs_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS add_docs_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.additions
  ELSE '#NA#'
  END AS additions,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.age_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS age_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.beverage_tax
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS beverage_tax,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN COALESCE(WAWI.buyer_id, 9999)
  ELSE 1
  END AS buyer_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN COALESCE(WAWI.buyer_name, '--')
  ELSE '#NA#'
  END AS buyer_name,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN CAST(WAWI.buying_list_type_id AS BIGNUMERIC)
  ELSE CAST(CASE
    WHEN ibr.brand_type_mark = 'EM' AND ilt.list_type = 'A'
    THEN 8 /* Aktionsartikel EM */
    WHEN ibr.brand_type_mark = 'M' AND ilt.list_type = 'A'
    THEN 7 /* Aktionsartikel M */
    WHEN ibr.brand_type_mark = 'EM' AND ilt.list_type = 'S'
    THEN 2 /* Normalsortiment EM */
    WHEN ibr.brand_type_mark = 'M' AND ilt.list_type = 'S'
    THEN 1 /* Normalsortiment M */
    WHEN ibr.brand_type_mark = 'EM' AND ilt.list_type = '-'
    THEN - 2 /* EM ohne Listungsart */
    WHEN ibr.brand_type_mark = 'M' AND ilt.list_type = '-'
    THEN - 3 /* M ohne Listungsart */
    WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'A'
    THEN - 4 /* Aktionsartikel ohne Markenart */
    WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'S'
    THEN - 5 /* Normalsortiment ohne Markenart */
    ELSE - 1 /* Dummy_1-Artikelart */
    END AS BIGNUMERIC)
  END AS buying_list_type_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.buying_list_type_desc
  ELSE CASE
   WHEN ibr.brand_type_mark = 'EM' AND ilt.list_type = 'A'
   THEN 'Aktionsartikel EM'
   WHEN ibr.brand_type_mark = 'M' AND ilt.list_type = 'A'
   THEN 'Aktionsartikel M'
   WHEN ibr.brand_type_mark = 'EM' AND ilt.list_type = 'S'
   THEN 'Normalsortiment EM'
   WHEN ibr.brand_type_mark = 'M' AND ilt.list_type = 'S'
   THEN 'Normalsortiment M'
   WHEN ibr.brand_type_mark = 'EM' AND ilt.list_type = '-'
   THEN 'EM ohne Listungsart'
   WHEN ibr.brand_type_mark = 'M' AND ilt.list_type = '-'
   THEN 'M ohne Listungsart'
   WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'A'
   THEN 'Aktionsartikel ohne Markenart'
   WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'S'
   THEN 'Normalsortiment ohne Markenart'
   ELSE 'Dummy_1-Artikelart'
   END
  END AS buying_list_type_desc,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_dd
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_dd,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_depth
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_depth,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_euro
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_euro,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_height
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_height,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_layer
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_layer,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_plu_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_plu_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_volume
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_volume,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_weight
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_weight,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_width
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_width,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.commodity_cd
  ELSE '#NA#'
  END AS commodity_cd,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.consumption_tax_main_id
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS consumption_tax_main_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.consumption_tax_sub_id
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS consumption_tax_sub_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.cont_deposit_item_nr
  ELSE '#NA#'
  END AS cont_deposit_item_nr,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.contract_country_cd
  ELSE '#NA'
  END AS contract_country_cd,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.dangerous_goods_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS dangerous_goods_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.dat_adv
  ELSE snowconvert_public.int_to_date_udf(101)
  END AS dat_adv,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.dat_delisting
  ELSE snowconvert_public.int_to_date_udf(101)
  END AS dat_delisting,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.dat_listing
  ELSE snowconvert_public.int_to_date_udf(101)
  END AS dat_listing,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.dat_min_shelflifetest_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS dat_min_shelflifetest_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.delisting_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS delisting_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.delivery_temp
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS delivery_temp,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.direct_delete_mde_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS direct_delete_mde_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.discount_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS discount_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.dualsystem_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS dualsystem_fg,
 CAST(D0.dur_shelflife_day_cust AS BIGNUMERIC) AS dur_shelflife_day_cust,
 CAST(D0.dur_shelflife_day_store AS BIGNUMERIC) AS dur_shelflife_day_store,
 CAST(D0.dur_shelflife_day_wh AS BIGNUMERIC) AS dur_shelflife_day_wh,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.food_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS food_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.forwarding_item_nr
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS forwarding_item_nr,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.int_subitemgroup_id
  ELSE COALESCE(ROUND(SAFE_CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0), - 2000)
  END AS int_subitemgroup_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN COALESCE(WAWI.item_actiongroup_id, - 999)
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS item_actiongroup_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_familygroup_id
  ELSE COALESCE(K.src_familygrp_id, K.item_fam_grp_sid)
  END AS item_familygroup_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_parts
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS item_parts,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_parts_cd
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS item_parts_cd,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_plu_nr
  ELSE '#NA#'
  END AS item_plu_nr,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_short_desc_1
  ELSE '#NA#'
  END AS item_short_desc_1,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_short_desc_2
  ELSE '#NA#'
  END AS item_short_desc_2,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_short_desc_3
  ELSE '#NA#'
  END AS item_short_desc_3,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN COALESCE(WAWI.item_sub_actiongroup_id, - 999)
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS item_sub_actiongroup_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_text_1
  ELSE '#NA#'
  END AS item_text_1,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_text_2
  ELSE '#NA#'
  END AS item_text_2,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_text_3
  ELSE '#NA#'
  END AS item_text_3,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.item_version
  ELSE '#NA#'
  END AS item_version,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.lidl_buying_country_cd
  ELSE '#NA#'
  END AS lidl_buying_country_cd,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.listing_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS listing_fg,
 COALESCE(CASE
   WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
   THEN WAWI.logistic_unit_cd
   ELSE uom.logistic_unit_cd
   END, - 1) AS logistic_unit_cd,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.max_receive_temp
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS max_receive_temp,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.mdessp_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS mdessp_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.min_case_dd
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS min_case_dd,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.min_case_euro
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS min_case_euro,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.min_case_layer
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS min_case_layer,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.min_case_orderunit
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS min_case_orderunit,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.min_receive_temp
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS min_receive_temp,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.minus_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS minus_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.net_case_weight
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS net_case_weight,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.net_piece_weight
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS net_piece_weight,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.order_area_cd
  ELSE '#NA#'
  END AS order_area_cd,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.package_qty
  ELSE ROUND(CAST(uom.package_qty AS NUMERIC), 4)
  END AS package_qty,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.packagetype_desc
  ELSE '#NA#'
  END AS packagetype_desc,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.packing
  -- '-1' ist Anpasssung für Snowflake, da vom.packing String ist würde das Coalesce() mit -1 nicht funktionieren

  ELSE COALESCE(uom.packing, '-1')
  END AS packing,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.pct_consumption_tax
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS pct_consumption_tax,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.pct_discount
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS pct_discount,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.period_id_shelflife_cust
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS period_id_shelflife_cust,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.period_id_shelflife_store
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS period_id_shelflife_store,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.period_id_shelflife_wh
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS period_id_shelflife_wh,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.piece_depth
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS piece_depth,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.piece_height
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS piece_height,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.piece_volume
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS piece_volume,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.piece_weight
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS piece_weight,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.piece_width
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS piece_width,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.piece_net_weight_kg_meas
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS piece_net_weight,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.poster_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS poster_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.price_sign_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS price_sign_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.price_strip_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS price_strip_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.qty_consumption_tax_add
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS qty_consumption_tax_add,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.res_selltime
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS res_selltime,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.reusable_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS reusable_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.scale_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS scale_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.season_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS season_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.smallest_orderunit
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS smallest_orderunit,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.smallest_unit
  ELSE '#NA#'
  END AS smallest_unit,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.status_id_hq
  ELSE 4
  END AS status_id_hq,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.stock_capacity
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS stock_capacity,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.subitemgroup_id
  ELSE COALESCE(ROUND(SAFE_CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0), - 1000)
  END AS subitemgroup_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.tax_refund_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS tax_refund_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.taxation
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS taxation,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.type_cd
  ELSE '#NA#'
  END AS type_cd,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.type_receive_temp_fg
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS type_receive_temp_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.unitsize
  ELSE uom.unitsize
  END AS unitsize,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.val_consumption_tax
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS val_consumption_tax,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.val_deposit
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS val_deposit,
 COALESCE(h.vat_id, CASE
   WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
   THEN WAWI.vat_id
   ELSE NULL
   END) AS vat_id,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.wallow_nr
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS wallow_nr,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.weight
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS weight,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.weight_fg
  ELSE CAST(CASE
    WHEN UPPER(TRIM(I.src_msehi)) = 'KG'
    THEN 1
    ELSE 0
    END AS BIGNUMERIC)
  END AS weight_fg,
 CAST(CASE
   WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
   THEN WAWI.wg_fg
   ELSE CAST(- 1 AS BIGNUMERIC)
   END AS BIGNUMERIC) AS wg_fg,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.write_off
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS write_off,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.buyer_name_int
  ELSE '#NA#'
  END AS buyer_name_int,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.case_size_dec
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS case_size_dec,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.dur_shelflife_timeunits_cust
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS dur_shelflife_timeunits_cust,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.dur_shelflife_timeunits_store
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS dur_shelflife_timeunits_store,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.dur_shelflife_timeunits_wh
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS dur_shelflife_timeunits_wh,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.factor_period_cust
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS factor_period_cust,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.factor_period_store
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS factor_period_store,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.factor_period_wh
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS factor_period_wh,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.factor_shelflife_cust
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS factor_shelflife_cust,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.factor_shelflife_store
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS factor_shelflife_store,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.factor_shelflife_wh
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS factor_shelflife_wh,
  CASE
  WHEN CG.client_id IS NULL AND WAWI.client_id IS NOT NULL
  THEN WAWI.qty_min_piece_ordering
  ELSE '  '
  END AS qty_min_piece_ordering
FROM ldl_p_lew_core_ac.v_item_1 AS A
 LEFT JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS CG ON A.client_id = CG.client_id AND CURRENT_DATE BETWEEN CG.migration_dat_valid_from
   AND CG.migration_dat_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS B ON A.client_id = B.client_id AND A.item_sid = B.item_sid AND CURRENT_DATE
   BETWEEN B.dwh_valid_from AND B.dwh_valid_to
 LEFT JOIN (SELECT A0.client_id,
   A0.item_sid,
   B0.src_dat_valid_from
  FROM ldl_p_lew_core_ac.v_item_1 AS A0
   INNER JOIN ldl_p_lew_core_ac.v_item_1 AS B0 ON A0.client_id = B0.client_id AND B0.item_sid_config = COALESCE(A0.item_sid_config
       , A0.item_sid) AND B0.src_dat_valid_from IS NOT NULL
  WHERE NOT EXISTS (SELECT 1
    FROM ldl_p_lew_core_ac.v_item_1 AS C
    WHERE client_id = A0.client_id
     AND item_sid_config = COALESCE(A0.item_sid_config, A0.item_sid)
     AND (src_dat_valid_from > A0.src_dat_valid_from OR src_dat_valid_from = A0.src_dat_valid_from AND item_sid > A0.item_sid
          ))) AS dwf1 ON A.client_id = dwf1.client_id AND A.item_sid = dwf1.item_sid
 LEFT JOIN (SELECT client_id,
   ROUND(SAFE_CAST(src_orig_item_nr AS BIGNUMERIC), 0) AS origi,
   MAX(src_dat_valid_from) AS src_dat_valid_from
  FROM ldl_p_lew_core_ac.v_item_1 AS C
  WHERE src_dat_valid_from IS NOT NULL
   AND CAST(src_case_size AS FLOAT64) >= 0
  GROUP BY client_id,
   origi) AS dwf2 ON A.client_id = dwf2.client_id AND dwf2.origi = ROUND(SAFE_CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd
       , A.src_matnr) AS BIGNUMERIC), 0) AND A.log_var_cd IS NOT NULL
 LEFT JOIN (SELECT UM.client_id,
   UM.item_sid,
   UM.log_var_cd,
   UMH.conv_to_base_numerator,
   UMH.conv_to_base_denominator
  FROM ldl_p_lew_core_ac.v_item_unit_of_measurement_1 AS UM
   INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist_1 AS UMH ON UM.client_id = UMH.client_id AND UM.item_sid =
        UMH.item_sid AND UM.uom_sid = UMH.uom_sid AND CURRENT_DATE BETWEEN UMH.dwh_valid_from AND UMH.dwh_valid_to AND
     UMH.deleted_fg = 0
  WHERE UM.log_var_cd IS NOT NULL
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(UM.client_id AS STRING), CAST(UM.item_sid AS STRING), UM.log_var_cd
      ORDER BY UMH.conv_to_base_numerator IS NULL, UMH.conv_to_base_numerator, UMH.conv_to_base_denominator IS NULL, UMH
        .conv_to_base_denominator)) = 1) AS umg ON A.client_id = umg.client_id AND A.item_sid = umg.item_sid AND A.log_var_cd
     = umg.log_var_cd AND (A.log_var_cd <> '1' OR A.config_item_cd IS NOT NULL)
 LEFT JOIN (SELECT UM0.client_id,
   UM0.item_sid,
   0 AS conv_to_base_numerator
  FROM ldl_p_lew_core_ac.v_item_unit_of_measurement_1 AS UM0
   INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist_1 AS UMH0 ON UM0.client_id = UMH0.client_id AND UM0.item_sid
         = UMH0.item_sid AND UM0.uom_sid = UMH0.uom_sid AND CURRENT_DATE BETWEEN UMH0.dwh_valid_from AND UMH0.dwh_valid_to
       AND UMH0.deleted_fg = 0
  WHERE UM0.log_var_cd IS NOT NULL
  GROUP BY UM0.client_id,
   UM0.item_sid) AS umg2 ON A.client_id = umg2.client_id AND A.item_sid = umg2.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_1 AS MKEY ON A.client_id = MKEY.client_id AND A.item_sid = MKEY.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_1 AS WAWI ON MKEY.client_id = WAWI.client_id AND MKEY.item_sid_map = WAWI
   .item_sid
 LEFT JOIN (SELECT t16.client_id,
   t16.item_sid,
   t16.brand_sid,
   t16.brand_type_mark,
   t16.brand_descr
  FROM (SELECT A1.client_id,
     A1.item_sid,
     A1.brand_sid,
     A1.brand_type_mark,
     D.brand_descr,
     COUNT(*) AS counti
    FROM ldl_p_lew_core_ac.v_item_location_brand_hist_1 AS A1
     INNER JOIN ldl_p_lew_core_ac.v_location_1 AS B1 ON A1.loc_sid = B1.loc_sid AND B1.wh_store_mark = 'A' AND B1.global_loc_type_cd
        = '0'
     INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS C1 ON B1.loc_sid = C1.loc_sid AND C1.demand_plan_active_fg = 1 AND
        CURRENT_DATE BETWEEN C1.dwh_valid_from AND C1.dwh_valid_to AND C1.deleted_fg = 0
     LEFT JOIN ldl_p_lew_core_ac.v_brand_1 AS DX ON A1.client_id = DX.client_id AND A1.brand_sid = DX.brand_sid
     LEFT JOIN ldl_p_lew_core_ac.v_client_1 AS CLI ON A1.client_id = CLI.client_id
     LEFT JOIN ldl_p_lew_core_ac.v_country_1 AS CTRY ON CLI.country_sid = CTRY.country_sid
     LEFT JOIN ldl_p_lew_core_ac.v_brand_descr_1 AS D ON A1.client_id = D.client_id AND A1.brand_sid = D.brand_sid AND
       CTRY.lang_sid = D.lang_sid
    WHERE CURRENT_DATE BETWEEN A1.dwh_valid_from AND A1.dwh_valid_to
     AND A1.deleted_fg = 0
    GROUP BY A1.client_id,
     A1.item_sid,
     A1.brand_sid,
     A1.brand_type_mark,
     D.brand_descr
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A1.client_id AS STRING), CAST(A1.item_sid AS STRING) ORDER BY counti
          IS NULL, counti, CASE
           WHEN D.brand_descr = '-'
           THEN 2
           ELSE 1
           END IS NULL DESC, CASE
           WHEN D.brand_descr = '-'
           THEN 2
           ELSE 1
           END DESC)) = 1) AS t16) AS ibr ON A.client_id = ibr.client_id AND A.item_sid = ibr.item_sid
 LEFT JOIN (SELECT t22.client_id,
   t22.item_sid,
   t22.list_type
  FROM (SELECT A2.client_id,
     A2.item_sid,
     COALESCE(A2.list_type_mark, '-') AS list_type,
     COUNT(*) AS counti
    FROM ldl_p_lew_core_ac.v_item_listing_type_hist_1 AS A2
     INNER JOIN ldl_p_lew_core_ac.v_location_1 AS B2 ON A2.loc_sid = B2.loc_sid AND B2.wh_store_mark = 'A' AND B2.global_loc_type_cd
        = '0'
     INNER JOIN ldl_p_lew_core_ac.v_location_hist_1 AS C2 ON B2.loc_sid = C2.loc_sid AND C2.demand_plan_active_fg = 1 AND
        CURRENT_DATE BETWEEN C2.dwh_valid_from AND C2.dwh_valid_to AND C2.deleted_fg = 0
    WHERE CURRENT_DATE BETWEEN A2.dwh_valid_from AND A2.dwh_valid_to
     AND A2.deleted_fg = 0
    GROUP BY A2.client_id,
     A2.item_sid,
     list_type
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A2.client_id AS STRING), CAST(A2.item_sid AS STRING) ORDER BY counti
          IS NULL, counti)) = 1) AS t22) AS ilt ON A.client_id = ilt.client_id AND A.item_sid = ilt.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS C3 ON A.client_id = C3.client_id
 LEFT JOIN ldl_p_lew_bil_ac.v_item_shelflife_1 AS D0 ON A.client_id = D0.client_id AND A.item_sid = D0.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_item_group_1 AS E ON B.client_id = E.client_id AND B.item_grp_sid = E.item_grp_sid
 LEFT JOIN ldl_p_lew_core_ac.v_packaging_type_1 AS F ON B.client_id = F.client_id AND B.pack_type_sid = F.pack_type_sid
 LEFT JOIN (SELECT vat_id,
   client_id,
   item_sid
  FROM ldl_p_lew_bil_ac.v_item_vat_1
  WHERE dat_calendar = CURRENT_DATE
  GROUP BY client_id,
   item_sid,
   vat_id) AS h ON A.client_id = h.client_id AND A.item_sid = h.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_unit_of_measurement_1 AS I ON B.client_id = I.client_id AND B.uom_sid_base = I.uom_sid
 LEFT JOIN ldl_p_lew_core_ac.v_map_mis_logistic_unit_1 AS J ON B.client_id = J.client_id AND B.uom_cd_packaging = J.uom_cd
   
 LEFT JOIN ldl_p_lew_core_ac.v_item_hist_1 AS BB ON A.client_id = BB.client_id AND BB.item_sid = COALESCE(A.item_sid_config
     , A.item_sid) AND CURRENT_DATE BETWEEN BB.dwh_valid_from AND BB.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_1 AS K ON BB.client_id = K.client_id AND BB.item_fam_grp_sid = K.item_fam_grp_sid
   
 LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_1 AS KH ON BB.client_id = KH.client_id AND BB.item_fam_grp_sid = KH.item_fam_grp_sid
     AND CURRENT_DATE BETWEEN KH.dwh_valid_from AND KH.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_subitemgroup_1 AS SIG ON KH.client_id = SIG.client_id AND KH.sub_item_grp_sid = SIG.sub_item_grp_sid
   
 LEFT JOIN (SELECT client_id,
   item_sid,
   package_qty,
   packing,
   logistic_unit_cd,
   unitsize
  FROM (SELECT A3.client_id,
     A3.item_sid,
      D1.gross_content_val * D1.pack_cont_qty AS package_qty,
     H.pack_type_descr AS packing,
     E0.mis_logistic_unit_cd AS logistic_unit_cd,
      CASE
      WHEN D1.gross_content_val <> 1
      THEN TRIM(SUBSTR(CAST(D1.gross_content_val /* Warning, Format 'FN9' removed, semantic information not found. */ AS STRING)
           , 1, 19)) || 'x' || TRIM(SUBSTR(CAST(D1.pack_cont_qty /* Warning, Format 'FN9' removed, semantic information not found. */ AS STRING)
          , 1, 19)) || CAST(U.src_msehi AS STRING)
      ELSE TRIM(SUBSTR(CAST(D1.pack_cont_qty /* Warning, Format 'FN9' removed, semantic information not found. */ AS STRING)
         , 1, 19)) || CAST(U.src_msehi AS STRING)
      END AS unitsize,
     COUNT(*) OVER (PARTITION BY CAST(A3.client_id AS STRING), CAST(A3.item_sid AS STRING), CAST(D1.gross_content_val * D1.pack_cont_qty AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_package_qty
    FROM ldl_p_lew_core_ac.v_item_sort_box_hist_1 AS A3
     INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS B3 ON A3.client_id = B3.client_id AND A3.item_sid = B3.item_sid AND
       CURRENT_DATE BETWEEN B3.dwh_valid_from AND B3.dwh_valid_to
     INNER JOIN ldl_p_lew_core_ac.v_item_bom_1 AS M ON A3.client_id = M.client_id AND A3.item_sid_sort_box = M.item_sid
     INNER JOIN ldl_p_lew_core_ac.v_item_bom_pos_hist_1 AS C4 ON M.client_id = C4.client_id AND M.item_bom_sid = C4.item_bom_sid
       
     INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS D1 ON C4.client_id = D1.client_id AND C4.item_sid = D1.item_sid AND
       CURRENT_DATE BETWEEN D1.dwh_valid_from AND D1.dwh_valid_to
     LEFT JOIN ldl_p_lew_core_ac.v_unit_of_measurement_1 AS U ON D1.client_id = U.client_id AND D1.uom_sid_packaging = U.uom_sid
       
     LEFT JOIN ldl_p_lew_core_ac.v_map_mis_logistic_unit_1 AS E0 ON D1.client_id = E0.client_id AND D1.uom_cd_packaging =
       E0.uom_cd
     INNER JOIN ldl_p_lew_core_ac.v_client_1 AS F0 ON D1.client_id = F0.client_id
     INNER JOIN ldl_p_lew_core_ac.v_country_1 AS G ON F0.country_sid = G.country_sid
     LEFT JOIN ldl_p_lew_core_ac.v_packaging_type_descr_1 AS H ON D1.client_id = H.client_id AND D1.pack_type_sid = H.pack_type_sid
         AND G.lang_sid = H.lang_sid
    WHERE CURRENT_DATE BETWEEN A3.dwh_valid_from AND A3.dwh_valid_to) AS t29
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(t29.client_id AS STRING), CAST(t29.item_sid AS STRING) ORDER BY t29.cnt_package_qty
        IS NULL, t29.cnt_package_qty, t29.package_qty IS NULL, t29.package_qty)) = 1) AS uom ON A.client_id = uom.client_id
    AND A.item_sid = uom.item_sid;
