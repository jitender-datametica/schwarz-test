CREATE TABLE CORE.t_dim_address_type (
   addr_type_cd                        VARCHAR(5)      NOT NULL COMMENT 'The code for the address type. Possible values: OS (=OnlineShop) & TR (=Travel). ',
   addr_type_descr                     VARCHAR(250)    NOT NULL COMMENT 'A textual description for the address type in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_ADDRESS_TYPE PRIMARY KEY(addr_type_cd)
   )COMMENT = 'The differentiator from which business area the address comes from. Possible values: OS (=OnlineShop) & TR (=Travel). Equivalent to the cust_type_cd within the table t_dim_customer';
