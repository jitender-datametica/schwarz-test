CREATE OR REPLACE PROCEDURE ETL_PROCESS.P_BQ_INTEGRATION()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS 
$$  
//
// SQL Commands
// add if necessary


var_command1        = `copy into ETL_PROCESS.t_bq_data (src, file_name)
                        from
                        ( select $1, metadata$filename
                            from @datastore.STG_DLSSDSPRLDLL201_GOOGLE_ANALYTICS/bigquery/
                        (file_format => datastore.avro_format, pattern => '.*[.]avro')   
                        )
                        ;`

var_command_delete2        = `delete from ETL_PROCESS.t_fact_bq_sessions where src_file_name in (###file_names###);`
var_command2        = `insert into ETL_PROCESS.t_fact_bq_sessions   (propertyId ,fullVisitorId  , visitId  , visitNumber  , channelGrouping  , clientId  , date  , device_browser  , city  , cityID, country_cd  , country, web_app_type_name, ga_src_name, utm_source_name, utm_medium_name  , src_file_name  , dwh_insert_ts )
                        select REGEXP_SUBSTR(file_name, 'sessions_([0-9]+)_([0-9]+)\-000', 1,1, 'e', 2)::int as propertyId
                                , nullif(src:fullVisitorId::string, 'null')::int as fullVisitorId
                                , nullif(src:visitId::STRING, 'null')::int as visitId
                                , nullif(src:visitNumber::STRING, 'null')::int as visitNumber
                                , nullif(src:channelGrouping::string, 'null') as channelGrouping
                                , nullif(src:clientId::string, 'null') as clientId
                                , to_date(nullif(src:date::string, 'null'), 'YYYYMMDD') as date
                                , nullif(src:device:browser::string, 'null') as device_browser
                                , nullif(src:geoNetwork:city::string, '(not set)') as city
                                , nullif(src:geoNetwork:cityId::string, '(not set)')::int as cityID
                                , UPPER(REGEXP_SUBSTR(file_name, \$\$\\d{20}_([a-z]*)_([a-z]*)_\$\$, 1,1, 'e')) as COUNTRY_CD
                                , nullif(src:geoNetwork:country::string, '(not set)') as country
                                , nullif(src:device.deviceCategory::string, '(not set)') as web_app_type_name
                                , REGEXP_SUBSTR(file_name, \$\$\\d{20}_([a-z]*)_([a-z]*)_\$\$, 1,1, 'e', 2) as GA_SRC_NAME
                                , nullif(src:trafficSource:source::string, 'null') as utm_source_name
                                , nullif(src:trafficSource:medium::string, 'null') as utm_medium_name    
                                , file_name as src_file_name
                                , current_timestamp() as dwh_insert_ts
                        from ETL_PROCESS.t_bq_data
                        where file_name in (###file_names###);`

var_command_delete3       = `delete from ETL_PROCESS.t_fact_custom_dimensions where src_file_name in (###file_names###);`
var_command3 = `insert into ETL_PROCESS.t_fact_custom_dimensions  (propertyId ,fullVisitorId , index ,value , src_file_name , dwh_insert_ts)
                        select REGEXP_SUBSTR(file_name, 'sessions_([0-9]+)_([0-9]+)\-000', 1,1, 'e', 2)::int as propertyId
                                , nullif(src:fullVisitorId::string, 'null')::int as fullVisitorId
                                ,  nullif(value:index::string, 'null')::int as index
                                , nullif(value:value::string, 'null') as value
                                , file_name as src_file_name
                                , current_timestamp() as dwh_insert_ts
                        from ETL_PROCESS.t_bq_data
                        , lateral flatten (input => src:customDimensions)
                        where file_name in (###file_names###);`

var_command_delete4      = `delete from ETL_PROCESS.t_fact_hits where src_file_name in (###file_names###);`
var_command4 = `insert into ETL_PROCESS.t_fact_hits (propertyId ,fullVisitorId , hitNumber, custdimIndex , custdimValue , pagePath , pageTitle , src_file_name , dwh_insert_ts)
                    select REGEXP_SUBSTR(file_name, 'sessions_([0-9]+)_([0-9]+)\-000', 1,1, 'e', 2)::int as propertyId
                                , nullif(src:fullVisitorId::string, 'null')::int as fullVisitorId
                                , nullif(h.value:hitNumber::string, 'null')::int as hitNumber
                                , nullif(custDim.value:index::string, 'null') as custdimIndex
                                , nullif(custDim.value:value::string, '') as custdimValue
                                , nullif(h.value:page:pagePath::string, 'null') as pagePath
                                , nullif(h.value:page:pageTitle::string, 'null') as pageTitle
                                , file_name as src_file_name
                                , current_timestamp() as dwh_insert_ts
                    from ETL_PROCESS.t_bq_data
                    ,  lateral flatten (input => src:hits) as h
                    , lateral flatten (input => value:customDimensions) custDim
                    where file_name in (###file_names###);`

var_command_delete5     = `delete from ETL_PROCESS.t_fact_totals where src_file_name in (###file_names###);`
var_command5 = `insert into ETL_PROCESS.t_fact_totals  (propertyId ,fullVisitorId , visitId, date, bounces , pageviews , transactions , transaction_revenue, src_file_name , dwh_insert_ts)
                        select REGEXP_SUBSTR(file_name, 'sessions_([0-9]+)_([0-9]+)\-000', 1,1, 'e', 2)::int as propertyId
                                    , nullif(src:fullVisitorId::string, 'null')::int as fullVisitorId
                                    , nullif(src:visitId::STRING, 'null')::int as visitId
                                     , to_date(nullif(src:date::string, 'null'), 'YYYYMMDD') as date
                                    , nullif(src:totals:bounces::string, 'null')::int as bounces
                                    , nullif(src:totals:pageviews::string, 'null')::int as pageviews
                                    , nullif(src:totals:transactions::string, 'null')::int as transactions
                                , nullif(src:totals:totalTransactionRevenue::string, 'null')::decimal(38,10) as transaction_revenue
                                , file_name as src_file_name
                                , current_timestamp() as dwh_insert_ts
                        from ETL_PROCESS.t_bq_data
                        where file_name in (###file_names###);`

var_command_delete6     = `delete from CORE.T_AGG_GOOGLE_ANALYTICS_DAILY_SUMMARY where DWH_SRC_FILE_NAME in (###file_names###);`
var_command6 = `insert into CORE.T_AGG_GOOGLE_ANALYTICS_DAILY_SUMMARY (CAL_DT, COUNTRY_CD, WEB_APP_TYPE_NAME, GA_SRC_NAME, UTM_SOURCE_NAME, UTM_MEDIUM_NAME, VISIT_ALL_CNT, TRANSACTION_CNT, REVENUE_GROSS_EUR_VAL, DWH_CREATED_TMSP, DWH_UPDATED_TMSP, DWH_SRC_FILE_NAME, SRC_FILE_TMSP)        
                with cte as 
                (
                select ses.propertyid
                        , ses.fullVisitorId
                        , ses.visitId
                        , ses.date as cal_dt
                        , ses.country_cd
                        , ses.GA_SRC_NAME
                        , ses.web_app_type_name
                        , substring(ses.utm_source_name, 0, 99) as utm_source_name
                        , substring(ses.utm_medium_name, 0, 99) as utm_medium_name
                        , tot.transactions
                        , tot.transaction_revenue
                        , ses.src_file_name
                        , ses.dwh_insert_ts
                from ETL_PROCESS.t_fact_bq_sessions ses
                left join ETL_PROCESS.t_fact_totals tot
                on   ses.propertyid = tot.propertyid
                and  ses.fullVisitorId = tot.fullVisitorId
                and  ses.visitId = tot.visitId
                and  ses.date = tot.date 
                and  ses.SRC_FILE_NAME = tot.SRC_FILE_NAME
                where ses.src_file_name in (###file_names###)
                )
                select cal_dt
                        , COUNTRY_CD
                        , WEB_APP_TYPE_NAME
                        , GA_SRC_NAME
                        , UTM_SOURCE_NAME
                        , UTM_MEDIUM_NAME
                        , count(distinct concat(fullvisitorid, visitid)) as VISIT_ALL_CNT
                        , sum(ifnull(transactions, 0)) TRANSACTION_CNT
                        , sum(ifnull(transaction_revenue, 0)) REVENUE_NET_EUR_VAL
                        , current_timestamp() as DWH_CREATED_TMSP
                        , current_timestamp() as DWH_UPDATED_TMSP
                        , src_file_name as DWH_SRC_FILE_NAME
                        , dwh_insert_ts::timestamp_ltz as SRC_FILE_TMSP
                from cte
                group by cal_dt
                        , COUNTRY_CD
                        , WEB_APP_TYPE_NAME
                        , GA_SRC_NAME
                        , UTM_SOURCE_NAME
                        , UTM_MEDIUM_NAME
                        , src_file_name
                        , dwh_insert_ts
                        ;`

// *************************************************************************
//
// START Code Execution


    
try{
   command = var_command1
   res = snowflake.execute({ sqlText : command});
   file_names = `'`
   while (res.next()) {

       if(res.getColumnValue(1) == 'Copy executed with 0 files processed.'){
           return_value = 'Copy executed with 0 files processed'
           
           return return_value     
       }

       else{
            var file_name = res.getColumnValue(1)
            file_name = file_name.replace(`azure://dlssdsprldll201dev.blob.core.windows.net/google-analytics/`, '').replace(`azure://dlssdsprldll201qs.blob.core.windows.net/google-analytics/`, '').replace(`azure://dlssdsprldll201prod.blob.core.windows.net/google-analytics/`, '')
            file_names += file_name + `', '`
       }
       
       }
    
    file_names = file_names.slice(0, -3)

    command = var_command_delete2.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});
    command = var_command2.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});

    command = var_command_delete3.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});
    command = var_command3.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});

    command = var_command_delete4.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});
    command = var_command4.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});

    command = var_command_delete5.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});
    command = var_command5.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});

    command = var_command_delete6.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});
    command = var_command6.replace('###file_names###', file_names)
    snowflake.execute({ sqlText : command});


    return_value = 'Success' 
}
catch(err){
    throw err
}       
         
return return_value      


$$
;