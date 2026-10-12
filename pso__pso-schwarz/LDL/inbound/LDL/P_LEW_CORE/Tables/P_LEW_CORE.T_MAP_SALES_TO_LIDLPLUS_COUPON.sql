/* --------------------------------------------------------------------------------
   DDL for table: t_map_sales_to_lidlplus_coupon
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAP_SALES_TO_LIDLPLUS_COUPON CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   coupon_sid                          NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the LidlPlus Coupon (surrogate key)',
   ejr_discount_id                     VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'identifier that can be found on the EJR data and that can be used to identify the used coupon',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAP_SALES_TO_LIDLPLUS_COUPON PRIMARY KEY (coupon_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Mapping between coupon and the identifier on EJR data. Identifier can be reused over time, but is only linked to one active coupon, when the sales happen.';

