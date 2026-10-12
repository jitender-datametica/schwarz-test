CREATE TABLE P_LEW_PRECORE.T_CACHE_CUST_SESSION_1  (
   customer_sid                        NUMBER(38,0) NOT NULL,
   src_customerid                      VARCHAR(250) NOT NULL,
   src_app_session_id                  NUMBER(38,0), 
   subsession_id_index                 NUMBER(38,0) NOT NULL,
   date_key                            DATE,
   app_version_os_nr                   VARCHAR(100),
   app_version_nr                      VARCHAR(100),
   country_1                             VARCHAR(5) ,
   subsession_start_date_time          TIMESTAMP_NTZ(9) NOT NULL,
   subsession_end_date_time            TIMESTAMP_NTZ(9) NOT NULL,
   metric_value                        NUMBER(38,0)  NOT NULL,
   extraction_dt                       DATE,
   dwh_load_id                         NUMBER(38,0)  NOT NULL ,
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL,
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL 
   
)  ;


