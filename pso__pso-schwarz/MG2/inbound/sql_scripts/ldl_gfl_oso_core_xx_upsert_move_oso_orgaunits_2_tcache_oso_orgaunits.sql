COPY INTO ETL.t_tcache_oso_orgaunits_________T FROM 
(SELECT $1:datastore_data.orgaUnitId
      , $1:datastore_data.parentOrgaUnitId
      , $1:datastore_data.countryCode
      , $1:datastore_data.orgaNumber
      , $1:datastore_data.name
      , $1:datastore_data.type
      , $1:datastore_data.storeId
      , $1:datastore_data.address
      , LEFT(TRIM($1:datastore_data.phone),90) as phone
      , $1:datastore_data.openingDate
      , $1:datastore_data.testOrgaUnit
      , $1:datastore_data.temporaryClosings
      , $1:datastore_data.status
      , $1:datastore_data.timeZone
      , $1:datastore_data.locale
      , $1:datastore_data.employeeId
      , $1:datastore_data.employees
      , $1:datastore_data.taxData
      , $1:datastore_data.region
      , $1:datastore_data.closingDate
      , dateadd(microseconds, $1:datastore_extension.extraction_timestamp,'1970-01-01') AS extraction_timestamp
      , current_timestamp AS dwh_created_tmsp
      , current_timestamp AS dwh_updated_tmsp
      , ${LOAD_ID} AS dwh_load_id
      , 'OSO' AS dwh_node_cd 
FROM '@DATASTORE.${EXTERNAL_STAGE}/')
FILES = replace_with_input_file_names 
FILE_FORMAT = (TYPE = AVRO)
ON_ERROR = ABORT_STATEMENT
FORCE = TRUE;
