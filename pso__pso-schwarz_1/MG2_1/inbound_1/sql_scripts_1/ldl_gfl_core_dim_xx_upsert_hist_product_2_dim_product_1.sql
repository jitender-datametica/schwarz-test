INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
prod_sid,
dwh_mapping_tmsp,
dwh_valid_fg,
prod_nr,
prod_name,
prod_descr,
prod_creation_dt,
prod_type_cd,
prod_type_descr,
item_type_cd,
item_type_descr,
prod_status_cd,
prod_status_descr,
prod_buying_status_cd,
prod_buying_status_descr,
prod_design_status_cd,
prod_design_status_descr,
packing_type_cd,
packing_type_descr,
goods_on_consignment_fg,
excl_from_vat_calc_fg,
country_specific_prod_fg,
item_fam_sid,
item_fam_nr,
item_fam_name,
sub_item_grp_sid,
sub_item_grp_nr,
sub_item_grp_name,
food_fg,
int_item_grp_sid,
int_item_grp_nr,
int_item_grp_name,
pillar_sid,
pillar_nr,
pillar_name,
main_pillar_sid,
main_pillar_nr,
main_pillar_name,
specific_country_org_sid,
specific_country_org_cd,
dwh_load_id,
dwh_node_cd,
tf_error_fg,
error_descr,
record_id,
filename,
deleted_fg
)
select distinct
p.prod_sid,
p.dwh_valid_from_tmsp as dwh_mapping_tmsp,
p.dwh_valid_fg,
p.prod_nr,
p.prod_name,
coalesce (p.prod_descr ,'@') prod_descr,
coalesce (p.prod_creation_dt ,To_Timestamp_LTZ('1900-01-01 00:00:00')),
p.prod_type_cd,
coalesce(pt.prod_type_descr,'@'),
coalesce(p.item_type_cd,'@') item_type_cd,
coalesce (it.item_type_descr ,'@') item_type_descr,
'-1' prod_status_cd,
'@' prod_status_descr,
'-1' prod_buying_status_cd,
'@' prod_buying_status_descr,
'-1' prod_design_status_cd,
'@' prod_design_status_descr,
coalesce (pack.packing_type_cd ,'@') packing_type_cd,
coalesce (pack.packing_type_descr ,'@') as packing_type_descr,
p.goods_on_consignment_fg,
p.excl_from_vat_calc_fg,
p.country_specific_prod_fg,
coalesce (pgh3.orig_prod_grp_sid ,'-1') item_fam_sid,
coalesce (pgh3.orig_prod_grp_nr ,'-1') item_fam_nr,
coalesce (pgh3.orig_prod_grp_name  ,'@') item_fam_name,
coalesce (pgh3.sub_item_grp_sid ,'-1') sub_item_grp_sid,
coalesce (pgh3.sub_item_grp_nr ,'-1') sub_item_grp_nr,
coalesce (pgh3.sub_item_grp_name ,'@') sub_item_grp_name,
case when p.item_type_cd = 'FOOD' THEN TRUE else FALSE end food_fg,
coalesce (pgh3.int_item_grp_sid ,-1) as int_item_grp_sid,
coalesce (pgh3.int_item_grp_nr ,-1) int_item_grp_nr,
coalesce (pgh3.int_item_grp_name ,'@') int_item_grp_name,
'-1' pillar_sid,
'-1' pillar_nr,
'@' pillar_name,
'-1' main_pillar_sid,
'-1' main_pillar_nr,
'@' main_pillar_name,
IFF(p.country_specific_prod_fg,NVL(lp.int_org_sid,-1),-1) specific_country_org_sid,
IFF(p.country_specific_prod_fg,org.country_org_cd,NULL) specific_country_org_cd,
${LOAD_ID} dwh_load_id,
p.dwh_node_cd dwh_node_cd,
0 as tf_error_fg,
'' as error_descr,
0 as record_id,
't_product_1' as filename,
0 as deleted_fg
from core_rel.t_product_1 p
left join core_rel.t_product_type_1 pt on p.prod_type_cd = pt.prod_type_cd  and pt.lang_cd = 'DE'
left join core_rel.t_item_type_1 it on p.item_type_cd = it.item_type_cd  and it.lang_cd = 'DE'
left join
(select  prod_sid, max(pgh.prod_grp_sid) as prod_grp_sid  ,pg1.dwh_valid_fg  from core_rel.t_product_to_product_group_1 pgh
join core_rel.t_product_group_1 pg1
on pgh.prod_grp_sid = pg1.prod_grp_sid
and pg1.prod_grp_type_cd = 'IFG'
and pg1.dwh_valid_fg =true
where
pg1.dwh_valid_fg = true
group by 1,3 ) pgh
on pgh.prod_sid = p.prod_sid
left join (
            SELECT pgh_level1.prod_grp_sid as orig_prod_grp_sid, 
                   pg.prod_grp_nr as orig_prod_grp_nr,
                   pg.prod_grp_name as orig_prod_grp_name,
                   pgh_level3.prod_grp_sid AS int_item_grp_sid,
                   pgh_level3.prod_grp_name AS int_item_grp_name ,pgh_level3.prod_grp_nr AS int_item_grp_nr,
                   pgh_level2.prod_grp_name AS sub_item_grp_name ,pgh_level2.prod_grp_nr AS sub_item_grp_nr,
                   pgh_level2.prod_grp_sid AS sub_item_grp_sid
            FROM CORE_REL.T_PRODUCT_GROUP_HIERARCHY_1 pgh_level1
            LEFT JOIN CORE_REL.T_PRODUCT_GROUP_1 pg ON pgh_level1.prod_grp_sid = pg.prod_grp_sid and pg.prod_grp_type_cd = 'IFG' and pg.dwh_valid_fg = 1 
            LEFT JOIN (SELECT pgh.parent_prod_grp_sid
                              ,pg1.prod_grp_sid
                              ,pg1.prod_grp_name
                              ,pg1.prod_grp_nr
                       FROM CORE_REL.T_PRODUCT_GROUP_1 pg1
                       LEFT JOIN CORE_REL.T_PRODUCT_GROUP_HIERARCHY_1 pgh  
                       ON pgh.prod_grp_sid = pg1.prod_grp_sid
                       AND pgh.dwh_valid_fg = true
                       AND pg1.dwh_valid_fg = true
                       AND pg1.prod_grp_type_cd = 'SIG'
                      ) pgh_level2 ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
            LEFT JOIN (SELECT pg.prod_grp_sid
                              ,pg.prod_grp_name
                              ,pg.prod_grp_nr
                       FROM   CORE_REL.T_PRODUCT_GROUP_1 pg
                       WHERE pg.dwh_valid_fg = true
                       AND pg.prod_grp_type_cd = 'IGI'
                      ) pgh_level3 ON pgh_level2.parent_prod_grp_sid = pgh_level3.prod_grp_sid
           ) pgh3
on pgh3.orig_prod_grp_sid = pgh.prod_grp_sid
LEFT JOIN core_rel.t_local_product_1 lp ON p.prod_sid=lp.prod_sid AND lp.dwh_valid_fg=TRUE
LEFT JOIN core_rel.t_internal_organization_1 org ON lp.int_org_sid = org.int_org_sid AND org.dwh_valid_fg=TRUE
LEFT JOIN core_rel.t_packing_type_1 pack on p.packing_type_cd = pack.packing_type_cd
where p.dwh_valid_fg=true

UNION

SELECT
  -1 prod_sid,
  '1900-01-01 00:00:00.000' dwh_mapping_tmsp,
  TRUE dwh_valid_fg,
  '@' prod_nr,
  '@' prod_name,
  '@' prod_descr,
  '1900-01-01 00:00:00.000' prod_creation_dt,
  '@' prod_type_cd,
  'unbekannt' prod_type_descr,
  '@' item_type_cd,
  'unbekannt' item_type_descr,
  '-1' prod_status_cd,
  'unbekannt' prod_status_descr,
  '-1' prod_buying_status_cd,
  '@' prod_buying_status_descr,
  '-1' prod_design_status_cd,
  'unbekannt' prod_design_status_descr,
  '@' packing_type_cd,
  'unbekannt' packing_type_descr,
  FALSE goods_on_consignment_fg,
  FALSE excl_from_vat_calc_fg,
  TRUE country_specific_prod_fg,
  '-1' item_fam_sid,
  '-1' item_fam_nr,
  '@' item_fam_name,
  '-1' sub_item_grp_sid,
  '-1' sub_item_grp_nr,
  '@' sub_item_grp_name,
  FALSE food_fg,
  -1 int_item_grp_sid,
  -1 int_item_grp_nr,
  '@' int_item_grp_name,
  '-1' pillar_sid,
  '-1' pillar_nr,
  '@' pillar_name,
  '-1' main_pillar_sid,
  '-1' main_pillar_nr,
  '@' main_pillar_name,
  -1 specific_country_org_sid,
  NULL specific_country_org_cd,
  ${LOAD_ID} dwh_load_id,
  'DUMMY_1' dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'DUMMY_1' as filename,
  0 deleted_fg;
