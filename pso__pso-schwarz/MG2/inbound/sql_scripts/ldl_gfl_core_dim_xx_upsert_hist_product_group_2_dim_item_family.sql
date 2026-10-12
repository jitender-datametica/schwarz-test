INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
item_fam_sid,
item_fam_nr,
item_fam_name,
item_fam_name_de,
item_fam_name_en,
prod_grp_status_cd,
prod_grp_status_descr,
sub_item_grp_sid,
sub_item_grp_nr,
sub_item_grp_name,
food_fg,
int_item_grp_sid,
int_item_grp_nr,
int_item_grp_name,
dwh_mapping_tmsp,
dwh_valid_fg,
dwh_load_id,
dwh_node_cd,
tf_error_fg,
error_descr,
record_id,
filename,
deleted_fg
)

select 
pg1.prod_grp_sid,
pg1.prod_grp_nr,
pg1.prod_grp_name,
coalesce(pgn.prod_grp_name,'@'),
coalesce(pge.prod_grp_name,'@'),
coalesce(pgs.prod_grp_status_type_cd, '@'),
Coalesce(pgst.prod_grp_status_type_descr, '@'),
Coalesce(pgh1.parent_prod_grp_sid, -1),
Coalesce(pg2.prod_grp_nr, '@'),
Coalesce(pg2.prod_grp_name, '@'),
CASE 
when to_number(pg2.prod_grp_nr) between 20 and 99 then TRUE
else FALSE end,
Coalesce(pgh2.parent_prod_grp_sid, -1),
Coalesce(pg3.prod_grp_nr, '@'),
Coalesce(pg3.prod_grp_name, '@'),
pg1.dwh_valid_from_tmsp as dwh_mapping_tmsp,
pg1.dwh_valid_fg,
${LOAD_ID},
pg1.dwh_node_cd,
0 tf_error_fg,
'' error_descr,
0 record_id,
'core_rel' filename,
0 deleted_fg
from core_rel.t_product_group pg1
left join core_rel.t_product_group_name pgn 
on pg1.prod_grp_sid = pgn.prod_grp_sid 
and pgn.dwh_valid_fg
AND pgn.lang_cd = 'DE'
left join core_rel.t_product_group_name pge
on pg1.prod_grp_sid = pge.prod_grp_sid 
and pge.dwh_valid_fg
AND pge.lang_cd = 'EN'
left Join core_rel.t_product_group_status pgs 
on pg1.prod_grp_sid = pgs.prod_grp_sid 
and pgs.dwh_valid_fg
left join core_rel.t_product_group_status_type pgst 
on pgs.prod_grp_status_type_cd = pgst.prod_grp_status_type_cd
and pgst.lang_cd='DE'
left join core_rel.t_product_group_hierarchy pgh1 
on pg1.prod_grp_sid = pgh1.prod_grp_sid 
and pgh1.dwh_valid_fg
and pgh1.prod_grp_hierarchy_type_cd = 'IGH'
left join core_rel.t_product_group pg2
on pgh1.parent_prod_grp_sid = pg2.prod_grp_sid
and pg2.dwh_valid_fg
and pg2.prod_grp_type_cd = 'SIG'
Left Join core_rel.t_product_group_hierarchy pgh2 
on pg2.prod_grp_sid = pgh2.prod_grp_sid 
and pgh2.dwh_valid_fg
and pgh2.prod_grp_hierarchy_type_cd = 'IGH'
left join core_rel.t_product_group pg3
on pgh2.parent_prod_grp_sid = pg3.prod_grp_sid
and pg3.dwh_valid_fg
and pg3.prod_grp_type_cd = 'IGI'
where pg1.prod_grp_type_cd = 'IFG'
UNION
SELECT 
  -1 prod_grp_sid,
  '@' prod_grp_nr,
  '@' prod_grp_name,
  '@' prod_grp_name,
  '@' prod_grp_name,
  '@' prod_grp_status_type_cd,
  '@' prod_grp_status_type_descr,
  -1 parent_prod_grp_sid,
  '@' prod_grp_nr,
  '@' prod_grp_name,
   FALSE food_fg,
   -1 parent_prod_grp_sid,
  '@' prod_grp_nr,
  '@' prod_grp_name,
  '1900-01-01 00:00:00.000' dwh_mapping_tmsp,
  TRUE dwh_valid_fg,
  ${LOAD_ID} dwh_load_id,
  'DUMMY' dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'DUMMY' filename,
  0 deleted_fg;
