INSERT INTO dbp_etl.nielsen_mkt (mandant_id, mat_kjmo, file_name, tag_1, short, long, display_order,
 parent_tag, hier_num, hier_name, hier_level_num, hier_level_name, td_update, td_insert)
(SELECT mandant_id,
  mat_kjmo,
  file_name,
  tag_1,
  short,
  long,
  display_order,
  parent_tag,
  hier_num,
  hier_name,
  hier_level_num,
  hier_level_name,
  td_update,
  td_insert
 FROM ${TEMP_TABLE});