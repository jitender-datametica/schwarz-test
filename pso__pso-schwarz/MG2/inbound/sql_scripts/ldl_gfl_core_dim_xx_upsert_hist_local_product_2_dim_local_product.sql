INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  prod_sid,
  country_org_sid,
  country_org_cd,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  local_prod_nr,
  ALT_1_LOCAL_PROD_NR,
  ALT_2_LOCAL_PROD_NR,
  ALT_3_LOCAL_PROD_NR,
  ALT_4_LOCAL_PROD_NR,
  ALT_5_LOCAL_PROD_NR,
  ALT_6_LOCAL_PROD_NR,
  ALT_7_LOCAL_PROD_NR,
  ALT_8_LOCAL_PROD_NR,
  ALT_9_LOCAL_PROD_NR,
  ALT_10_LOCAL_PROD_NR,
  ALT_11_LOCAL_PROD_NR,
  ALT_12_LOCAL_PROD_NR,
  ALT_13_LOCAL_PROD_NR,
  ALT_14_LOCAL_PROD_NR,
  ALT_15_LOCAL_PROD_NR,
  ALT_16_LOCAL_PROD_NR,
  ALT_17_LOCAL_PROD_NR,
  ALT_18_LOCAL_PROD_NR,
  ALT_19_LOCAL_PROD_NR,
  ALT_20_LOCAL_PROD_NR,
  ALT_LOCAL_PROD_NR_CNT,
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
  DISPATCH_UNIT_CD,
  DISPATCH_UNIT_DESCR,
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
  prod_ident.ALT_1_LOCAL_PROD_NR,
  prod_ident.ALT_2_LOCAL_PROD_NR,
  prod_ident.ALT_3_LOCAL_PROD_NR,
  prod_ident.ALT_4_LOCAL_PROD_NR,
  prod_ident.ALT_5_LOCAL_PROD_NR,
  prod_ident.ALT_6_LOCAL_PROD_NR,
  prod_ident.ALT_7_LOCAL_PROD_NR,
  prod_ident.ALT_8_LOCAL_PROD_NR,
  prod_ident.ALT_9_LOCAL_PROD_NR,
  prod_ident.ALT_10_LOCAL_PROD_NR,
  prod_ident.ALT_11_LOCAL_PROD_NR,
  prod_ident.ALT_12_LOCAL_PROD_NR,
  prod_ident.ALT_13_LOCAL_PROD_NR,
  prod_ident.ALT_14_LOCAL_PROD_NR,
  prod_ident.ALT_15_LOCAL_PROD_NR,
  prod_ident.ALT_16_LOCAL_PROD_NR,
  prod_ident.ALT_17_LOCAL_PROD_NR,
  prod_ident.ALT_18_LOCAL_PROD_NR,
  prod_ident.ALT_19_LOCAL_PROD_NR,
  prod_ident.ALT_20_LOCAL_PROD_NR,
  coalesce (prod_ident.ALT_LOCAL_PROD_NR_CNT, 0) as ALT_LOCAL_PROD_NR_CNT, --use this in case the CORE_REL.T_PRODUCT_IDENTIFICATION has no entrys
  lp.local_prod_name AS local_prod_name,
  lp.local_prod_descr AS local_prod_descr,
  lp.local_prod_version_nr AS local_prod_version_nr,
  lp.local_prod_creation_dt AS local_prod_creation_dt,
  lp.plu_nr AS plu_nr,
  '@' AS prod_status_cd,
  'unbekannt' AS prod_status_descr,
  COALESCE (lp.brand_type_cd , '@') AS brand_type_cd,
  COALESCE (brand_typ.brand_type_descr ,'unbekannt') AS brand_type_descr,
  COALESCE (brand.brand_name,'@') AS brand_name,
  COALESCE (prod_sup.sup_sid,-1) AS sup_sid,
  COALESCE (org.org_name, 'unbekannt') AS sup_name,
  '-1' AS buyer_sid,
  '-1' AS buyer_nr,
  lp.local_list_dt AS local_list_dt,
  lp.local_delist_dt AS local_delist_dt,
  COALESCE (intrastat_nr,'unbekannt') AS intrastat_nr,
  'unbekannt' AS intrastat_name,
  COALESCE (locked_fg ,false) AS locked_fg,
  COALESCE (vat_refund_fg ,false) AS vat_refund_fg,
  COALESCE (dangerous_goods_fg ,false) AS dangerous_goods_fg,
  COALESCE (dg.dispatch_grp_nr, '@') AS dispatch_grp_nr,
  COALESCE (dg.dispatch_grp_descr, 'unbekannt') AS dispatch_grp_descr,
  '@' as DISPATCH_UNIT_CD,
  'unbekannt' as DISPATCH_UNIT_DESCR,
  COALESCE (lstt.list_type_cd, '@') AS list_type_cd,
  COALESCE (lstt.list_type_descr, 'unbekannt') AS list_type_descr,
  COALESCE (orda.order_area_nr, '@') AS order_area_nr,
  COALESCE (orda.order_area_descr, 'unbekannt') AS order_area_descr,
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
  COALESCE(fam.fam_grp_sid  ,-1) AS item_fam_sid,
  COALESCE(fam_group_nr,'@') AS item_fam_nr,
  COALESCE(fam_group_name,'@') AS item_fam_name,
  COALESCE(sub.sub_item_grp_sid ,-1) AS sub_item_grp_sid,
  COALESCE(sub_item_grp_nr,'@') AS sub_item_grp_nr,
  COALESCE(sub_item_grp_name,'@') AS sub_item_grp_name,
  COALESCE(int.int_item_grp_sid  ,-1) AS int_item_grp_sid,
  COALESCE(int_item_grp_nr,'@') AS int_item_grp_nr,
  COALESCE(int_item_grp_name,'@') AS int_item_grp_name,
  '-1' AS pillar_sid,
  '@' AS pillar_nr,
  'unbekannt' AS pillar_name,
  '-1' AS main_pillar_sid,
  '@' AS main_pillar_nr,
  'unbekannt' AS main_pillar_name,
  COALESCE(p.country_specific_prod_fg, TRUE) AS country_specific_prod_fg,
  lp.dwh_node_cd,
  current_timestamp AS extraction_tmsp,
  lp.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS record_id,
  ${LOAD_ID} AS load_is,
  'core_rel' AS filename
  FROM core_rel.t_local_product lp
  LEFT JOIN core_rel.t_product p ON p.prod_sid = lp.prod_sid AND p.dwh_valid_fg=true
  LEFT JOIN core_rel.t_brand brand ON brand.brand_name = lp.brand_name
  LEFT JOIN core_rel.t_brand_type brand_typ ON brand_typ.brand_type_cd  =  lp.brand_type_cd AND brand_typ.lang_cd = 'DE'
  LEFT JOIN (
           select
           prod_sid
           ,int_org_sid
           ,max (case when rank_ident_nr = 1 then prod_ident_nr else null end) as ALT_1_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 2 then prod_ident_nr else null end) as ALT_2_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 3 then prod_ident_nr else null end) as ALT_3_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 4 then prod_ident_nr else null end) as ALT_4_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 5 then prod_ident_nr else null end) as ALT_5_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 6 then prod_ident_nr else null end) as ALT_6_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 7 then prod_ident_nr else null end) as ALT_7_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 8 then prod_ident_nr else null end) as ALT_8_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 9 then prod_ident_nr else null end) as ALT_9_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 10 then prod_ident_nr else null end) as ALT_10_LOCAL_PROD_NR
	   ,max (case when rank_ident_nr = 11 then prod_ident_nr else null end) as ALT_11_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 12 then prod_ident_nr else null end) as ALT_12_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 13 then prod_ident_nr else null end) as ALT_13_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 14 then prod_ident_nr else null end) as ALT_14_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 15 then prod_ident_nr else null end) as ALT_15_LOCAL_PROD_NR
	   ,max (case when rank_ident_nr = 16 then prod_ident_nr else null end) as ALT_16_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 17 then prod_ident_nr else null end) as ALT_17_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 18 then prod_ident_nr else null end) as ALT_18_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 19 then prod_ident_nr else null end) as ALT_19_LOCAL_PROD_NR
           ,max (case when rank_ident_nr = 20 then prod_ident_nr else null end) as ALT_20_LOCAL_PROD_NR
           ,max (rank_ident_nr) as ALT_LOCAL_PROD_NR_CNT
           from (
                            SELECT prod_sid,
                                   int_org_sid,
                                   prod_ident_nr,
                                   RANK() OVER (PARTITION BY prod_sid, int_org_sid ORDER BY prod_ident_nr DESC) AS rank_ident_nr
                            FROM CORE_REL.T_PRODUCT_IDENTIFICATION
                            where dwh_valid_fg and PROD_IDENT_TYPE_CD = 'WAWI' 
                            --and prod_sid = 293441 and int_org_sid = 15
               )
           group by prod_sid ,int_org_sid 
          ) prod_ident
          ON prod_ident.prod_sid = lp.prod_sid
          AND prod_ident.int_org_sid = lp.int_org_sid
  LEFT JOIN 
    ( SELECT   prod_sid, pgh.prod_grp_sid as fam_grp_sid  ,pg.dwh_valid_fg,prod_grp_nr fam_group_nr,	prod_grp_name fam_group_name
      FROM core_rel.t_product_to_product_group pgh
      JOIN  core_rel.t_product_group pg ON pgh.prod_grp_sid = pg.prod_grp_sid and pg.prod_grp_type_cd = 'IFG' and pg.dwh_valid_fg =true
      WHERE  pgh.dwh_valid_fg = TRUE 
    ) fam ON fam.prod_sid=lp.prod_sid
  LEFT JOIN
    (
     SELECT pgh_level1.prod_grp_sid fam_grp_sid,pgh_level2.prod_grp_sid AS sub_item_grp_sid ,pgh_level2.prod_grp_name AS sub_item_grp_name ,pgh_level2.prod_grp_nr AS sub_item_grp_nr
     FROM CORE_REL.T_PRODUCT_GROUP_HIERARCHY pgh_level1
     LEFT JOIN 
	   ( SELECT pgh.parent_prod_grp_sid,pg1.prod_grp_sid, pg1.prod_grp_name,pg1.prod_grp_nr
         FROM CORE_REL.T_PRODUCT_GROUP pg1
         LEFT JOIN CORE_REL.T_PRODUCT_GROUP_HIERARCHY pgh  
              ON pgh.prod_grp_sid = pg1.prod_grp_sid AND pgh.dwh_valid_fg AND pg1.dwh_valid_fg  AND pg1.prod_grp_type_cd = 'SIG'
        ) pgh_level2
      ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid AND pgh_level1.dwh_valid_fg=true 
    ) sub ON sub.fam_grp_sid=fam.fam_grp_sid
  LEFT JOIN
    (
     SELECT pgh_level1.prod_grp_sid fam_item_grp_sid,pgh_level3.prod_grp_sid AS int_item_grp_sid ,pgh_level3.prod_grp_name AS int_item_grp_name ,pgh_level3.prod_grp_nr AS int_item_grp_nr
     FROM CORE_REL.T_PRODUCT_GROUP_HIERARCHY pgh_level1
     LEFT JOIN CORE_REL.T_PRODUCT_GROUP pg
     ON pgh_level1.prod_grp_sid = pg.prod_grp_sid AND pg.dwh_valid_fg=true
        AND pg.prod_grp_type_cd = 'IFG'
     LEFT JOIN 
	    ( SELECT pgh.parent_prod_grp_sid,pg1.prod_grp_sid, pg1.prod_grp_name,pg1.prod_grp_nr
          FROM CORE_REL.T_PRODUCT_GROUP pg1
          LEFT JOIN CORE_REL.T_PRODUCT_GROUP_HIERARCHY pgh  
          ON pgh.prod_grp_sid = pg1.prod_grp_sid AND pgh.dwh_valid_fg = true
             AND pg1.dwh_valid_fg = true  AND pg1.prod_grp_type_cd = 'SIG'
         ) pgh_level2
     ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
     LEFT JOIN 
	    ( SELECT pg.prod_grp_sid, pg.prod_grp_name,pg.prod_grp_nr
          FROM   CORE_REL.T_PRODUCT_GROUP pg
          WHERE pg.dwh_valid_fg = true
          AND pg.prod_grp_type_cd = 'IGI'
         ) pgh_level3
     ON pgh_level2.parent_prod_grp_sid = pgh_level3.prod_grp_sid
     WHERE pgh_level1.dwh_valid_fg = true
  ) int ON int.fam_item_grp_sid = fam.fam_grp_sid
  INNER JOIN core_rel.t_internal_organization io ON io.int_org_sid=lp.int_org_sid AND io.dwh_valid_fg 
  LEFT JOIN core_rel.t_product_dispatch_group pdg ON lp.prod_sid = pdg.prod_sid AND lp.int_org_sid = pdg.int_org_sid AND pdg.dwh_valid_fg = 1
  LEFT JOIN
          (
           SELECT dispatch_grp_descr,dispatch_grp_nr,int_org_sid,IFF(lang_cd = 'DE',0,1) ourorder
           FROM core_rel.t_dispatch_group
           QUALIFY ROW_NUMBER() OVER (PARTITION BY dispatch_grp_nr,int_org_sid ORDER BY ourorder) = 1  
           ) dg ON pdg.dispatch_grp_nr = dg.dispatch_grp_nr and pdg.int_org_sid = dg.int_org_sid
  LEFT JOIN core_rel.t_product_listing prlst ON prlst.prod_sid = lp.prod_sid AND lp.int_org_sid = prlst.int_org_sid AND prlst.dwh_valid_fg AND lp.dwh_valid_fg
  LEFT JOIN core_rel.t_listing_type lstt ON lstt.list_type_cd = prlst.list_type_cd AND  lstt.lang_cd = 'DE'
  LEFT JOIN core_rel.t_product_order_area proa ON lp.prod_sid = proa.prod_sid AND lp.int_org_sid = proa.int_org_sid AND lp.dwh_valid_fg AND proa.dwh_valid_fg
  LEFT JOIN core_rel.t_order_area orda ON orda.order_area_nr = proa.order_area_nr AND orda.lang_cd = 'DE'
  LEFT JOIN core_rel.t_product_supplier prod_sup ON prod_sup.prod_sid = lp.prod_sid AND prod_sup.dwh_valid_fg AND prod_sup.int_org_sid = lp.int_org_sid
  LEFT JOIN core_rel.t_organization org on prod_sup.sup_sid = org.org_sid  AND org.dwh_valid_fg = 1 AND org.org_type_cd = 'SUPPLIER'
  WHERE lp.dwh_valid_fg = true
  QUALIFY ROW_NUMBER() over (partition by lp.prod_sid ,lp.int_org_sid order by ALT_LOCAL_PROD_NR_CNT desc) = 1  
  
UNION

SELECT 
  -1 AS prod_sid,
  int_org_sid AS country_org_sid,
  country_org_cd AS country_org_cd,
  '1900-01-01 00:00:00.000' AS dwh_valid_from_tmsp,
  '9999-12-31 23:59:59.999' AS dwh_valid_to_tmsp,
  TRUE AS dwh_valid_fg,
  '@' AS local_prod_nr,
  NULL as ALT_1_LOCAL_PROD_NR,
  NULL as ALT_2_LOCAL_PROD_NR,
  NULL as ALT_3_LOCAL_PROD_NR,
  NULL as ALT_4_LOCAL_PROD_NR,
  NULL as ALT_5_LOCAL_PROD_NR,
  NULL AS ALT_6_LOCAL_PROD_NR,
  NULL AS ALT_7_LOCAL_PROD_NR,
  NULL AS ALT_8_LOCAL_PROD_NR,
  NULL AS ALT_9_LOCAL_PROD_NR,
  NULL AS ALT_10_LOCAL_PROD_NR,
  NULL AS ALT_11_LOCAL_PROD_NR,
  NULL AS ALT_12_LOCAL_PROD_NR,
  NULL AS ALT_13_LOCAL_PROD_NR,
  NULL AS ALT_14_LOCAL_PROD_NR,
  NULL AS ALT_15_LOCAL_PROD_NR,
  NULL AS ALT_16_LOCAL_PROD_NR,
  NULL AS ALT_17_LOCAL_PROD_NR,
  NULL AS ALT_18_LOCAL_PROD_NR,
  NULL AS ALT_19_LOCAL_PROD_NR,
  NULL AS ALT_20_LOCAL_PROD_NR,
  0 as ALT_LOCAL_PROD_NR_CNT,
  '@' AS local_prod_name,
  '@' AS local_prod_descr,
  '@' AS local_prod_version_nr,
  '1900-01-01 00:00:00.000' AS local_prod_creation_dt,
  '@'  AS plu_nr,
  '@' AS prod_status_cd,
  'unbekannt' AS prod_status_descr,
  '@'  AS brand_type_cd,
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
  '@' as DISPATCH_UNIT_CD,
  'unbekannt' as DISPATCH_UNIT_DESCR,  
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
  -1 AS item_fam_sid,
  '@' AS item_fam_nr,
  '@' AS item_fam_name,
  -1 AS sub_item_grp_sid,
  '@' AS sub_item_grp_nr,
  '@' AS sub_item_grp_name,
  -1 AS int_item_grp_sid,
  '@' AS int_item_grp_nr,
  '@' AS int_item_grp_name,
  '-1' AS pillar_sid,
  '@' AS pillar_nr,
  'unbekannt' AS pillar_name,
  '-1' AS main_pillar_sid,
  '@' AS main_pillar_nr,
  'unbekannt' AS main_pillar_name,
  TRUE AS country_specific_prod_fg,
  'DUMMY' dwh_node_cd,
  current_timestamp AS extraction_tmsp,
  '1900-01-01 00:00:00.000' AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS record_id,
  ${LOAD_ID} AS load_is,
  'DUMMY' AS filename
FROM core_rel.t_internal_organization o
JOIN meta.t_party_key k ON int_org_sid =party_sid AND k.party_key_type_cd = 'COUNTRY' AND k.dwh_valid_fg 
WHERE  o.dwh_valid_fg
;
