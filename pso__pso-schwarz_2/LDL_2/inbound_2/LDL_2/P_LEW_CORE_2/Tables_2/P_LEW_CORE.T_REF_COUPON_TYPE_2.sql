/* --------------------------------------------------------------------------------
   DDL for table: t_ref_coupon_type_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_COUPON_TYPE_2 (
   coupon_type_cd                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'unique code identifying the type of the coupon, e.g. Welcome-Coupon, Goodwill-Coupon, etc.',
   coupon_type_short_descr             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'short description of the coupon type',
   coupon_type_descr                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'detailed description of the coupon type',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_COUPON_TYPE PRIMARY KEY (coupon_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. This minor entity describes the type of the coupon, like Welcome, Weekly, Goodwill, ...';

