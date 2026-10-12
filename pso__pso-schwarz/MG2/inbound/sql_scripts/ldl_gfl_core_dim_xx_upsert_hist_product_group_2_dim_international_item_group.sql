INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
int_item_grp_sid,
int_item_grp_nr,
int_item_grp_name,
int_item_grp_name_de,
int_item_grp_name_en,
prod_grp_status_cd,
prod_grp_status_descr,
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
pg1.dwh_valid_from_tmsp as dwh_mapping_tmsp,
pg1.dwh_valid_fg,
${LOAD_ID} dwh_load_id,
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
where pg1.prod_grp_type_cd = 'IGI'
UNION
SELECT 
   -1 int_item_grp_sid,
  '@' int_item_grp_nr,
  '@' int_item_grp_name,
  '@' int_item_grp_name_de,
  '@' int_item_grp_name_en,
  '@' prod_grp_status_cd,
  '@' prod_grp_status_descr,
  '1900-01-01 00:00:00.000' dwh_mapping_tmsp,
  TRUE dwh_valid_fg,
  ${LOAD_ID} dwh_load_id,
  'DUMMY' dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'DUMMY' filename,
  0 deleted_fg;
