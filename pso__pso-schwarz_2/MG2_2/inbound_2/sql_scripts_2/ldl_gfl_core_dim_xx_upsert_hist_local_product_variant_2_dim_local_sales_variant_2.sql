INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  sales_variant_sid,
  country_org_sid,
  country_org_cd,
  local_sales_variant_nr,
  local_sales_variant_name,
  prod_variant_status_cd,
  prod_variant_status_descr,
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
  dwh_load_id,
  dwh_node_cd,
  dwh_mapping_tmsp,
  dwh_valid_fg,
 -- extraction_tmsp,
  tf_error_fg,
  record_id,
  filename
  )
select 
lpv.prod_variant_sid,
lpv.int_org_sid,
int_org.country_org_cd,
lpv.local_prod_variant_nr,
lpv.local_prod_variant_name,
'@' PROD_VARIANT_STATUS_CD,
'Unbekannt' PROD_VARIANT_STATUS_DESCR,
lpv.prod_sid,
Coalesce(prod.local_prod_nr, '@'),
Coalesce(prod.local_prod_name, 'Unbekannt'),
coalesce(p_2_pg.prod_grp_sid,-1),
coalesce(pg.prod_grp_nr,'@'),
coalesce(pg.prod_grp_name,'Unbekannt'),
coalesce(tgh.sub_item_grp_sid,-1),
coalesce(tgh.sub_item_grp_nr,'@'),
coalesce(tgh.sub_item_grp_name,'Unbekannt'),
coalesce(pgh_level3.prod_grp_sid,-1),
coalesce(pgh_level3.prod_grp_nr,'@'),
coalesce(pgh_level3.prod_grp_name,'Unbekannt'),
'-1' pilar_sid,
'@'pilar_nr,
'unbekannt' pilar_name, 
'-1' main_pilar_sid,
'@'main_pilar_nr,
'unbekannt' main_pilar_name,
${LOAD_ID} dwh_load_id,
lpv.dwh_node_cd,
lpv.dwh_valid_from_tmsp as dwh_mapping_tmsp,
lpv.dwh_valid_fg,
--current_timestamp extraction_tmsp,
0 tf_error_fg,
0 record_id,
'core_rel' filename
from core_rel.T_LOCAL_PRODUCT_VARIANT_2 lpv
left join core_rel.t_product_variant_2 pv 
on lpv.prod_variant_sid = pv.prod_variant_sid 
and pv.dwh_valid_fg =true
LEFT JOIN CORE_REL.T_INTERNAL_ORGANIZATION_2 int_org
ON lpv.int_org_sid = int_org.int_org_sid
AND int_org.dwh_valid_fg = true
JOIN CORE_REL.T_LOCAL_PRODUCT_2  prod
ON  prod.dwh_valid_fg =true
AND prod.prod_sid = lpv.prod_sid
and prod.int_org_sid = lpv.int_org_sid
LEFT JOIN CORE_REL.T_PRODUCT_TO_PRODUCT_GROUP_2 p_2_pg
ON  p_2_pg.prod_sid = prod.prod_sid
AND p_2_pg.dwh_valid_fg = true
AND p_2_pg.prod_grp_type_cd='IFG'
LEFT JOIN CORE_REL.T_PRODUCT_GROUP_2 pg
ON p_2_pg.prod_grp_sid = pg.prod_grp_sid
AND pg.prod_grp_type_cd = 'IFG'
AND pg.dwh_valid_fg = true
LEFT JOIN
(SELECT distinct pgh_level1.parent_prod_grp_sid, pgh_level2.prod_grp_sid AS sub_item_grp_sid ,pgh_level2.prod_grp_name AS sub_item_grp_name ,pgh_level2.prod_grp_nr AS sub_item_grp_nr
    FROM CORE_REL.T_PRODUCT_GROUP_HIERARCHY_2 pgh_level1
    LEFT JOIN (SELECT pgh.parent_prod_grp_sid,pg1.prod_grp_sid, pg1.prod_grp_name,pg1.prod_grp_nr
          FROM CORE_REL.T_PRODUCT_GROUP_2 pg1
          LEFT JOIN CORE_REL.T_PRODUCT_GROUP_HIERARCHY_2 pgh  
          ON pgh.prod_grp_sid = pg1.prod_grp_sid
          AND pgh.dwh_valid_fg = true
          AND pg1.dwh_valid_fg = true
          AND pg1.prod_grp_type_cd = 'SIG'
          ) pgh_level2
    ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid) tgh
ON tgh.parent_prod_grp_sid =  p_2_pg.prod_grp_sid   
left join 
(select distinct pgh_level2.parent_prod_grp_sid, pgh_level3.prod_grp_sid, pgh_level3.prod_grp_nr, pgh_level3.prod_grp_name FROM CORE_REL.T_PRODUCT_GROUP_HIERARCHY_2 pgh_level1
    LEFT JOIN CORE_REL.T_PRODUCT_GROUP_2 pg
    ON pgh_level1.prod_grp_sid = pg.prod_grp_sid
    AND pg.prod_grp_type_cd = 'IFG'
    LEFT JOIN (SELECT pgh.parent_prod_grp_sid,pg1.prod_grp_sid, pg1.prod_grp_name,pg1.prod_grp_nr
          FROM CORE_REL.T_PRODUCT_GROUP_2 pg1
          LEFT JOIN CORE_REL.T_PRODUCT_GROUP_HIERARCHY_2 pgh  
          ON pgh.prod_grp_sid = pg1.prod_grp_sid
          AND pgh.dwh_valid_fg = true
          AND pg1.dwh_valid_fg = true
          AND pg1.prod_grp_type_cd = 'SIG'
          ) pgh_level2
    ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
    LEFT JOIN (SELECT pg.prod_grp_sid, pg.prod_grp_name,pg.prod_grp_nr
          FROM   CORE_REL.T_PRODUCT_GROUP_2 pg
          WHERE pg.dwh_valid_fg = true
          AND pg.prod_grp_type_cd = 'IGI'
          ) pgh_level3
          on pgh_level2.parent_prod_grp_sid = pgh_level3.prod_grp_sid  ) pgh_level3
on sub_item_grp_sid = pgh_level3.parent_prod_grp_sid
where lpv.dwh_valid_fg = true and pv.prod_variant_type_cd='SALES_2';
