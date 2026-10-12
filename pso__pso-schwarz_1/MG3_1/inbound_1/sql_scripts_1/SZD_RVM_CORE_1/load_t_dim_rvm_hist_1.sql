ALTER SESSION SET TRANSACTION_ABORT_ON_ERROR = TRUE;
BEGIN;
SELECT CURRENT_TRANSACTION();

CREATE OR REPLACE TABLE ETL.rvm_hist_a_$_1{LAND_1} LIKE CORE.t_dim_rvm_hist_1;
ALTER TABLE ETL.rvm_hist_a_$_1{LAND_1} DROP COLUMN RVM_SID;

CREATE OR REPLACE TABLE ETL.rvm_hist_b_$_1{LAND_1} LIKE CORE.t_dim_rvm_hist_1;

copy into ETL.rvm_hist_a_$_1{LAND_1} 
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

FROM '@DATASTORE.${stage}/${SYSTEMGROUP}/${LAND_1}/t_dim_rvm_hist_1/${YEAR}/${MONTH}/${DAY}/' src) 
pattern='.*rvm_hist.*\.(avro)$'
file_format = (type = avro)
ON_ERROR = ABORT_STATEMENT;

INSERT INTO ETL.rvm_hist_b_$_1{LAND_1}
            (RVM_SID
            ,DWH_VALID_FROM_DT
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
SELECT
    rvm.RVM_SID
    ,src.DWH_VALID_FROM_DT
    ,src.DWH_VALID_TO_DT
    ,src.DWH_VALID_FG
    ,src.MANUFACTURER_SID
    ,src.MANUFACTURER_NAME
    ,src.RVM_TYPE_CD
    ,src.SERIAL_NR
    ,src.INITIAL_INSTALLATION_DT
    ,src.STORE_SID
    ,src.STORE_NR
    ,src.STORE_NAME
    ,src.COUNTRY_POL_CD
    ,src.LOB_CD
    ,src.LOB_NAME
    ,src.IN_STORE_SEQ
    ,src.ENERGY_SAVE_MODE_FG
    ,src.RVM_SORT_TYPE_CD
    ,src.RVM_ORIENTATION_CD
    ,src.RVM_PACK_TYPE_CD
    ,src.RVM_WINDING_CD
    ,src.CONF_CRATE_FG
    ,src.CONF_REFILLABLE_FG
    ,src.CONF_NON_REFILLABLE_FG
    ,src.CONF_BACK_SYS_CRATE_FG
    ,src.CONF_BACK_SYS_TABLE_FG
    ,src.CONF_LAST_UPDATE_TMSP
    ,src.RVM_SOFTWARE_VERSION_NR
    ,src.RVM_SOFTWARE_LAST_UPDATE_DT
    ,src.SMR_SOFTWARE_VERSION_NR
    ,src.SMR_SOFTWARE_LAST_UPDATE_DT
    ,src.DWH_SRC_FILE_NAME
    ,src.DWH_CREATED_TMSP
    ,src.DWH_UPDATED_TMSP
    ,src.SRC_1_TMSP
    ,src.SRC_2_TMSP
    ,src.SRC_3_TMSP
    ,src.RVM_DONATION_START_DT
    ,src.TIME_ZONE_OFFSET_HOUR_CNT 
    ,src.RVM_ACTIVE_FG
FROM ETL.rvm_hist_a_$_1{LAND_1} src
  INNER JOIN ETL.rvm_keys_1 rvm
          ON src.SERIAL_NR = rvm.rvm_id     
          and src.STORE_NR = rvm.store
QUALIFY ROW_NUMBER() OVER (PARTITION BY RVM_SID, DWH_VALID_FROM_DT, DWH_VALID_FG, MANUFACTURER_SID, SERIAL_NR, SERIAL_NR,STORE_NR, COUNTRY_POL_CD,LOB_CD ORDER BY  RVM_SOFTWARE_LAST_UPDATE_DT DESC) = 1
        ;  

MERGE INTO CORE.t_dim_rvm_hist_1 AS tgt
        USING (SELECT           RVM_SID
                                ,DWH_VALID_FROM_DT
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
                                ,CURRENT_TIMESTAMP
                                ,SRC_1_TMSP
                                ,SRC_2_TMSP
                                ,SRC_3_TMSP
                                ,RVM_DONATION_START_DT
                                ,TIME_ZONE_OFFSET_HOUR_CNT
                                ,RVM_ACTIVE_FG

FROM  ETL.rvm_hist_b_$_1{LAND_1}  
WHERE RVM_SID IS NOT NULL
              ) AS src 
                ON tgt.RVM_SID = src.RVM_SID
                AND tgt.MANUFACTURER_SID = src.MANUFACTURER_SID
                AND tgt.SERIAL_NR = src.SERIAL_NR
                AND tgt.STORE_NR = src.STORE_NR
                AND tgt.COUNTRY_POL_CD = src.COUNTRY_POL_CD
                AND tgt.LOB_CD = src.LOB_CD

        WHEN MATCHED THEN UPDATE
            SET                     DWH_VALID_FROM_DT               = src.DWH_VALID_FROM_DT             
                                    ,DWH_VALID_TO_DT                 = src.DWH_VALID_TO_DT               
                                    ,DWH_VALID_FG                 = src.DWH_VALID_FG                    
                                    ,MANUFACTURER_NAME        = src.MANUFACTURER_NAME      
                                    ,RVM_TYPE_CD                  = src.RVM_TYPE_CD                            
                                    --,INITIAL_INSTALLATION_DT      = src.INITIAL_INSTALLATION_DT    
                                    ,STORE_SID                    = src.STORE_SID                                  
                                    ,STORE_NAME                   = src.STORE_NAME                                              
                                    ,LOB_NAME                     = src.LOB_NAME                   
                                    ,IN_STORE_SEQ                 = src.IN_STORE_SEQ               
                                    ,ENERGY_SAVE_MODE_FG          = src.ENERGY_SAVE_MODE_FG        
                                    ,RVM_SORT_TYPE_CD             = src.RVM_SORT_TYPE_CD           
                                    ,RVM_ORIENTATION_CD           = src.RVM_ORIENTATION_CD         
                                    ,RVM_PACK_TYPE_CD             = src.RVM_PACK_TYPE_CD           
                                    ,RVM_WINDING_CD               = src.RVM_WINDING_CD             
                                    ,CONF_CRATE_FG                = src.CONF_CRATE_FG              
                                    ,CONF_REFILLABLE_FG           = src.CONF_REFILLABLE_FG         
                                    ,CONF_NON_REFILLABLE_FG       = src.CONF_NON_REFILLABLE_FG     
                                    ,CONF_BACK_SYS_CRATE_FG       = src.CONF_BACK_SYS_CRATE_FG     
                                    ,CONF_BACK_SYS_TABLE_FG       = src.CONF_BACK_SYS_TABLE_FG     
                                    ,CONF_LAST_UPDATE_TMSP        = src.CONF_LAST_UPDATE_TMSP      
                                    ,RVM_SOFTWARE_VERSION_NR      = src.RVM_SOFTWARE_VERSION_NR    
                                    ,RVM_SOFTWARE_LAST_UPDATE_DT  = src.RVM_SOFTWARE_LAST_UPDATE_DT
                                    ,SMR_SOFTWARE_VERSION_NR      = src.SMR_SOFTWARE_VERSION_NR    
                                    ,SMR_SOFTWARE_LAST_UPDATE_DT  = src.SMR_SOFTWARE_LAST_UPDATE_DT
                                    ,DWH_SRC_FILE_NAME            = src.DWH_SRC_FILE_NAME                             
                                    ,DWH_UPDATED_TMSP             = current_timestamp           
                                    ,SRC_1_TMSP                   = src.SRC_1_TMSP                 
                                    ,SRC_2_TMSP                   = src.SRC_2_TMSP                 
                                    ,SRC_3_TMSP                   = src.SRC_3_TMSP                 
                                    ,RVM_DONATION_START_DT        = src.RVM_DONATION_START_DT      
                                    ,TIME_ZONE_OFFSET_HOUR_CNT    = src.TIME_ZONE_OFFSET_HOUR_CNT
                                    ,RVM_ACTIVE_FG                = src.RVM_ACTIVE_FG

        WHEN NOT MATCHED THEN INSERT
               (                RVM_SID
                                ,DWH_VALID_FROM_DT
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
                                ,RVM_ACTIVE_FG
               )
        VALUES (                src.RVM_SID
                                ,src.DWH_VALID_FROM_DT
                                ,src.DWH_VALID_TO_DT
                                ,src.DWH_VALID_FG
                                ,src.MANUFACTURER_SID
                                ,src.MANUFACTURER_NAME
                                ,src.RVM_TYPE_CD
                                ,src.SERIAL_NR
                                ,src.INITIAL_INSTALLATION_DT
                                ,src.STORE_SID
                                ,src.STORE_NR
                                ,src.STORE_NAME
                                ,src.COUNTRY_POL_CD
                                ,src.LOB_CD
                                ,src.LOB_NAME
                                ,src.IN_STORE_SEQ
                                ,src.ENERGY_SAVE_MODE_FG
                                ,src.RVM_SORT_TYPE_CD
                                ,src.RVM_ORIENTATION_CD
                                ,src.RVM_PACK_TYPE_CD
                                ,src.RVM_WINDING_CD
                                ,src.CONF_CRATE_FG
                                ,src.CONF_REFILLABLE_FG
                                ,src.CONF_NON_REFILLABLE_FG
                                ,src.CONF_BACK_SYS_CRATE_FG
                                ,src.CONF_BACK_SYS_TABLE_FG
                                ,src.CONF_LAST_UPDATE_TMSP
                                ,src.RVM_SOFTWARE_VERSION_NR
                                ,src.RVM_SOFTWARE_LAST_UPDATE_DT
                                ,src.SMR_SOFTWARE_VERSION_NR
                                ,src.SMR_SOFTWARE_LAST_UPDATE_DT
                                ,src.DWH_SRC_FILE_NAME
                                ,CURRENT_TIMESTAMP
                                ,CURRENT_TIMESTAMP
                                ,src.SRC_1_TMSP
                                ,src.SRC_2_TMSP
                                ,src.SRC_3_TMSP
                                ,src.RVM_DONATION_START_DT
                                ,src.TIME_ZONE_OFFSET_HOUR_CNT
                                ,src.RVM_ACTIVE_FG);


commit;   
