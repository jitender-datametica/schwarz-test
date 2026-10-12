CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ITM_ITEM_2 AS
/*
 DescStart
 $Revision: 14708 $, $LastChangedBy: tbachmann $
 #  1.1  03.01.2025    Yeddulapalli, Bharat   AP0097106: ADO 703883: Nettogewicht
 SubjectAreas: Artikelstamm
 DescEnd
 */
SELECT
  COALESCE(ibr.brand_descr, wawi.brand_2, '--') AS brand_2
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.buying_list_orderset_nr
    ELSE CAST(-1 AS INTEGER)
    END AS buying_list_orderset_nr
  , CAST(
      COALESCE(
        wawi.case_size_dec
        , umg.conv_to_base_numerator / CASE WHEN umg.conv_to_base_denominator = 0 THEN NULL ELSE umg.conv_to_base_denominator END
        , umg2.conv_to_base_numerator
        , wawi.case_size
      ) AS DECIMAL(9, 4)
    ) AS case_size
  , a.client_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.country_cd
    ELSE c.src_country_lidl_cd
    END AS country_cd
  , COALESCE(
      wawi.dat_valid_from
      , a.src_dat_valid_from
      , dwf1.src_dat_valid_from
      , dwf2.src_dat_valid_from
      , TO_DATE('31.12.9999', 'dd.mm.yyyy')
    ) AS dat_valid_from
    /* bevorzugt DAT_VALID_FROM aus T_WAWI_ITM_ITEM_ACT_2 nehmen, damit bei Dummy_2 Artikeln (CASE_SIZE = -1) der spätere, aktualisierte Fachschlüssel hochgereicht wird */
  , CAST(a.item_sid AS DECIMAL(18, 0)) AS item_id
  , TRY_CAST(
      COALESCE(
        a.src_orig_item_nr
        , a.config_item_cd
        , a.src_matnr
      ) AS DECIMAL(18, 0)
    ) AS orig_item_nr
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.orig_item_nr_int
    ELSE COALESCE(TRY_CAST(a.item_eks_cd AS DECIMAL(9, 0)), -1)
    END AS orig_item_nr_int
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.add_docs_fg
    ELSE -1
    END AS add_docs_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.additions
    ELSE '#NA#'
    END AS additions
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.age_fg
    ELSE -1
    END AS age_fg
  /* posc.age_rating_cd, interpretieren, wenn daten da sind, Kennzeichen hÃÿngt an loc. MIN, MAX, AVG? */
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.beverage_tax
    ELSE -1
    END AS beverage_tax
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN COALESCE(wawi.buyer_id, 9999)
    ELSE 1
    END AS buyer_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN COALESCE(wawi.buyer_name, '--')
    ELSE '#NA#'
    END AS buyer_name
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN CAST(wawi.buying_list_type_id AS SMALLINT)
    ELSE CASE
      WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'A' THEN 8
      /* Aktionsartikel EM              */
      WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'A' THEN 7
      /* Aktionsartikel M               */
      WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'S' THEN 2
      /* Normalsortiment EM             */
      WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'S' THEN 1
      /* Normalsortiment M              */
      WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = '-' THEN -2
      /* EM ohne Listungsart            */
      WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = '-' THEN -3
      /* M ohne Listungsart             */
      WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'A' THEN -4
      /* Aktionsartikel ohne Markenart  */
      WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'S' THEN -5
      /* Normalsortiment ohne Markenart */
      ELSE -1
      /* Dummy_2-Artikelart               */
      END
    END AS buying_list_type_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.buying_list_type_desc
    ELSE CASE
      WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'A' THEN 'Aktionsartikel EM'
      WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'A' THEN 'Aktionsartikel M'
      WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'S' THEN 'Normalsortiment EM'
      WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'S' THEN 'Normalsortiment M'
      WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = '-' THEN 'EM ohne Listungsart'
      WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = '-' THEN 'M ohne Listungsart'
      WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'A' THEN 'Aktionsartikel ohne Markenart'
      WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'S' THEN 'Normalsortiment ohne Markenart'
      ELSE 'Dummy_2-Artikelart'
      END
    END AS buying_list_type_desc
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_dd
    ELSE -1
    END AS case_dd
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_depth
    ELSE -1
    END AS case_depth
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_euro
    ELSE -1
    END AS case_euro
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_height
    ELSE -1
    END AS case_height
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_layer
    ELSE -1
    END AS case_layer
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_plu_fg
    ELSE -1
    END AS case_plu_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_volume
    ELSE -1
    END AS case_volume
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_weight
    ELSE -1
    END AS case_weight
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_width
    ELSE -1
    END AS case_width
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.commodity_cd
    ELSE '#NA#'
    END AS commodity_cd
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.consumption_tax_main_id
    ELSE -1
    END AS consumption_tax_main_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.consumption_tax_sub_id
    ELSE -1
    END AS consumption_tax_sub_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.cont_deposit_item_nr
    ELSE '#NA#'
    END AS cont_deposit_item_nr
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.contract_country_cd
    ELSE '#NA'
    END AS contract_country_cd
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.dangerous_goods_fg
    ELSE -1
    END AS dangerous_goods_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.dat_adv
    ELSE SNOWCONVERT.PUBLIC.INT_TO_DATE_UDF(101)
    END AS dat_adv
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.dat_delisting
    ELSE SNOWCONVERT.PUBLIC.INT_TO_DATE_UDF(101)
    END AS dat_delisting
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.dat_listing
    ELSE SNOWCONVERT.PUBLIC.INT_TO_DATE_UDF(101)
    END AS dat_listing
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.dat_min_shelflifetest_fg
    ELSE -1
    END AS dat_min_shelflifetest_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.delisting_fg
    ELSE -1
    END AS delisting_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.delivery_temp
    ELSE -1
    END AS delivery_temp
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.direct_delete_mde_fg
    ELSE -1
    END AS direct_delete_mde_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.discount_fg
    ELSE -1
    END AS discount_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.dualsystem_fg
    ELSE -1
    END AS dualsystem_fg
  , CAST(d.dur_shelflife_day_cust AS INTEGER) AS dur_shelflife_day_cust
  , CAST(d.dur_shelflife_day_store AS INTEGER) AS dur_shelflife_day_store
  , CAST(d.dur_shelflife_day_wh AS INTEGER) AS dur_shelflife_day_wh
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.food_fg
    ELSE -1
    END AS food_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.forwarding_item_nr
    ELSE -1
    END AS forwarding_item_nr
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.int_subitemgroup_id
    ELSE COALESCE(
      TRY_CAST(sig.src_subitemgrp_cd AS INTEGER)
      , -2000
    )
    END AS int_subitemgroup_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN COALESCE(wawi.item_actiongroup_id, -999)
    ELSE -1
    END AS item_actiongroup_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_familygroup_id
    ELSE COALESCE(k.src_familygrp_id, k.item_fam_grp_sid)
    END AS item_familygroup_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_parts
    ELSE -1
    END AS item_parts
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_parts_cd
    ELSE -1
    END AS item_parts_cd
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_plu_nr
    ELSE '#NA#'
    END AS item_plu_nr
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_short_desc_1
    ELSE '#NA#'
    END AS item_short_desc_1
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_short_desc_2
    ELSE '#NA#'
    END AS item_short_desc_2
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_short_desc_3
    ELSE '#NA#'
    END AS item_short_desc_3
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN COALESCE(wawi.item_sub_actiongroup_id, -999)
    ELSE -1
    END AS item_sub_actiongroup_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_text_1
    ELSE '#NA#'
    END AS item_text_1
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_text_2
    ELSE '#NA#'
    END AS item_text_2
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_text_3
    ELSE '#NA#'
    END AS item_text_3
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.item_version
    ELSE '#NA#'
    END AS item_version
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.lidl_buying_country_cd
    ELSE '#NA#'
    END AS lidl_buying_country_cd
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.listing_fg
    ELSE -1
    END AS listing_fg
  , COALESCE(
      CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
      THEN wawi.logistic_unit_cd
      ELSE uom.logistic_unit_cd
      END
    , -1
    ) AS logistic_unit_cd
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.max_receive_temp
    ELSE -1
    END AS max_receive_temp
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.mdessp_fg
    ELSE -1
    END AS mdessp_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.min_case_dd
    ELSE -1
    END AS min_case_dd
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.min_case_euro
    ELSE -1
    END AS min_case_euro
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.min_case_layer
    ELSE -1
    END AS min_case_layer
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.min_case_orderunit
    ELSE -1
    END AS min_case_orderunit
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.min_receive_temp
    ELSE -1
    END AS min_receive_temp
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.minus_fg
    ELSE -1
    END AS minus_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.net_case_weight
    ELSE -1
    END AS net_case_weight
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.net_piece_weight
    ELSE -1
    END AS net_piece_weight
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.order_area_cd
    ELSE '#NA#'
    END AS order_area_cd
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.package_qty
    ELSE CAST(uom.package_qty AS DECIMAL(18, 4))
    END AS package_qty
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.packagetype_desc
    ELSE '#NA#'
    END AS packagetype_desc
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.packing
    -- '-1' ist Anpasssung für Snowflake, da vom.packing String ist würde das Coalesce() mit -1 nicht funktionieren
    ELSE COALESCE(uom.packing, '-1')
    END AS packing
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.pct_consumption_tax
    ELSE -1
    END AS pct_consumption_tax
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.pct_discount
    ELSE -1
    END AS pct_discount
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.period_id_shelflife_cust
    ELSE -1
    END AS period_id_shelflife_cust
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.period_id_shelflife_store
    ELSE -1
    END AS period_id_shelflife_store
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.period_id_shelflife_wh
    ELSE -1
    END AS period_id_shelflife_wh
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.piece_depth
    ELSE -1
    END AS piece_depth
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.piece_height
    ELSE -1
    END AS piece_height
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.piece_volume
    ELSE -1
    END AS piece_volume
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.piece_weight
    ELSE -1
    END AS piece_weight
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.piece_width
    ELSE -1
    END AS piece_width
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.piece_net_weight_kg_meas
    ELSE -1
    END AS piece_net_weight
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.poster_fg
    ELSE -1
    END AS poster_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.price_sign_fg
    ELSE -1
    END AS price_sign_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.price_strip_fg
    ELSE -1
    END AS price_strip_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.qty_consumption_tax_add
    ELSE -1
    END AS qty_consumption_tax_add
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.res_selltime
    ELSE -1
    END AS res_selltime
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.reusable_fg
    ELSE -1
    END AS reusable_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.scale_fg
    ELSE -1
    END AS scale_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.season_fg
    ELSE -1
    END AS season_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.smallest_orderunit
    ELSE -1
    END AS smallest_orderunit
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.smallest_unit
    ELSE '#NA#'
    END AS smallest_unit
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.status_id_hq
    ELSE 4
    END AS status_id_hq
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.stock_capacity
    ELSE -1
    END AS stock_capacity
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.subitemgroup_id
    ELSE COALESCE(
      TRY_CAST(sig.src_subitemgrp_cd AS INTEGER)
      , -1000
    )
    END AS subitemgroup_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.tax_refund_fg
    ELSE -1
    END AS tax_refund_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.taxation
    ELSE -1
    END AS taxation
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.type_cd
    ELSE '#NA#'
    END AS type_cd
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.type_receive_temp_fg
    ELSE -1
    END AS type_receive_temp_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.unitsize
    ELSE uom.unitsize
    END AS unitsize
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.val_consumption_tax
    ELSE -1
    END AS val_consumption_tax
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.val_deposit
    ELSE -1
    END AS val_deposit
  , COALESCE(
      h.vat_id
    , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
      THEN wawi.vat_id
      ELSE NULL
      END
    ) AS vat_id
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.wallow_nr
    ELSE -1
    END AS wallow_nr
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.weight
    ELSE -1
    END AS weight
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.weight_fg
    ELSE CASE
      WHEN UPPER(TRIM(i.src_msehi)) = 'KG'
      THEN 1
      ELSE 0
      END
    END AS weight_fg
  , CAST(
      CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
      THEN wawi.wg_fg
      ELSE -1
      END AS DECIMAL(10, 0)
    ) AS wg_fg
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.write_off
    ELSE -1
    END AS write_off
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.buyer_name_int
    ELSE '#NA#'
    END AS buyer_name_int
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.case_size_dec
    ELSE -1
    END AS case_size_dec
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.dur_shelflife_timeunits_cust
    ELSE -1
    END AS dur_shelflife_timeunits_cust
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.dur_shelflife_timeunits_store
    ELSE -1
    END AS dur_shelflife_timeunits_store
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.dur_shelflife_timeunits_wh
    ELSE -1
    END AS dur_shelflife_timeunits_wh
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.factor_period_cust
    ELSE -1
    END AS factor_period_cust
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.factor_period_store
    ELSE -1
    END AS factor_period_store
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.factor_period_wh
    ELSE -1
    END AS factor_period_wh
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.factor_shelflife_cust
    ELSE -1
    END AS factor_shelflife_cust
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.factor_shelflife_store
    ELSE -1
    END AS factor_shelflife_store
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.factor_shelflife_wh
    ELSE -1
    END AS factor_shelflife_wh
  , CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL
    THEN wawi.qty_min_piece_ordering
    ELSE '  '
    END AS qty_min_piece_ordering
FROM p_lew_core_ac.v_item_2 AS a
LEFT OUTER JOIN p_lew_core_ac.v_client_migration_per_2 AS cg ON a.client_id = cg.client_id
  AND CURRENT_DATE BETWEEN cg.migration_dat_valid_from
  AND cg.migration_dat_valid_to
  INNER JOIN p_lew_core_ac.v_item_hist_2 AS b ON b.client_id = a.client_id
  AND b.item_sid = a.item_sid
  AND CURRENT_DATE BETWEEN b.dwh_valid_from
  AND b.dwh_valid_to
LEFT OUTER JOIN (
    SELECT
      a.client_id
      , a.item_sid
      , b.src_dat_valid_from
    FROM p_lew_core_ac.v_item_2 AS a
    INNER JOIN p_lew_core_ac.v_item_2 AS b ON b.client_id = a.client_id
      AND b.item_sid_config = COALESCE(a.item_sid_config, a.item_sid)
      AND b.src_dat_valid_from IS NOT NULL
      AND NOT EXISTS (
        SELECT 1
        FROM p_lew_core_ac.v_item_2 AS c
        WHERE c.client_id = a.client_id
          AND c.item_sid_config = COALESCE(a.item_sid_config, a.item_sid)
          AND ( c.src_dat_valid_from > b.src_dat_valid_from
            OR ( c.src_dat_valid_from = b.src_dat_valid_from
              AND c.item_sid > b.item_sid
            )
          )
      )
  ) AS dwf1 ON dwf1.client_id = a.client_id
  AND dwf1.item_sid = a.item_sid
LEFT OUTER JOIN (
    SELECT
      client_id
      , TRY_CAST(src_orig_item_nr AS INTEGER) AS origi
      , MAX(src_dat_valid_from) AS src_dat_valid_from
    FROM p_lew_core_ac.v_item_2 AS c
    WHERE
      src_dat_valid_from IS NOT NULL
      AND origi IS NOT NULL
      AND src_case_size >= 0
    GROUP BY
      1
      , 2
  ) AS dwf2 ON dwf2.client_id = a.client_id
  AND dwf2.origi = TRY_CAST(
    COALESCE(
      a.src_orig_item_nr
      , a.config_item_cd
      , a.src_matnr
    ) AS DECIMAL(18, 0)
  )
  AND a.log_var_cd IS NOT NULL
LEFT OUTER JOIN (
    SELECT
      um.client_id
      , um.item_sid
      , um.log_var_cd
      , umh.conv_to_base_numerator
      , umh.conv_to_base_denominator
    FROM p_lew_core_ac.v_item_unit_of_measurement_2 AS um
    INNER JOIN p_lew_core_ac.v_item_unit_of_measurement_hist_2 AS umh ON umh.client_id = um.client_id
      AND umh.item_sid = um.item_sid
      AND umh.uom_sid = um.uom_sid
      AND CURRENT_DATE BETWEEN umh.dwh_valid_from
      AND umh.dwh_valid_to
      AND umh.deleted_fg = 0
    WHERE
      um.log_var_cd IS NOT NULL QUALIFY ROW_NUMBER () OVER (
        PARTITION BY um.client_id
        , um.item_sid
        , um.log_var_cd
        ORDER BY
          umh.conv_to_base_numerator ASC
          , umh.conv_to_base_denominator ASC
      ) = 1
  ) AS umg ON umg.client_id = a.client_id
  AND umg.item_sid = a.item_sid
  AND umg.log_var_cd = a.log_var_cd
  AND (
    a.log_var_cd <> '1'
    OR a.config_item_cd IS NOT NULL
  )
LEFT OUTER JOIN (
    SELECT
      um.client_id
      , um.item_sid
      , 0 AS conv_to_base_numerator
    FROM p_lew_core_ac.v_item_unit_of_measurement_2 AS um
    INNER JOIN p_lew_core_ac.v_item_unit_of_measurement_hist_2 AS umh ON umh.client_id = um.client_id
      AND umh.item_sid = um.item_sid
      AND umh.uom_sid = um.uom_sid
      AND CURRENT_DATE BETWEEN umh.dwh_valid_from
      AND umh.dwh_valid_to
      AND umh.deleted_fg = 0
    WHERE
      um.log_var_cd IS NOT NULL
    GROUP BY
      1
      , 2
  ) AS umg2 ON umg2.client_id = a.client_id
  AND umg2.item_sid = a.item_sid
INNER JOIN p_lew_core_ac.v_item_map_key_2 mkey ON a.client_id = mkey.client_id
  AND a.item_sid = mkey.item_sid
LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_act_2 AS wawi ON wawi.client_id = mkey.client_id
  AND wawi.item_sid = mkey.item_sid_map
LEFT OUTER JOIN (
    SELECT
      client_id
      , item_sid
      , brand_sid
      , brand_type_mark
      , brand_descr
    FROM
      (
        SELECT
          a.client_id
          , a.item_sid
          , a.brand_sid
          , a.brand_type_mark
          , d.brand_descr
          , COUNT(*) AS counti
        FROM p_lew_core_ac.v_item_location_brand_hist_2 AS a
        INNER JOIN p_lew_core_ac.v_location_2 AS b ON b.loc_sid = a.loc_sid
          AND b.wh_store_mark = 'A'
          AND b.global_loc_type_cd = '0'
        INNER JOIN p_lew_core_ac.v_location_hist_2 AS c ON c.loc_sid = b.loc_sid
          AND c.demand_plan_active_fg = 1
          AND CURRENT_DATE BETWEEN c.dwh_valid_from
          AND c.dwh_valid_to
          AND c.deleted_fg = 0
        LEFT OUTER JOIN p_lew_core_ac.v_brand_2 AS dx ON dx.client_id = a.client_id
          AND dx.brand_sid = a.brand_sid
        LEFT OUTER JOIN p_lew_core_ac.v_client_2 AS cli ON cli.client_id = a.client_id
        LEFT OUTER JOIN p_lew_core_ac.v_country_2 AS ctry ON cli.country_sid = ctry.country_sid
        LEFT OUTER JOIN p_lew_core_ac.v_brand_descr_2 AS d ON d.client_id = a.client_id
          AND d.brand_sid = a.brand_sid
          AND d.lang_sid = ctry.lang_sid
        WHERE
          CURRENT_DATE BETWEEN a.dwh_valid_from
          AND a.dwh_valid_to
          AND a.deleted_fg = 0
        GROUP BY
          1
          , 2
          , 3
          , 4
          , 5
      ) AS x QUALIFY ROW_NUMBER() OVER (
        PARTITION BY client_id
        , item_sid
        ORDER BY
          counti DESC NULLS LAST
          , CASE
            WHEN brand_descr = '-'
              THEN 2
            ELSE 1
            END ASC
      ) = 1
  ) AS ibr ON a.client_id = ibr.client_id
  AND a.item_sid = ibr.item_sid
  LEFT OUTER JOIN (
    SELECT
      client_id
      , item_sid
      , list_type
    FROM
      (
        SELECT
          a.client_id
          , a.item_sid
          , COALESCE(a.list_type_mark, '-') AS list_type
          , COUNT(*) AS counti
        FROM p_lew_core_ac.v_item_listing_type_hist_2 AS a
        INNER JOIN p_lew_core_ac.v_location_2 AS b ON b.loc_sid = a.loc_sid
          AND b.wh_store_mark = 'A'
          AND b.global_loc_type_cd = '0'
        INNER JOIN p_lew_core_ac.v_location_hist_2 AS c ON c.loc_sid = b.loc_sid
          AND c.demand_plan_active_fg = 1
          AND CURRENT_DATE BETWEEN c.dwh_valid_from
          AND c.dwh_valid_to
          AND c.deleted_fg = 0
        WHERE
          CURRENT_DATE BETWEEN a.dwh_valid_from
          AND a.dwh_valid_to
          AND a.deleted_fg = 0
        GROUP BY
          1
          , 2
          , 3
      ) AS x QUALIFY ROW_NUMBER() OVER (
        PARTITION BY client_id
        , item_sid
        ORDER BY
          counti DESC NULLS LAST
      ) = 1
  ) AS ilt ON a.client_id = ilt.client_id
  AND a.item_sid = ilt.item_sid
INNER JOIN p_lew_core_ac.v_client_2 AS c ON c.client_id = a.client_id
LEFT OUTER JOIN p_lew_bil_ac.v_item_shelflife_2 AS d ON d.client_id = a.client_id
  AND d.item_sid = a.item_sid
LEFT OUTER JOIN p_lew_core_ac.v_item_group_2 AS e ON e.client_id = b.client_id
  AND e.item_grp_sid = b.item_grp_sid
LEFT OUTER JOIN p_lew_core_ac.v_packaging_type_2 AS f ON f.client_id = b.client_id
  AND f.pack_type_sid = b.pack_type_sid
 LEFT OUTER JOIN (
    SELECT
      vat_id
      , client_id
      , item_sid
    FROM p_lew_bil_ac.v_item_vat_2
    WHERE
      dat_calendar = CURRENT_DATE
    GROUP BY
      1
      , 2
      , 3
  ) AS h ON h.client_id = a.client_id
  AND h.item_sid = a.item_sid
LEFT OUTER JOIN p_lew_core_ac.v_unit_of_measurement_2 AS i ON i.client_id = b.client_id
  AND i.uom_sid = b.uom_sid_base
LEFT OUTER JOIN p_lew_core_ac.v_map_mis_logistic_unit_2 AS j ON j.client_id = b.client_id
  AND j.uom_cd = b.uom_cd_packaging
LEFT OUTER JOIN p_lew_core_ac.v_item_hist_2 AS bb ON bb.client_id = a.client_id
  AND bb.item_sid = COALESCE(a.item_sid_config, a.item_sid)
  AND CURRENT_DATE BETWEEN bb.dwh_valid_from
  AND bb.dwh_valid_to
LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup_2 AS k ON k.client_id = bb.client_id
  AND k.item_fam_grp_sid = bb.item_fam_grp_sid
LEFT OUTER JOIN p_lew_core_ac.v_item_familygroup_hist_2 AS kh ON kh.client_id = bb.client_id
  AND kh.item_fam_grp_sid = bb.item_fam_grp_sid
  AND CURRENT_DATE BETWEEN kh.dwh_valid_from
  AND kh.dwh_valid_to
LEFT OUTER JOIN p_lew_core_ac.v_subitemgroup_2 AS sig ON sig.client_id = kh.client_id
  AND sig.sub_item_grp_sid = kh.sub_item_grp_sid
LEFT OUTER JOIN (
    SELECT
      client_id
      , item_sid
      , package_qty
      , packing
      , logistic_unit_cd
      , unitsize
    FROM
      (
        SELECT
          a.client_id
          , a.item_sid
          , d.gross_content_val * d.pack_cont_qty AS package_qty
          , h.pack_type_descr AS packing
          , e.mis_logistic_unit_cd AS logistic_unit_cd
          , CASE WHEN d.gross_content_val <> 1
            THEN TRIM( d.gross_content_val
              /*Warning, Format 'FN9' removed, semantic information not found.*/
              ) || 'x' || TRIM( d.pack_cont_qty
              /*Warning, Format 'FN9' removed, semantic information not found.*/
              ) || CAST(u.src_msehi AS VARCHAR(10))
            ELSE TRIM( d.pack_cont_qty
              /*Warning, Format 'FN9' removed, semantic information not found.*/
              ) || CAST(u.src_msehi AS VARCHAR(10))
            END AS unitsize
          , COUNT(*) OVER (
            PARTITION BY a.client_id
            , a.item_sid
            , package_qty
          ) AS cnt_package_qty
        FROM p_lew_core_ac.v_item_sort_box_hist_2 AS a
        INNER JOIN p_lew_core_ac.v_item_hist_2 AS b ON b.client_id = a.client_id
          AND b.item_sid = a.item_sid
          AND CURRENT_DATE BETWEEN b.dwh_valid_from
          AND b.dwh_valid_to
        INNER JOIN p_lew_core_ac.v_item_bom_2 AS m ON m.client_id = a.client_id
          AND m.item_sid = a.item_sid_sort_box
        INNER JOIN p_lew_core_ac.v_item_bom_pos_hist_2 AS c ON c.client_id = m.client_id
          AND c.item_bom_sid = m.item_bom_sid
        INNER JOIN p_lew_core_ac.v_item_hist_2 AS d ON d.client_id = c.client_id
          AND d.item_sid = c.item_sid
          AND CURRENT_DATE BETWEEN d.dwh_valid_from
          AND d.dwh_valid_to
        LEFT OUTER JOIN p_lew_core_ac.v_unit_of_measurement_2 AS u ON u.client_id = d.client_id
          AND u.uom_sid = d.uom_sid_packaging
        LEFT OUTER JOIN p_lew_core_ac.v_map_mis_logistic_unit_2 AS e ON e.client_id = d.client_id
          AND e.uom_cd = d.uom_cd_packaging
        INNER JOIN p_lew_core_ac.v_client_2 AS f ON f.client_id = d.client_id
        INNER JOIN p_lew_core_ac.v_country_2 AS g ON g.country_sid = f.country_sid
        LEFT OUTER JOIN p_lew_core_ac.v_packaging_type_descr_2 AS h ON h.client_id = d.client_id
          AND h.pack_type_sid = d.pack_type_sid
          AND h.lang_sid = g.lang_sid
        WHERE
          CURRENT_DATE BETWEEN a.dwh_valid_from
          AND a.dwh_valid_to
      ) z QUALIFY ROW_NUMBER() OVER (
        PARTITION BY z.client_id
        , z.item_sid
        ORDER BY
          z.cnt_package_qty DESC NULLS LAST
          , z.package_qty DESC NULLS LAST
      ) = 1
  ) uom ON uom.client_id = a.client_id
  AND uom.item_sid = a.item_sid
WHERE
  TRY_CAST(
    COALESCE(
      a.src_orig_item_nr
      , a.config_item_cd
      , a.src_matnr
    ) AS DECIMAL(18, 0)
  ) IS NOT NULL
;
