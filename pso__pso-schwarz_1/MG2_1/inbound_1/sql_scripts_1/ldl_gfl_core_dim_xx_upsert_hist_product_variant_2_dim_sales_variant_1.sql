INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  sales_variant_sid,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  sales_variant_nr,
  gtin,
  sales_variant_name,
  prod_variant_status_cd,
  prod_variant_status_descr,
  sales_variant_type_cd,
  sales_variant_type_descr,
  weight_based_fg,
  sales_variant_content_meas,
  unit_cnt,
  unit_content_meas,
  content_uom_cd,
  non_food_variant_type_cd,
  non_food_variant_type_descr,
  size_name,
  style_name,
  kind_name,
  fruits_and_vegetables_class_cd,
  fruits_and_vegetables_class_descr,
  min_caliber_meas,
  max_caliber_meas,
  caliber_uom_cd,
  country_of_origin_cd,
  country_of_origin_name,
  prod_sid,
  prod_nr,
  prod_name,
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
  dwh_node_cd,
  extraction_tmsp,
  dwh_mapping_tmsp,
  tf_error_fg,
  record_id,
  dwh_load_id,
  filename
  )
SELECT
  pv.prod_variant_sid AS sales_variant_sid,
  pv.dwh_valid_from_tmsp AS dwh_valid_from_tmsp,
  pv.dwh_valid_to_tmsp AS dwh_valid_to_tmsp,
  pv.dwh_valid_fg AS dwh_valid_fg,
  substr(prod_variant_nr,1,20) AS sales_variant_nr,
  pv.gtin AS gtin,
  coalesce (prod_variant_name ,'Unbekannt') AS sales_variant_name,
  'na' AS prod_variant_status_cd,
  'na' AS prod_variant_status_descr,
  coalesce (pv.sales_variant_type_cd,'@') AS sales_variant_type_cd,
  coalesce (sales_variant_type_descr,'@') AS sales_variant_type_descr,
  coalesce (weight_based_fg,false) AS weight_based_fg,
  pv.sales_variant_content_meas AS sales_variant_content_meas,
  coalesce (unit_cnt,0) AS unit_cnt,
  pv.unit_content_meas AS unit_content_meas,
  coalesce (um.uom_cd,'@')  AS content_uom_cd,
  coalesce (pv.non_food_variant_type_cd ,'@')  AS non_food_variant_type_cd,
  coalesce (non_food_variant_type_descr,'@') AS non_food_variant_type_descr,
  pv.size_name AS size_name,
  pv.style_name AS style_name,
  pv.kind_name AS kind_name,
  coalesce (pv.fruits_and_vegetables_class_cd,'@') AS fruits_and_vegetables_class_cd,
  coalesce (fruits_and_vegetables_class_descr,'@') AS fruits_and_vegetables_class_descr,
  pv.min_caliber_meas AS min_caliber_meas,
  pv.max_caliber_meas AS max_caliber_meas,
  coalesce (pv.caliber_uom_cd,'@') AS caliber_uom_cd,
  coalesce (iso_country_cd,'@') AS country_of_origin_cd,
  coalesce (country_name,'@') AS country_of_origin_name,
  coalesce(pv.prod_sid ,-1) AS prod_sid,
  Coalesce(prod.prod_nr, '@') AS prod_nr,
  Coalesce(prod.prod_name, 'Unbekannt') AS prod_name,
  coalesce(fam.fam_grp_sid  ,-1) AS item_fam_sid,
  coalesce(fam_group_nr,'@') AS item_fam_nr,
  coalesce(fam_group_name,'@') AS item_fam_name,
  coalesce(sub.sub_item_grp_sid ,-1) AS sub_item_grp_sid,
  coalesce(sub_item_grp_nr,'@') AS sub_item_grp_nr,
  coalesce(sub_item_grp_name,'@') AS sub_item_grp_name,
  coalesce(int.int_item_grp_sid  ,-1) AS int_item_grp_sid,
  coalesce(int_item_grp_nr,'@') AS int_item_grp_nr,
  coalesce(int_item_grp_name,'@') AS int_item_grp_name,
  -1 AS pillar_sid,
  '@' AS pillar_nr,
  '@' AS pillar_name,
  -1 AS main_pillar_sid,
  '@' AS main_pillar_nr,
  '@' AS main_pillar_name,
  pv.dwh_node_cd,
  current_timestamp AS extraction_tmsp,
  pv.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS record_id,
  ${LOAD_ID} AS load_is,
  'core_rel' AS filename
FROM core_rel.t_product_variant_1 pv
LEFT JOIN core_rel.t_sales_variant_type_1 svt ON  svt.sales_variant_type_cd = pv.sales_variant_type_cd AND svt.lang_cd = 'DE'
LEFT JOIN core_rel.t_non_food_variant_type_1 nfvt ON nfvt.non_food_variant_type_cd = pv.non_food_variant_type_cd AND nfvt.lang_cd = 'DE'
LEFT JOIN core_rel.t_fruits_and_vegetables_class_1 fvc  ON fvc.fruits_and_vegetables_class_cd = pv.fruits_and_vegetables_class_cd AND fvc.lang_cd = 'DE'
LEFT JOIN core_rel.t_country_1 cntr ON cntr.country_sid = pv.country_of_origin_sid  AND cntr.dwh_valid_fg
LEFT JOIN CORE_REL.T_PRODUCT_1 prod ON  prod.dwh_valid_fg =true AND prod.prod_sid = pv.prod_sid
LEFT JOIN 
    (SELECT  prod_sid, pgh.prod_grp_sid as fam_grp_sid  ,pg.dwh_valid_fg,prod_grp_nr fam_group_nr,	prod_grp_name fam_group_name from core_rel.t_product_to_product_group_1 pgh
     JOIN core_rel.t_product_group_1 pg
         ON pgh.prod_grp_sid = pg.prod_grp_sid
         AND pg.prod_grp_type_cd = 'IFG'
         AND pg.dwh_valid_fg =true
     WHERE pgh.dwh_valid_fg = TRUE 
    ) fam ON fam.prod_sid=prod.prod_sid
 LEFT JOIN
    (SELECT pgh_level1.prod_grp_sid fam_grp_sid
          , pgh_level2.prod_grp_sid AS sub_item_grp_sid
          , pgh_level2.prod_grp_name AS sub_item_grp_name
          , pgh_level2.prod_grp_nr AS sub_item_grp_nr
       FROM CORE_REL.T_PRODUCT_GROUP_HIERARCHY_1 pgh_level1
       LEFT JOIN (SELECT pgh.parent_prod_grp_sid,pg1.prod_grp_sid, pg1.prod_grp_name,pg1.prod_grp_nr
                    FROM CORE_REL.T_PRODUCT_GROUP_1 pg1
                    LEFT JOIN CORE_REL.T_PRODUCT_GROUP_HIERARCHY_1 pgh  
                      ON pgh.prod_grp_sid = pg1.prod_grp_sid
                     AND pgh.dwh_valid_fg = true
                     AND pg1.dwh_valid_fg = true
                     AND pg1.prod_grp_type_cd = 'SIG'
                 ) pgh_level2
                ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid 
      WHERE pgh_level1.dwh_valid_fg 
    ) sub ON sub.fam_grp_sid=fam.fam_grp_sid
  LEFT JOIN
    (
      SELECT pgh_level1.prod_grp_sid fam_item_grp_sid,pgh_level3.prod_grp_sid AS int_item_grp_sid ,pgh_level3.prod_grp_name AS int_item_grp_name ,pgh_level3.prod_grp_nr AS int_item_grp_nr
      FROM CORE_REL.T_PRODUCT_GROUP_HIERARCHY_1 pgh_level1
      LEFT JOIN CORE_REL.T_PRODUCT_GROUP_1 pg
               ON pgh_level1.prod_grp_sid = pg.prod_grp_sid AND pg.dwh_valid_fg=true
               AND pg.prod_grp_type_cd = 'IFG'
      LEFT JOIN 
	       (SELECT pgh.parent_prod_grp_sid,pg1.prod_grp_sid, pg1.prod_grp_name,pg1.prod_grp_nr
            FROM CORE_REL.T_PRODUCT_GROUP_1 pg1
            LEFT JOIN CORE_REL.T_PRODUCT_GROUP_HIERARCHY_1 pgh  
                      ON pgh.prod_grp_sid = pg1.prod_grp_sid
                      AND pgh.dwh_valid_fg = true
                      AND pg1.dwh_valid_fg = true
                      AND pg1.prod_grp_type_cd = 'SIG'
            ) pgh_level2
              ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
      LEFT JOIN 
	      (SELECT pg.prod_grp_sid, pg.prod_grp_name,pg.prod_grp_nr
           FROM   CORE_REL.T_PRODUCT_GROUP_1 pg
           WHERE pg.dwh_valid_fg = true
                AND pg.prod_grp_type_cd = 'IGI'
           ) pgh_level3
             ON pgh_level2.parent_prod_grp_sid = pgh_level3.prod_grp_sid
      WHERE pgh_level1.dwh_valid_fg = true
  ) int ON int.fam_item_grp_sid = fam.fam_grp_sid
left join CORE_DIM.T_DIM_UNIT_OF_MEASURE_1 um 
on upper (pv.caliber_uom_cd) = upper (um.uom_cd)
where pv.dwh_valid_fg = true AND prod_variant_type_cd='SALES_1'
;
