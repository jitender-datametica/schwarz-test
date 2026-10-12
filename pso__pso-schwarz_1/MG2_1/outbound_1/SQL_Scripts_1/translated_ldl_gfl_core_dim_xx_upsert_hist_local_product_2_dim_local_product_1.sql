INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_sid,
  country_org_sid,
  country_org_cd,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  local_prod_nr,
  alt_1_local_prod_nr,
  alt_2_local_prod_nr,
  alt_3_local_prod_nr,
  alt_4_local_prod_nr,
  alt_5_local_prod_nr,
  alt_6_local_prod_nr,
  alt_7_local_prod_nr,
  alt_8_local_prod_nr,
  alt_9_local_prod_nr,
  alt_10_local_prod_nr,
  alt_11_local_prod_nr,
  alt_12_local_prod_nr,
  alt_13_local_prod_nr,
  alt_14_local_prod_nr,
  alt_15_local_prod_nr,
  alt_16_local_prod_nr,
  alt_17_local_prod_nr,
  alt_18_local_prod_nr,
  alt_19_local_prod_nr,
  alt_20_local_prod_nr,
  alt_local_prod_nr_cnt,
  local_prod_name,
  local_prod_descr,
  local_prod_version_nr,
  local_prod_creation_dt,
  plu_nr,
  prod_status_cd,
  prod_status_descr,
  brand_type_cd,
  brand_type_descr,
  brand_name,
  sup_sid,
  sup_name,
  buyer_sid,
  buyer_nr,
  local_list_dt,
  local_delist_dt,
  intrastat_nr,
  intrastat_name,
  locked_fg,
  vat_refund_fg,
  dangerous_goods_fg,
  dispatch_grp_nr,
  dispatch_grp_descr,
  dispatch_unit_cd,
  dispatch_unit_descr,
  list_type_cd,
  list_type_descr,
  order_area_nr,
  order_area_descr,
  min_cust_age_meas,
  sort_seq,
  min_consumption_day_cnt,
  min_shelflife_to_store_day_cnt,
  min_shelflife_to_wh_day_cnt,
  deliv_temp_meas,
  min_deliv_temp_meas,
  max_deliv_temp_meas,
  uom_cd,
  shelflife_check_on_receipt_fg,
  item_fam_sid,
  item_fam_nr,
  item_fam_name,
  sub_item_grp_sid,
  sub_item_grp_nr,
  sub_item_grp_name,
  int_item_grp_sid,
  int_item_grp_nr,
  int_item_grp_name,
  pillar_sid,
  pillar_nr,
  pillar_name,
  main_pillar_sid,
  main_pillar_nr,
  main_pillar_name,
  country_specific_prod_fg,
  dwh_node_cd,
  extraction_tmsp,
  dwh_mapping_tmsp,
  tf_error_fg,
  record_id,
  dwh_load_id,
  filename
)
SELECT
  lp.prod_sid AS prod_sid,
  lp.int_org_sid AS country_org_sid,
  io.country_org_cd AS country_org_cd,
  lp.dwh_valid_from_tmsp AS dwh_valid_from_tmsp,
  lp.dwh_valid_to_tmsp AS dwh_valid_to_tmsp,
  lp.dwh_valid_fg AS dwh_valid_fg,
  lp.local_prod_nr AS local_prod_nr,
  prod_ident.alt_1_local_prod_nr,
  prod_ident.alt_2_local_prod_nr,
  prod_ident.alt_3_local_prod_nr,
  prod_ident.alt_4_local_prod_nr,
  prod_ident.alt_5_local_prod_nr,
  prod_ident.alt_6_local_prod_nr,
  prod_ident.alt_7_local_prod_nr,
  prod_ident.alt_8_local_prod_nr,
  prod_ident.alt_9_local_prod_nr,
  prod_ident.alt_10_local_prod_nr,
  prod_ident.alt_11_local_prod_nr,
  prod_ident.alt_12_local_prod_nr,
  prod_ident.alt_13_local_prod_nr,
  prod_ident.alt_14_local_prod_nr,
  prod_ident.alt_15_local_prod_nr,
  prod_ident.alt_16_local_prod_nr,
  prod_ident.alt_17_local_prod_nr,
  prod_ident.alt_18_local_prod_nr,
  prod_ident.alt_19_local_prod_nr,
  prod_ident.alt_20_local_prod_nr,
  coalesce(prod_ident.alt_local_prod_nr_cnt, CAST('0' AS NUMERIC)) AS alt_local_prod_nr_cnt, /* use this in case the CORE_REL.T_PRODUCT_IDENTIFICATION_1 has no entrys */
  lp.local_prod_name AS local_prod_name,
  lp.local_prod_descr AS local_prod_descr,
  lp.local_prod_version_nr AS local_prod_version_nr,
  lp.local_prod_creation_dt AS local_prod_creation_dt,
  lp.plu_nr AS plu_nr,
  '@' AS prod_status_cd,
  'unbekannt' AS prod_status_descr,
  coalesce(lp.brand_type_cd, '@') AS brand_type_cd,
  coalesce(brand_typ.brand_type_descr, 'unbekannt') AS brand_type_descr,
  coalesce(brand.brand_name, '@') AS brand_name,
  coalesce(prod_sup.sup_sid, -CAST('1' AS NUMERIC)) AS sup_sid,
  coalesce(org.org_name, 'unbekannt') AS sup_name,
  '-1' AS buyer_sid,
  '-1' AS buyer_nr,
  lp.local_list_dt AS local_list_dt,
  lp.local_delist_dt AS local_delist_dt,
  coalesce(intrastat_nr, 'unbekannt') AS intrastat_nr,
  'unbekannt' AS intrastat_name,
  coalesce(locked_fg, FALSE) AS locked_fg,
  coalesce(vat_refund_fg, FALSE) AS vat_refund_fg,
  coalesce(dangerous_goods_fg, FALSE) AS dangerous_goods_fg,
  coalesce(dg.dispatch_grp_nr, '@') AS dispatch_grp_nr,
  coalesce(dg.dispatch_grp_descr, 'unbekannt') AS dispatch_grp_descr,
  '@' AS dispatch_unit_cd,
  'unbekannt' AS dispatch_unit_descr,
  coalesce(lstt.list_type_cd, '@') AS list_type_cd,
  coalesce(lstt.list_type_descr, 'unbekannt') AS list_type_descr,
  coalesce(orda.order_area_nr, '@') AS order_area_nr,
  coalesce(orda.order_area_descr, 'unbekannt') AS order_area_descr,
  lp.min_cust_age_meas AS min_cust_age_meas,
  lp.sort_seq AS sort_seq,
  '0' AS min_consumption_day_cnt,
  '0' AS min_shelflife_to_store_day_cnt,
  '0' AS min_shelflife_to_wh_day_cnt,
  '0' AS deliv_temp_meas,
  '0' AS min_deliv_temp_meas,
  '0' AS max_deliv_temp_meas,
  '@' AS uom_cd,
  'true' AS shelflife_check_on_receipt_fg,
  coalesce(fam.fam_grp_sid, -CAST('1' AS NUMERIC)) AS item_fam_sid,
  coalesce(fam.fam_group_nr, '@') AS item_fam_nr,
  coalesce(fam.fam_group_name, '@') AS item_fam_name,
  coalesce(sub.sub_item_grp_sid, -CAST('1' AS NUMERIC)) AS sub_item_grp_sid,
  coalesce(sub.sub_item_grp_nr, '@') AS sub_item_grp_nr,
  coalesce(sub.sub_item_grp_name, '@') AS sub_item_grp_name,
  coalesce(integer.int_item_grp_sid, -CAST('1' AS NUMERIC)) AS int_item_grp_sid,
  coalesce(integer.int_item_grp_nr, '@') AS int_item_grp_nr,
  coalesce(integer.int_item_grp_name, '@') AS int_item_grp_name,
  '-1' AS pillar_sid,
  '@' AS pillar_nr,
  'unbekannt' AS pillar_name,
  '-1' AS main_pillar_sid,
  '@' AS main_pillar_nr,
  'unbekannt' AS main_pillar_name,
  coalesce(p.country_specific_prod_fg, TRUE) AS country_specific_prod_fg,
  lp.dwh_node_cd,
  current_timestamp() AS extraction_tmsp,
  lp.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  CAST('0' AS NUMERIC) AS tf_error_fg,
  CAST('0' AS NUMERIC) AS record_id,
  ${load_id} AS load_is,
  'core_rel' AS filename
FROM ldl_data_production.core_rel.t_local_product_1 AS lp
LEFT OUTER JOIN ldl_data_production.core_rel.t_product_1 AS p
  ON p.prod_sid = lp.prod_sid AND p.dwh_valid_fg = TRUE
LEFT OUTER JOIN ldl_data_production.core_rel.t_brand_1 AS brand_1
  ON brand.brand_name = lp.brand_name
LEFT OUTER JOIN ldl_data_production.core_rel.t_brand_type_1 AS brand_typ
  ON brand_typ.brand_type_cd = lp.brand_type_cd AND brand_typ.lang_cd = 'DE'
LEFT OUTER JOIN (
  SELECT
    subselect.prod_sid,
    subselect.int_org_sid,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('1' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_1_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('2' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_2_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('3' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_3_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('4' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_4_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('5' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_5_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('6' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_6_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('7' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_7_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('8' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_8_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('9' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_9_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('10' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_10_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('11' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_11_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('12' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_12_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('13' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_13_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('14' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_14_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('15' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_15_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('16' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_16_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('17' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_17_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('18' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_18_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('19' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_19_local_prod_nr,
    MAX(
      CASE
        WHEN subselect.rank_ident_nr = CAST('20' AS NUMERIC)
        THEN subselect.prod_ident_nr
        ELSE NULL
      END
    ) AS alt_20_local_prod_nr,
    MAX(subselect.rank_ident_nr) AS alt_local_prod_nr_cnt
  FROM (
    SELECT
      t_product_identification.prod_sid,
      t_product_identification.int_org_sid,
      t_product_identification.prod_ident_nr,
      rank() OVER (
        PARTITION BY t_product_identification.prod_sid, t_product_identification.int_org_sid
        ORDER BY IF(t_product_identification.prod_ident_nr IS NULL, 0, 1), t_product_identification.prod_ident_nr DESC
      ) AS rank_ident_nr
    FROM ldl_data_production.core_rel.t_product_identification_1
    WHERE
      t_product_identification.dwh_valid_fg
      AND t_product_identification.prod_ident_type_cd = 'WAWI'
  ) AS subselect
  GROUP BY
    1,
    2
) AS prod_ident
  ON prod_ident.prod_sid = lp.prod_sid
  AND /* and prod_sid = 293441 and int_org_sid = 15 */ prod_ident.int_org_sid = lp.int_org_sid
LEFT OUTER JOIN (
  SELECT
    prod_sid,
    pgh.prod_grp_sid AS fam_grp_sid,
    pg.dwh_valid_fg,
    prod_grp_nr AS fam_group_nr,
    prod_grp_name AS fam_group_name
  FROM ldl_data_production.core_rel.t_product_to_product_group_1 AS pgh
  INNER JOIN ldl_data_production.core_rel.t_product_group_1 AS pg
    ON pgh.prod_grp_sid = pg.prod_grp_sid
    AND pg.prod_grp_type_cd = 'IFG'
    AND pg.dwh_valid_fg = TRUE
  WHERE
    pgh.dwh_valid_fg = TRUE
) AS fam
  ON fam.prod_sid = lp.prod_sid
LEFT OUTER JOIN (
  SELECT
    pgh_level1.prod_grp_sid AS fam_grp_sid,
    pgh_level2.prod_grp_sid AS sub_item_grp_sid,
    pgh_level2.prod_grp_name AS sub_item_grp_name,
    pgh_level2.prod_grp_nr AS sub_item_grp_nr
  FROM ldl_data_production.core_rel.t_product_group_hierarchy_1 AS pgh_level1
  LEFT OUTER JOIN (
    SELECT
      pgh.parent_prod_grp_sid,
      pg1.prod_grp_sid,
      pg1.prod_grp_name,
      pg1.prod_grp_nr
    FROM ldl_data_production.core_rel.t_product_group_1 AS pg1
    LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_hierarchy_1 AS pgh
      ON pgh.prod_grp_sid = pg1.prod_grp_sid
      AND pgh.dwh_valid_fg
      AND pg1.dwh_valid_fg
      AND pg1.prod_grp_type_cd = 'SIG'
  ) AS pgh_level2
    ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
    AND pgh_level1.dwh_valid_fg = TRUE
) AS sub
  ON sub.fam_grp_sid = fam.fam_grp_sid
LEFT OUTER JOIN (
  SELECT
    pgh_level1.prod_grp_sid AS fam_item_grp_sid,
    pgh_level3.prod_grp_sid AS int_item_grp_sid,
    pgh_level3.prod_grp_name AS int_item_grp_name,
    pgh_level3.prod_grp_nr AS int_item_grp_nr
  FROM ldl_data_production.core_rel.t_product_group_hierarchy_1 AS pgh_level1
  LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_1 AS pg
    ON pgh_level1.prod_grp_sid = pg.prod_grp_sid
    AND pg.dwh_valid_fg = TRUE
    AND pg.prod_grp_type_cd = 'IFG'
  LEFT OUTER JOIN (
    SELECT
      pgh.parent_prod_grp_sid,
      pg1.prod_grp_sid,
      pg1.prod_grp_name,
      pg1.prod_grp_nr
    FROM ldl_data_production.core_rel.t_product_group_1 AS pg1
    LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_hierarchy_1 AS pgh
      ON pgh.prod_grp_sid = pg1.prod_grp_sid
      AND pgh.dwh_valid_fg = TRUE
      AND pg1.dwh_valid_fg = TRUE
      AND pg1.prod_grp_type_cd = 'SIG'
  ) AS pgh_level2
    ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
  LEFT OUTER JOIN (
    SELECT
      pg_0.prod_grp_sid,
      pg_0.prod_grp_name,
      pg_0.prod_grp_nr
    FROM ldl_data_production.core_rel.t_product_group_1 AS pg_0
    WHERE
      pg_0.dwh_valid_fg = TRUE AND pg_0.prod_grp_type_cd = 'IGI'
  ) AS pgh_level3
    ON pgh_level2.parent_prod_grp_sid = pgh_level3.prod_grp_sid
  WHERE
    pgh_level1.dwh_valid_fg = TRUE
) AS integer
  ON integer.fam_item_grp_sid = fam.fam_grp_sid
INNER JOIN ldl_data_production.core_rel.t_internal_organization_1 AS io
  ON io.int_org_sid = lp.int_org_sid AND io.dwh_valid_fg
LEFT OUTER JOIN ldl_data_production.core_rel.t_product_dispatch_group_1 AS pdg
  ON lp.prod_sid = pdg.prod_sid
  AND lp.int_org_sid = pdg.int_org_sid
  AND pdg.dwh_valid_fg = CAST('1' AS NUMERIC)
LEFT OUTER JOIN (
  SELECT
    t_dispatch_group.dispatch_grp_descr,
    t_dispatch_group.dispatch_grp_nr,
    t_dispatch_group.int_org_sid,
    IF(t_dispatch_group.lang_cd = 'DE', CAST('0' AS NUMERIC), CAST('1' AS NUMERIC)) AS ourorder
  FROM ldl_data_production.core_rel.t_dispatch_group_1
  QUALIFY
    row_number() OVER (
      PARTITION BY dispatch_grp_nr, int_org_sid
      ORDER BY IF(ourorder IS NULL, 0, 1) DESC, ourorder
    ) = CAST('1' AS NUMERIC)
) AS dg
  ON pdg.dispatch_grp_nr = dg.dispatch_grp_nr AND pdg.int_org_sid = dg.int_org_sid
LEFT OUTER JOIN ldl_data_production.core_rel.t_product_listing_1 AS prlst
  ON prlst.prod_sid = lp.prod_sid
  AND lp.int_org_sid = prlst.int_org_sid
  AND prlst.dwh_valid_fg
  AND lp.dwh_valid_fg
LEFT OUTER JOIN ldl_data_production.core_rel.t_listing_type_1 AS lstt
  ON lstt.list_type_cd = prlst.list_type_cd AND lstt.lang_cd = 'DE'
LEFT OUTER JOIN ldl_data_production.core_rel.t_product_order_area_1 AS proa
  ON lp.prod_sid = proa.prod_sid
  AND lp.int_org_sid = proa.int_org_sid
  AND lp.dwh_valid_fg
  AND proa.dwh_valid_fg
LEFT OUTER JOIN ldl_data_production.core_rel.t_order_area_1 AS orda
  ON orda.order_area_nr = proa.order_area_nr AND orda.lang_cd = 'DE'
LEFT OUTER JOIN ldl_data_production.core_rel.t_product_supplier_1 AS prod_sup
  ON prod_sup.prod_sid = lp.prod_sid
  AND prod_sup.dwh_valid_fg
  AND prod_sup.int_org_sid = lp.int_org_sid
LEFT OUTER JOIN ldl_data_production.core_rel.t_organization_1 AS org
  ON prod_sup.sup_sid = org.org_sid
  AND org.dwh_valid_fg = CAST('1' AS NUMERIC)
  AND org.org_type_cd = 'SUPPLIER_1'
WHERE
  lp.dwh_valid_fg = TRUE
QUALIFY
  row_number() OVER (
    PARTITION BY prod_sid, country_org_sid
    ORDER BY IF(prod_ident.alt_local_prod_nr_cnt IS NULL, 0, 1), prod_ident.alt_local_prod_nr_cnt DESC
  ) = CAST('1' AS NUMERIC)
UNION DISTINCT
SELECT
  -CAST('1' AS NUMERIC) AS prod_sid,
  int_org_sid AS country_org_sid,
  country_org_cd AS country_org_cd,
  '1900-01-01 00:00:00.000' AS dwh_valid_from_tmsp,
  '9999-12-31 23:59:59.999' AS dwh_valid_to_tmsp,
  TRUE AS dwh_valid_fg,
  '@' AS local_prod_nr,
  NULL AS alt_1_local_prod_nr,
  NULL AS alt_2_local_prod_nr,
  NULL AS alt_3_local_prod_nr,
  NULL AS alt_4_local_prod_nr,
  NULL AS alt_5_local_prod_nr,
  NULL AS alt_6_local_prod_nr,
  NULL AS alt_7_local_prod_nr,
  NULL AS alt_8_local_prod_nr,
  NULL AS alt_9_local_prod_nr,
  NULL AS alt_10_local_prod_nr,
  NULL AS alt_11_local_prod_nr,
  NULL AS alt_12_local_prod_nr,
  NULL AS alt_13_local_prod_nr,
  NULL AS alt_14_local_prod_nr,
  NULL AS alt_15_local_prod_nr,
  NULL AS alt_16_local_prod_nr,
  NULL AS alt_17_local_prod_nr,
  NULL AS alt_18_local_prod_nr,
  NULL AS alt_19_local_prod_nr,
  NULL AS alt_20_local_prod_nr,
  CAST('0' AS NUMERIC) AS alt_local_prod_nr_cnt,
  '@' AS local_prod_name,
  '@' AS local_prod_descr,
  '@' AS local_prod_version_nr,
  '1900-01-01 00:00:00.000' AS local_prod_creation_dt,
  '@' AS plu_nr,
  '@' AS prod_status_cd,
  'unbekannt' AS prod_status_descr,
  '@' AS brand_type_cd,
  'unbekannt' AS brand_type_descr,
  '@' AS brand_name,
  '-1' AS sup_sid,
  'unbekannt' AS sup_name,
  '-1' AS buyer_sid,
  '-1' AS buyer_nr,
  '1900-01-01 00:00:00.000' AS local_list_dt,
  '1900-01-01 00:00:00.000' AS local_delist_dt,
  'unbekannt' AS intrastat_nr,
  'unbekannt' AS intrastat_name,
  FALSE AS locked_fg,
  FALSE AS vat_refund_fg,
  FALSE AS dangerous_goods_fg,
  '@' AS dispatch_grp_nr,
  'unbekannt' AS dispatch_grp_descr,
  '@' AS dispatch_unit_cd,
  'unbekannt' AS dispatch_unit_descr,
  '@' AS list_type_cd,
  'unbekannt' AS list_type_descr,
  '@' AS order_area_nr,
  'unbekannt' AS order_area_descr,
  NULL AS min_cust_age_meas,
  NULL AS sort_seq,
  NULL AS min_consumption_day_cnt,
  NULL AS min_shelflife_to_store_day_cnt,
  NULL AS min_shelflife_to_wh_day_cnt,
  NULL AS deliv_temp_meas,
  NULL AS min_deliv_temp_meas,
  NULL AS max_deliv_temp_meas,
  '@' AS uom_cd,
  TRUE AS shelflife_check_on_receipt_fg,
  -CAST('1' AS NUMERIC) AS item_fam_sid,
  '@' AS item_fam_nr,
  '@' AS item_fam_name,
  -CAST('1' AS NUMERIC) AS sub_item_grp_sid,
  '@' AS sub_item_grp_nr,
  '@' AS sub_item_grp_name,
  -CAST('1' AS NUMERIC) AS int_item_grp_sid,
  '@' AS int_item_grp_nr,
  '@' AS int_item_grp_name,
  '-1' AS pillar_sid,
  '@' AS pillar_nr,
  'unbekannt' AS pillar_name,
  '-1' AS main_pillar_sid,
  '@' AS main_pillar_nr,
  'unbekannt' AS main_pillar_name,
  TRUE AS country_specific_prod_fg,
  'DUMMY_1' AS dwh_node_cd,
  current_timestamp() AS extraction_tmsp,
  '1900-01-01 00:00:00.000' AS dwh_mapping_tmsp,
  CAST('0' AS NUMERIC) AS tf_error_fg,
  CAST('0' AS NUMERIC) AS record_id,
  ${load_id} AS load_is,
  'DUMMY_1' AS filename
FROM ldl_data_production.core_rel.t_internal_organization_1 AS o
INNER JOIN ldl_data_production.meta.t_party_key_1 AS k
  ON int_org_sid = party_sid AND k.party_key_type_cd = 'COUNTRY_1' AND k.dwh_valid_fg
WHERE
  o.dwh_valid_fg;