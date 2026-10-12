-- ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN TRANSACTION;
-- SELECT
--     CURRENT_TRANSACTION()
-- ;
CREATE OR REPLACE TABLE szd_production.etl.rvm_hist_a_${land};
ALTER TABLE szd_production.etl.rvm_hist_a_${land} drop column rvm_sid;
CREATE OR REPLACE TABLE szd_production.etl.rvm_hist_b_${land};

/*
copy into SZD_PRODUCTION.ETL.rvm_hist_a_${LAND} 
            (DWH_VALID_FROM_DT
            ,DWH_VALID_TO_DT
            ,DWH_VALID_FG
            ,MANUFACTURER_SID
            ,MANUFACTURER_NAME
            ,RVM_TYPE_CD
            ,SERIAL_NR
            ,INITIAL_INSTALLATION_DT
            ,STORE_SID
            ,STORE_NR
            ,STORE_NAME
            ,COUNTRY_POL_CD
            ,LOB_CD
            ,LOB_NAME
            ,IN_STORE_SEQ
            ,ENERGY_SAVE_MODE_FG
            ,RVM_SORT_TYPE_CD
            ,RVM_ORIENTATION_CD
            ,RVM_PACK_TYPE_CD
            ,RVM_WINDING_CD
            ,CONF_CRATE_FG
            ,CONF_REFILLABLE_FG
            ,CONF_NON_REFILLABLE_FG
            ,CONF_BACK_SYS_CRATE_FG
            ,CONF_BACK_SYS_TABLE_FG
            ,CONF_LAST_UPDATE_TMSP
            ,RVM_SOFTWARE_VERSION_NR
            ,RVM_SOFTWARE_LAST_UPDATE_DT
            ,SMR_SOFTWARE_VERSION_NR
            ,SMR_SOFTWARE_LAST_UPDATE_DT
            ,DWH_SRC_FILE_NAME
            ,DWH_CREATED_TMSP
            ,DWH_UPDATED_TMSP
            ,SRC_1_TMSP
            ,SRC_2_TMSP
            ,SRC_3_TMSP
            ,RVM_DONATION_START_DT
            ,TIME_ZONE_OFFSET_HOUR_CNT
            ,RVM_ACTIVE_FG)

from
 (select distinct
    to_date(dateadd(microseconds, src.$1:datastore_data:dwh_valid_from_dt, '1970-01-01'))
    ,to_date(dateadd(microseconds, src.$1:datastore_data:dwh_valid_to_dt, '1970-01-01'))
    ,src.$1:datastore_data:dwh_valid_fg
    ,src.$1:datastore_data:manufacturer_sid
    ,src.$1:datastore_data:manufacturer_name
    ,src.$1:datastore_data:rvm_type_cd
    ,src.$1:datastore_data:serial_nr
    ,to_date(dateadd(microseconds, src.$1:datastore_data:initial_installation_dt, '1970-01-01'))
    ,src.$1:datastore_data:store_sid
    ,src.$1:datastore_data:store_nr
    ,src.$1:datastore_data:store_name
    ,src.$1:datastore_data:country_pol_cd
    ,src.$1:datastore_data:lob_cd
    ,src.$1:datastore_data:lob_name
    ,src.$1:datastore_data:in_store_seq
    ,src.$1:datastore_data:energy_save_mode_fg
    ,src.$1:datastore_data:rvm_sort_type_cd
    ,src.$1:datastore_data:rvm_orientation_cd
    ,src.$1:datastore_data:rvm_pack_type_cd
    ,src.$1:datastore_data:rvm_winding_cd
    ,0--src.$1:datastore_data:conf_crate_fg
    ,src.$1:datastore_data:conf_refillable_fg
    ,src.$1:datastore_data:conf_non_refillable_fg
    ,src.$1:datastore_data:conf_back_sys_crate_fg
    ,src.$1:datastore_data:conf_back_sys_table_fg
    ,to_timestamp(dateadd(microseconds, src.$1:datastore_data:conf_last_update_tmsp, '1970-01-01'))
    ,src.$1:datastore_data:rvm_software_version_nr
    ,to_date(dateadd(microseconds, src.$1:datastore_data:rvm_software_last_update_dt, '1970-01-01'))
    ,src.$1:datastore_data:smr_software_version_nr
    ,to_date(dateadd(microseconds, src.$1:datastore_data:smr_software_last_update_dt, '1970-01-01'))
    ,src.$1:datastore_data:dwh_src_file_name
    ,current_timestamp
    ,current_timestamp
    ,current_timestamp
    ,current_timestamp
    ,current_timestamp
    ,to_date(dateadd(microseconds, src.$1:datastore_data:rvm_donation_start_dt, '1970-01-01'))
    ,src.$1:datastore_data:time_zone_offset_hour_cnt
    ,src.$1:datastore_data:rvm_active_fg

FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND}/t_dim_rvm_hist/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_hist.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;
*/


insert into szd_production.etl.rvm_hist_b_${land} (rvm_sid, dwh_valid_from_dt, dwh_valid_to_dt, dwh_valid_fg, manufacturer_sid, manufacturer_name, rvm_type_cd, serial_nr, initial_installation_dt, store_sid, store_nr, store_name, country_pol_cd, lob_cd, lob_name, in_store_seq, energy_save_mode_fg, rvm_sort_type_cd, rvm_orientation_cd, rvm_pack_type_cd, rvm_winding_cd, conf_crate_fg, conf_refillable_fg, conf_non_refillable_fg, conf_back_sys_crate_fg, conf_back_sys_table_fg, conf_last_update_tmsp, rvm_software_version_nr, rvm_software_last_update_dt, smr_software_version_nr, smr_software_last_update_dt, dwh_src_file_name, dwh_created_tmsp, dwh_updated_tmsp, src_1_tmsp, src_2_tmsp, src_3_tmsp, rvm_donation_start_dt, time_zone_offset_hour_cnt, rvm_active_fg)
  select
      rvm.rvm_sid,
      src.dwh_valid_from_dt,
      src.dwh_valid_to_dt,
      src.dwh_valid_fg,
      src.manufacturer_sid,
      src.manufacturer_name,
      src.rvm_type_cd,
      src.serial_nr,
      src.initial_installation_dt,
      src.store_sid,
      src.store_nr,
      src.store_name,
      src.country_pol_cd,
      src.lob_cd,
      src.lob_name,
      src.in_store_seq,
      src.energy_save_mode_fg,
      src.rvm_sort_type_cd,
      src.rvm_orientation_cd,
      src.rvm_pack_type_cd,
      src.rvm_winding_cd,
      src.conf_crate_fg,
      src.conf_refillable_fg,
      src.conf_non_refillable_fg,
      src.conf_back_sys_crate_fg,
      src.conf_back_sys_table_fg,
      src.conf_last_update_tmsp,
      src.rvm_software_version_nr,
      src.rvm_software_last_update_dt,
      src.smr_software_version_nr,
      src.smr_software_last_update_dt,
      src.dwh_src_file_name,
      src.dwh_created_tmsp,
      src.dwh_updated_tmsp,
      src.src_1_tmsp,
      src.src_2_tmsp,
      src.src_3_tmsp,
      src.rvm_donation_start_dt,
      src.time_zone_offset_hour_cnt,
      src.rvm_active_fg
    from
      szd_production.etl.rvm_hist_a_${land} as src
      inner join szd_production.etl.rvm_keys as rvm on src.serial_nr = rvm.rvm_id
       and src.store_nr = rvm.store
    qualify row_number() over (partition by rvm_sid, dwh_valid_from_dt, dwh_valid_fg, manufacturer_sid, serial_nr, serial_nr, store_nr, country_pol_cd, lob_cd order by if(rvm_software_last_update_dt is null, 0, 1), rvm_software_last_update_dt desc) = 1
;
merge into szd_production.core.t_dim_rvm_hist as tgt using (
  select
      rvm_sid,
      dwh_valid_from_dt,
      dwh_valid_to_dt,
      dwh_valid_fg,
      manufacturer_sid,
      manufacturer_name,
      rvm_type_cd,
      serial_nr,
      initial_installation_dt,
      store_sid,
      store_nr,
      store_name,
      country_pol_cd,
      lob_cd,
      lob_name,
      in_store_seq,
      energy_save_mode_fg,
      rvm_sort_type_cd,
      rvm_orientation_cd,
      rvm_pack_type_cd,
      rvm_winding_cd,
      conf_crate_fg,
      conf_refillable_fg,
      conf_non_refillable_fg,
      conf_back_sys_crate_fg,
      conf_back_sys_table_fg,
      conf_last_update_tmsp,
      rvm_software_version_nr,
      rvm_software_last_update_dt,
      smr_software_version_nr,
      smr_software_last_update_dt,
      dwh_src_file_name,
      dwh_created_tmsp,
      current_timestamp() as _f33,
      src_1_tmsp,
      src_2_tmsp,
      src_3_tmsp,
      rvm_donation_start_dt,
      time_zone_offset_hour_cnt,
      rvm_active_fg
    from
      szd_production.etl.rvm_hist_b_${land}
    where rvm_sid is not null
) as src
on tgt.rvm_sid = src.rvm_sid
 and tgt.manufacturer_sid = src.manufacturer_sid
 and tgt.serial_nr = src.serial_nr
 and tgt.store_nr = src.store_nr
 and tgt.country_pol_cd = src.country_pol_cd
 and tgt.lob_cd = src.lob_cd
   when matched then update set
    dwh_valid_from_dt = src.dwh_valid_from_dt, 
    dwh_valid_to_dt = src.dwh_valid_to_dt, 
    dwh_valid_fg = src.dwh_valid_fg, 
    manufacturer_name = src.manufacturer_name, 
    rvm_type_cd = src.rvm_type_cd, 
    -- ,initial_installation_dt      = src.initial_installation_dt
    store_sid = src.store_sid, 
    store_name = src.store_name, 
    lob_name = src.lob_name, 
    in_store_seq = src.in_store_seq, 
    energy_save_mode_fg = src.energy_save_mode_fg, 
    rvm_sort_type_cd = src.rvm_sort_type_cd, 
    rvm_orientation_cd = src.rvm_orientation_cd, 
    rvm_pack_type_cd = src.rvm_pack_type_cd, 
    rvm_winding_cd = src.rvm_winding_cd, 
    conf_crate_fg = src.conf_crate_fg, 
    conf_refillable_fg = src.conf_refillable_fg, 
    conf_non_refillable_fg = src.conf_non_refillable_fg, 
    conf_back_sys_crate_fg = src.conf_back_sys_crate_fg, 
    conf_back_sys_table_fg = src.conf_back_sys_table_fg, 
    conf_last_update_tmsp = src.conf_last_update_tmsp, 
    rvm_software_version_nr = src.rvm_software_version_nr, 
    rvm_software_last_update_dt = src.rvm_software_last_update_dt, 
    smr_software_version_nr = src.smr_software_version_nr, 
    smr_software_last_update_dt = src.smr_software_last_update_dt, 
    dwh_src_file_name = src.dwh_src_file_name, 
    dwh_updated_tmsp = current_timestamp(), 
    src_1_tmsp = src.src_1_tmsp, 
    src_2_tmsp = src.src_2_tmsp, 
    src_3_tmsp = src.src_3_tmsp, 
    rvm_donation_start_dt = src.rvm_donation_start_dt, 
    time_zone_offset_hour_cnt = src.time_zone_offset_hour_cnt, 
    rvm_active_fg = src.rvm_active_fg
   when not matched by target then
    insert (rvm_sid, dwh_valid_from_dt, dwh_valid_to_dt, dwh_valid_fg, manufacturer_sid, manufacturer_name, rvm_type_cd, serial_nr, initial_installation_dt, store_sid, store_nr, store_name, country_pol_cd, lob_cd, lob_name, in_store_seq, energy_save_mode_fg, rvm_sort_type_cd, rvm_orientation_cd, rvm_pack_type_cd, rvm_winding_cd, conf_crate_fg, conf_refillable_fg, conf_non_refillable_fg, conf_back_sys_crate_fg, conf_back_sys_table_fg, conf_last_update_tmsp, rvm_software_version_nr, rvm_software_last_update_dt, smr_software_version_nr, smr_software_last_update_dt, dwh_src_file_name, dwh_created_tmsp, dwh_updated_tmsp, src_1_tmsp, src_2_tmsp, src_3_tmsp, rvm_donation_start_dt, time_zone_offset_hour_cnt, rvm_active_fg)
    values (src.rvm_sid, src.dwh_valid_from_dt, src.dwh_valid_to_dt, src.dwh_valid_fg, src.manufacturer_sid, src.manufacturer_name, src.rvm_type_cd, src.serial_nr, src.initial_installation_dt, src.store_sid, src.store_nr, src.store_name, src.country_pol_cd, src.lob_cd, src.lob_name, src.in_store_seq, src.energy_save_mode_fg, src.rvm_sort_type_cd, src.rvm_orientation_cd, src.rvm_pack_type_cd, src.rvm_winding_cd, src.conf_crate_fg, src.conf_refillable_fg, src.conf_non_refillable_fg, src.conf_back_sys_crate_fg, src.conf_back_sys_table_fg, src.conf_last_update_tmsp, src.rvm_software_version_nr, src.rvm_software_last_update_dt, src.smr_software_version_nr, src.smr_software_last_update_dt, src.dwh_src_file_name, current_timestamp(), current_timestamp(), src.src_1_tmsp, src.src_2_tmsp, src.src_3_tmsp, src.rvm_donation_start_dt, src.time_zone_offset_hour_cnt, src.rvm_active_fg)
;

COMMIT TRANSACTION;
