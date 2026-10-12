CREATE TABLE CORE.t_dim_customer_organisation_type (
   cust_org_type_cd                    VARCHAR(5)      NOT NULL COMMENT 'The code for the customer organisation type (IND or ORG)',
   cust_org_type_descr                 VARCHAR(250)    NOT NULL COMMENT 'A textual description for the customer organisation  type.',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_customer_organisation_type PRIMARY KEY (cust_org_type_cd)
)COMMENT = 'This minor dimension defines the customer organisation type (IND or ORG)';
