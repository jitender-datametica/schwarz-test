INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
location_sid,
       country_location_sid,
       iso_country_cd,
       country_name_de,
       country_name_en,
       transhipment_location_cd,
transhipment_location_name,
city_name,
transhipment_location_type_cd,
transhipment_location_type_name,
dwh_valid_fg,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
record_id,
filename,
deleted_fg
)
SELECT 
distinct tl.location_sid,
       tl.country_location_sid,
       cp_de.iso_country_cd,
       cp_de.country_name as country_name_de,
       cp_en.country_name as country_name_en,
       tl.transhipment_location_cd,
       tl.transhipment_location_name,
       tl.city_name,
       tl.transhipment_location_type_cd,
       tlt.transhipment_location_type_descr,
tl.dwh_valid_fg,
tl.dwh_valid_from_tmsp dwh_mapping_tmsp,
tl.dwh_src_file_name,
tl.dwh_src_1_tmsp,
0 tf_error_fg,
0 record_id,
tl.dwh_src_file_name filename,
0 deleted_fg
from core_rel.t_transhipment_location tl
  left
  join core_rel.t_country_political cp_de
    on tl.country_location_sid = cp_de.location_sid  AND (tl.country_location_sid!=-1 OR tl.location_sid=-1)
   and cp_de.lang_cd = decode(tl.country_location_sid, -1, '-1', 'DE')
  left 
  join core_rel.t_country_political cp_en
    on tl.country_location_sid = cp_en.location_sid  AND (tl.country_location_sid!=-1 OR tl.location_sid=-1)
   and cp_en.lang_cd = decode(tl.country_location_sid, -1, '-1', 'EN')
  join core_rel.t_transhipment_location_type tlt
    on tl.transhipment_location_type_cd = tlt.transhipment_location_type_cd
where tl.location_sid!=-1 and tl.dwh_valid_fg and (tl.country_location_sid!=-1 OR tl.location_sid=-1);
