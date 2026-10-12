/* --------------------------------------------------------------------------------
   DDL for table: t_customer_to_child_age_range
   generated from Powerdesigner on Dienstag, 2. April 2024 17:23:54
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CUSTOMER_TO_CHILD_AGE_RANGE (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   customer_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key CUSTOMER',
   child_age_range_cd                  VARCHAR(100)     NOT NULL COMMENT 'Code of the age range in which the child is categorized depending on the age.',
   child_age_range_forecasted_fg       NUMBER(38,0)     NOT NULL COMMENT 'Flag that indicates if the data used to compute child age range is real or forecasted. Flag = 1 (True) when child age range is forecasted.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_CUSTOMER_TO_CHILD_AGE_RANGE PRIMARY KEY (customer_sid, child_age_range_cd) NOT ENFORCED 
)  COMMENT = 'If a customer has household_type_id 2 or 3 this table defines the relationship between the customer and the child age ranges. If a customer has one or more children in each of the child age ranges one record will be inserted to show this relationship. A customer can be related to each of the child clusters. Contains only active relations from a customer to a child age range. Past relations get deleted when they are not active anymore.';
