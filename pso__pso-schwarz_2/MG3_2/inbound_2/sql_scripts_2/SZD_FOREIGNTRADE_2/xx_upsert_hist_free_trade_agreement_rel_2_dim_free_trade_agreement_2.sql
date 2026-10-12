INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
agreement_sid, dwh_valid_fg, import_country_location_sid,
import_iso_country_cd, 
import_country_name_de, 
import_country_name_en, 
origin_country_location_sid, 
origin_iso_country_cd, 
origin_country_name_de, 
origin_country_name_en, 
free_trade_agreement_category_cd, 
free_trade_agreement_category_name, 
free_trade_agreement_category_descr,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
record_id,
filename,
deleted_fg
)
select distinct fta.agreement_sid,
       fta.dwh_valid_fg,
       fta.import_country_location_sid,
       coalesce(ict_de.iso_country_cd, 'UNKNOWN') as import_iso_country_cd,
       coalesce(ict_de.country_name, 'Unbekannt') as import_country_name_de,
       coalesce(ict_en.country_name, 'Unknown') as import_country_name_en,
       fta.origin_country_location_sid,
       coalesce(oct_de.iso_country_cd, 'UNKNOWN') as origin_iso_country_cd,
       coalesce(oct_de.country_name, 'Unbekannt') as origin_country_name_de,
       coalesce(oct_en.country_name, 'Unknown') as origin_country_name_en,
       fta.free_trade_agreement_category_cd,
       cta.free_trade_agreement_category_name,
       cta.free_trade_agreement_category_descr,
fta.dwh_src_1_tmsp dwh_mapping_tmsp,
fta.dwh_src_file_name,
fta.dwh_src_1_tmsp,
0 tf_error_fg,
0 record_id,
fta.dwh_src_file_name filename,
0 deleted_fg
from core_rel.t_free_trade_agreement_rel_2 fta
  left
  join core_rel.t_country_political_2 ict_de
    on fta.import_country_location_sid = ict_de.location_sid
   and ict_de.lang_cd = 'DE' 
  left
  join core_rel.t_country_political_2 ict_en
    on fta.import_country_location_sid = ict_en.location_sid
   and ict_en.lang_cd = 'EN' 
  left 
  join core_rel.t_country_political_2 oct_de
    on fta.origin_country_location_sid = oct_de.location_sid
   and oct_de.lang_cd = 'DE' 
  left
  join core_rel.t_country_political_2 oct_en
    on fta.origin_country_location_sid = oct_en.location_sid
   and oct_en.lang_cd = 'EN' 
  left
  join core_rel.t_free_trade_agreement_category_2 cta
    on fta.free_trade_agreement_category_cd = cta.free_trade_agreement_category_cd
where fta.dwh_valid_fg;
