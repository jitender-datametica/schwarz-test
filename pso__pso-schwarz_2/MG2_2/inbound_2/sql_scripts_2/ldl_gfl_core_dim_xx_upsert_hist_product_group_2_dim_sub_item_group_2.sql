INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
sub_item_grp_sid,
sub_item_grp_nr,
sub_item_grp_name,
sub_item_grp_name_de,
sub_item_grp_name_en,
food_fg,
prod_grp_status_cd,
prod_grp_status_descr,
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
CASE 
when to_number(pg1.prod_grp_nr) between 20 and 99 then TRUE
else FALSE end,
coalesce(pgs.prod_grp_status_type_cd, '@'),
Coalesce(pgst.prod_grp_status_type_descr, '@'),
Coalesce(pgh1.parent_prod_grp_sid, -1),
Coalesce(pg3.prod_grp_nr, '@'),
Coalesce(pg3.prod_grp_name, '@'),
pg1.dwh_valid_from_tmsp as dwh_mapping_tmsp,
pg1.dwh_valid_fg,
${LOAD_ID} dwh_load_id,
pg1.dwh_node_cd,
0 tf_error_fg,
'' error_descr,
0 record_id,
'core_rel' filename,
0 deleted_fg
from core_rel.t_product_group_2 pg1
left join core_rel.t_product_group_name_2 pgn 
on pg1.prod_grp_sid = pgn.prod_grp_sid 
and pgn.dwh_valid_fg
AND pgn.lang_cd = 'DE'
left join core_rel.t_product_group_name_2 pge
on pg1.prod_grp_sid = pge.prod_grp_sid 
and pge.dwh_valid_fg
AND pge.lang_cd = 'EN'
left Join core_rel.t_product_group_status_2 pgs 
on pg1.prod_grp_sid = pgs.prod_grp_sid 
and pgs.dwh_valid_fg
left join core_rel.t_product_group_status_type_2 pgst 
on pgs.prod_grp_status_type_cd = pgst.prod_grp_status_type_cd
and pgst.lang_cd='DE'
left join core_rel.t_product_group_hierarchy_2 pgh1 
on pg1.prod_grp_sid = pgh1.prod_grp_sid 
and pgh1.dwh_valid_fg
and pgh1.prod_grp_hierarchy_type_cd = 'IGH'
left join core_rel.t_product_group_2 pg3
on pgh1.parent_prod_grp_sid = pg3.prod_grp_sid
and pg3.dwh_valid_fg
and pg3.prod_grp_type_cd = 'IGI'
where pg1.prod_grp_type_cd = 'SIG'
UNION
SELECT 
  -1 sub_item_grp_sid,
  '@' sub_item_grp_nr,
  '@' sub_item_grp_name,
  '@' sub_item_grp_name_de,
  '@' sub_item_grp_name_en,
  FALSE food_fg,
  '@' prod_grp_status_cd,
  '@' prod_grp_status_descr,
  -1 int_item_grp_sid,
  '@' int_item_grp_nr,
  '@' int_item_grp_name,
  '1900-01-01 00:00:00.000' dwh_mapping_tmsp,
  TRUE dwh_valid_fg,
  ${LOAD_ID} dwh_load_id,
  'DUMMY_2' dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'core_rel' filename,
  0 deleted_fg;
