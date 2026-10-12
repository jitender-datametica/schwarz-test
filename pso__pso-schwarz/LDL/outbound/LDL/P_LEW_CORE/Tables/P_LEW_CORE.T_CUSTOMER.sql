/* --------------------------------------------------------------------------------
   DDL for table: t_customer
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the customer (surrogate key)'),
src_customerid STRING(100) OPTIONS(description='hashed customer id from LidlPlus source system (SCRM)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (customer_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. A person that purchases goods (or services) from Lidl.              Typically, customers are not known in person, except when they identify themselves by using a loyalty card (e.g. LidlPlus) or purchasing online.');