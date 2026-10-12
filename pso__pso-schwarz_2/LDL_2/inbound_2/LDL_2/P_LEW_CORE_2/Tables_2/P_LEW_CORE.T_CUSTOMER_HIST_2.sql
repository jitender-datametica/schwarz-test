/* --------------------------------------------------------------------------------
   DDL for table: t_customer_hist_2
   generated from Powerdesigner on Dienstag, 2. April 2024 17:11:29
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   customer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key CUSTOMER',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Customer is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.',
   lplus_geo_area_sid                  NUMBER(38,0)     COMMENT 'unique identifier of the geographical area (surrogate key) the customer currently uses',
   lplus_geo_area_cd                   VARCHAR(5)       COMMENT 'code of the geographical area the customer currently uses',
   gender_cd                           VARCHAR(5)       COMMENT 'The code for the gender of the customer. Contains only informamtion for the valid record (deleted_fg = 0). All others are set to Null.',
   age_range_cd                        VARCHAR(100)     COMMENT 'Customers are organized in different groups of age ranges. This is the code for the age range the customer is assigned to. Contains only informamtion for the valid record (deleted_fg = 0). All others are set to Null.',
   household_type_id                   NUMBER(38,0)     COMMENT 'ID of the household type in which the customer lives. Contains only informamtion for the valid record (deleted_fg = 0). All others are set to Null.',
   household_type_forecasted_fg        NUMBER(38,0)     COMMENT 'Flag that indicates if the data used to compute the household type is real or forecasted. Flag = 1 (True) if the household type is forecasted. Contains only informamtion for the valid record (deleted_fg = 0). All others are set to Null.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CUSTOMER_HIST PRIMARY KEY (customer_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. A person that purchases goods (or services) from Lidl. 
             Typically, customers are not known in person, except when they identify themselves by using a loyalty card (e.g. LidlPlus) or purchasing online.';
