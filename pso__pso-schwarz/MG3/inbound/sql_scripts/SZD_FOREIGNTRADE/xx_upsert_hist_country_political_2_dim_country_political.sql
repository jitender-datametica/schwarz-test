INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
location_sid,
dwh_mapping_tmsp,
dwh_valid_fg,
iso_country_cd,
country_name_de, 
country_name_en,
curr_cd,
latitude,
longitude,
eu_member_fg,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
record_id,
filename,
deleted_fg
)
select
distinct  
de.location_sid,
de.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
1 dwh_valid_fg,
de.iso_country_cd,
de.country_name  country_name_de, 
en.country_name  country_name_en,
de.curr_cd,
de.latitude,
de.longitude,
CASE WHEN cur.country_location_sid IS NOT NULL THEN TRUE ELSE FALSE END eu_member_fg,
de.dwh_src_file_name,
de.dwh_src_1_tmsp,
0 tf_error_fg,
0 record_id,
de.dwh_src_file_name filename,
0 deleted_fg
FROM 
(select *
         from core_rel.t_country_political
        where (lang_cd = 'DE'
           or location_sid = -1) and DWH_VALID_FG=1
      ) de
  join(select *
         from core_rel.t_country_political
        where (lang_cd = 'EN' 
           or location_sid = -1) and DWH_VALID_FG=1
      ) en
    on de.location_sid = en.location_sid
  left
  join core_rel.t_country_union_rel cur
    on de.location_sid = cur.country_location_sid
   and cur.country_union_cd = 'EU' 
where
de.location_sid != -1;
