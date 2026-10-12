/* --------------------------------------------------------------------------------
   DDL for table: T_PRODUCT_INSTANCE_GROUP_KEY
   generated from Powerdesigner on Donnerstag, 30. November 2023 09:39:09
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_PRODUCT_INSTANCE_GROUP_KEY (
   PRODUCT_INSTANCE_GROUP_SID          NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product instance group.',
   PRODUCT_INSTANCE_GROUP_KEY_TYPE_CD  VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the product instance group.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   PRODUCT_INSTANCE_GROUP_NAT_KEY_NR   VARCHAR(250)    NOT NULL COMMENT 'The natural key which identifies the product instance group.In case the natural key consist of several columns, all components get concatenated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_PRODUCT_INSTANCE_GROUP_KEY PRIMARY KEY (PRODUCT_INSTANCE_GROUP_KEY_TYPE_CD, DWH_VALID_FROM_TMSP, PRODUCT_INSTANCE_GROUP_NAT_KEY_NR) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Product Instance Group - Contains the mapping between surrogate keys and natural keys for business objects from the subject area "Product".';

