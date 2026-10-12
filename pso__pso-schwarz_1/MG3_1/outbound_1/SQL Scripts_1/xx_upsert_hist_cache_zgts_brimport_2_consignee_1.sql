INSERT INTO SZD_PRODUCTON.${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (consignee_id, consignee_name, party_key_type_cd, country_location_key_type_cd, country_location_id, dwh_src_file_name, consignee_additional_name, dwh_src_1_tmsp, dwh_mapping_tmsp, tf_error_fg, deleted_fg, record_id, filename)
  SELECT DISTINCT
      consignee_id AS CONSIGNEE_ID,
      coalesce(nullif(trim(eg.entitaetsnr, ' '), 'NULL'), 'Unknown') AS consignee_name,
      'CONSIGNEE' AS party_key_type_cd,
      'COUNTRY_1' AS country_location_key_type_cd,
      coalesce(max(nullif(upper(trim(l.ustidlandcode, ' ')), 'NULL')), '-1') AS country_location_id,
      max(g.dwh_src_file_name),
      max(nullif(trim(a.kurzname, ' '), 'NULL')) as consignee_additional_name,
      max(g.dwh_src_1_tmsp) as dwh_src_1_tmsp,
      current_timestamp() as dwh_mapping_tmsp,
      0 as tf_error_fg,
      0 as deleted_fg,
      0 as record_id,
      max(g.dwh_src_file_name) as filename
    from
      szd_production.etl.t_cache_sggp_1 as g
      inner join szd_production.etl.t_cache_sgadr_1 as a on g.adrid = a.adrid
      inner join szd_production.etl.t_cache_ssland_1 as l on a.landid = l.landid
      inner join szd_production.etl.t_cache_sventitaet_1 as eg on g.gpid = eg.entitaetsid
      cross join unnest(array[
        nullif(upper(trim(eg.entitaetsnr, ' ')), 'NULL')
      ]) AS consignee_id
    WHERE nullif(consignee_id, 'NULL') IS NOT NULL
    GROUP BY 1, 2, 3, 4, 9, 10, 11, 12
;
INSERT INTO SZD_PRODUCTON.${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (CONSIGNEE_ID, CONSIGNEE_NAME, PARTY_KEY_TYPE_CD, COUNTRY_LOCATION_KEY_TYPE_CD, COUNTRY_LOCATION_ID, DWH_SRC_FILE_NAME, CONSIGNEE_ADDITIONAL_NAME, DWH_SRC_1_TMSP, DWH_MAPPING_TMSP, TF_ERROR_FG, DELETED_FG, RECORD_ID, FILENAME)
  SELECT
      CT1.*
    FROM
      (
        SELECT DISTINCT
            CT.*
          FROM
            (
              SELECT
                  consignee_id AS consignee_id,
                  coalesce(nullif(upper(t_cache_zgts_brimport.parno_cons_name1), 'NULL'), 'Unknown') AS consignee_name,
                  'CONSIGNEE' AS party_key_type_cd,
                  'COUNTRY_1' AS country_location_key_type_cd,
                  'GB' AS country_location_id,
                  max(t_cache_zgts_brimport.dwh_src_file_name) as dwh_src_file_name,
                  null as consignee_additional_name,
                  t_cache_zgts_brimport.dwh_src_1_tmsp as dwh_src_1_tmsp,
                  coalesce(t_cache_zgts_brimport.etd, t_cache_zgts_brimport.etats) as dwh_mapping_tmsp,
                  0 as tf_error_fg,
                  0 as deleted_fg,
                  0 as record_id,
                  max(max(t_cache_zgts_brimport.dwh_src_file_name)) as filename
                from
                  szd_production.etl.t_cache_zgts_brimport_1
                  cross join unnest(array[
                    nullif(upper(trim(t_cache_zgts_brimport.parno_cons_name1, ' ')), 'NULL')
                  ]) AS consignee_id
                WHERE nullif(consignee_id, 'NULL') IS NOT NULL
                GROUP BY 1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12
            ) AS CT
            Left outer join szd_production.meta.t_location_key_1 as l on l.location_key_type_cd = ct.country_location_key_type_cd
             and l.location_nat_key_nr = ct.country_location_id
            left outer join szd_production.core_rel.t_consignee_1 as c on l.location_sid = c.country_location_sid
            left outer join szd_production.meta.t_party_key_1 as pk on pk.party_key_type_cd = ct.party_key_type_cd
             and ct.consignee_id = pk.party_nat_key_nr
            left outer join szd_production.core_rel.t_consignee_1 as c1 on pk.party_sid = c1.party_sid
          where c.country_location_sid is null
           or c1.party_sid is null
      ) as ct1
      left outer join szd_production.etl.t_tf_cache_zgts_brimport_2_consignee_int as tf on ct1.consignee_id = tf.consignee_id
    where tf.consignee_id is null
;
