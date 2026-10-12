COPY INTO ETL.t_tcache_oso_openinghours______T_1 FROM

(SELECT 
dateadd(microseconds, $1:datastore_extension.extraction_timestamp,'1970-01-01') AS extraction_timestamp
,LEFT(TRIM($1:datastore_extension.update_mode),100000) AS update_mode
,LEFT(TRIM($1:datastore_data.countryCode),100000) AS countrycode
,$1:datastore_data.warehouseOrgaNumber AS warehouseorganumber
,$1:datastore_data.storeOrgaNumber AS storeorganumber
,LEFT(TRIM($1:datastore_data.timeZone),100000) AS timezone
,LEFT(TRIM($1:datastore_data.openingHours),100000) AS openinghours
,current_timestamp AS dwh_created_tmsp
,current_timestamp AS dwh_updated_tmsp
,${LOAD_ID} AS dwh_load_id
,'OSO' AS dwh_node_cd FROM 
'@DATASTORE.${EXTERNAL_STAGE}/')
FILES = replace_with_input_file_names 
FILE_FORMAT = (TYPE = AVRO)
ON_ERROR = ABORT_STATEMENT
FORCE = TRUE;
