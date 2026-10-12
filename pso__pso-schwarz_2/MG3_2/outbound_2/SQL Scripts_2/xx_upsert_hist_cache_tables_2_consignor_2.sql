INSERT INTO SZD_PRODUCTON.${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (consignor_name, party_id, party_key_type_cd, dwh_src_file_name, consignor_stream_cd, importer_party_id, importer_party_key_type_cd, dwh_src_1_tmsp, dwh_mapping_tmsp, tf_error_fg, deleted_fg, record_id, filename)
  SELECT
      src.*
    FROM
      (
        select
            consignor_name as consignor_name,
            upper(trim(consignor_name, ' ')) as party_id,
            'CONSIGNOR' as party_key_type_cd,
            t_cache_ceva.dwh_src_file_name,
            'EXTERNAL' as consignor_stream_cd,
            '-1' as importer_party_id,
            'IMPORTER' as importer_party_key_type_cd,
            t_cache_ceva.dwh_src_1_tmsp,
            t_cache_ceva.dwh_src_1_tmsp as dwh_mapping_tmsp,
            0 as tf_error_fg,
            0 as deleted_fg,
            0 as record_id,
            t_cache_ceva.dwh_src_file_name as filename
          from
            szd_production.etl.t_cache_ceva_2
            cross join unnest(array[
              upper(trim(t_cache_ceva.consignor_name, ' '))
            ]) as consignor_name
          where consignor_name <> 'NULL'
        union distinct
        select
            consignor_name as consignor_name,
            upper(trim(consignor_name, ' ')) as party_id,
            'CONSIGNOR' as party_key_type_cd,
            t_cache_maersk_lgb.dwh_src_file_name,
            'EXTERNAL' as consignor_stream_cd,
            '-1' as importer_party_id,
            'IMPORTER' as importer_party_key_type_cd,
            t_cache_maersk_lgb.dwh_src_1_tmsp,
            t_cache_maersk_lgb.dwh_src_1_tmsp as dwh_mapping_tmsp,
            0 as tf_error_fg,
            0 as deleted_fg,
            0 as record_id,
            t_cache_maersk_lgb.dwh_src_file_name as filename
          from
            szd_production.etl.t_cache_maersk_lgb_2
            cross join unnest(array[
              upper(trim(t_cache_maersk_lgb.consignor_name, ' '))
            ]) as consignor_name
          where consignor_name <> 'NULL'
        union distinct
        select
            consignor_name as consignor_name,
            upper(trim(consignor_name, ' ')) as party_id,
            'CONSIGNOR' as party_key_type_cd,
            t_cache_maersk_lukt.dwh_src_file_name,
            'EXTERNAL' as consignor_stream_cd,
            '-1' as importer_party_id,
            'IMPORTER' as importer_party_key_type_cd,
            t_cache_maersk_lukt.dwh_src_1_tmsp,
            t_cache_maersk_lukt.dwh_src_1_tmsp as dwh_mapping_tmsp,
            0 as tf_error_fg,
            0 as deleted_fg,
            0 as record_id,
            t_cache_maersk_lukt.dwh_src_file_name as filename
          from
            szd_production.etl.t_cache_maersk_lukt_2
            cross join unnest(array[
              upper(trim(t_cache_maersk_lukt.consignor_name, ' '))
            ]) as consignor_name
          where consignor_name <> 'NULL'
        union distinct
        select
            upper(trim(t_cache_cds_item.consignor, ' ')) as consignor_name,
            upper(trim(t_cache_cds_item.consignor, ' ')) as party_id,
            'CONSIGNOR' as party_key_type_cd,
            t_cache_cds_item.dwh_src_file_name,
            'EXTERNAL' as consignor_stream_cd,
            '-1' as importer_party_id,
            'IMPORTER' as importer_party_key_type_cd,
            t_cache_cds_item.dwh_src_1_tmsp,
            t_cache_cds_item.dwh_src_1_tmsp as dwh_mapping_tmsp,
            0 as tf_error_fg,
            0 as deleted_fg,
            0 as record_id,
            t_cache_cds_item.dwh_src_file_name as filename
          from
            szd_production.etl.t_cache_cds_item_2
          where t_cache_cds_item.consignor <> 'NULL'
      ) as src
      left outer join szd_production.meta.t_party_key_2 as p on src.party_id = p.party_nat_key_nr
      left outer join szd_production.core_rel.t_consignor_2 as c on p.party_sid = c.party_sid
    where c.party_sid is null
    qualify row_number() over (partition by src.party_id, src.dwh_mapping_tmsp order by if(src.dwh_src_file_name is null, 0, 1) desc, src.dwh_src_file_name) = 1
;
