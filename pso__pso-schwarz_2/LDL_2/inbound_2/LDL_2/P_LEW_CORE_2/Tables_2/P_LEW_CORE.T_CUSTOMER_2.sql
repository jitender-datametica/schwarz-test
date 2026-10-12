/* --------------------------------------------------------------------------------
   DDL for table: t_customer_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   customer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the customer (surrogate key)',
   src_customerid                      VARCHAR(100)     COMMENT 'hashed customer id from LidlPlus source system (SCRM)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CUSTOMER PRIMARY KEY (customer_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. A person that purchases goods (or services) from Lidl. 
             Typically, customers are not known in person, except when they identify themselves by using a loyalty card (e.g. LidlPlus) or purchasing online.';

