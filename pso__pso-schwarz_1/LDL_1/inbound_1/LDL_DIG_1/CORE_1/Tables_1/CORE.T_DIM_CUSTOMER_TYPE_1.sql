CREATE TABLE CORE.t_dim_customer_type_1 (
   cust_type_cd                        VARCHAR(5)      NOT NULL COMMENT 'The code for the customer type. Possible values: OS (=OnlineShop) & TR (=Travel). ',
   cust_type_descr                     VARCHAR(250)    NOT NULL COMMENT 'A textual description for the customer  type.',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_customer_type PRIMARY KEY (cust_type_cd)
   )COMMENT = 'The differentiator from which business area the customer comes from. Possible values: OS (=OnlineShop) & TR (=Travel). Equivalent to the addr_type_cd within the table t_dim_address_1';
