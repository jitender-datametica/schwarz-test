/* --------------------------------------------------------------------------------
   DDL for table: t_ref_coupon_relation_type
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_COUPON_RELATION_TYPE (
   coupon_relation_type_cd             VARCHAR(5)       NOT NULL COLLATE 'en-ci' COMMENT 'identifier of the relation type, i.e. how something is related to the coupon',
   coupon_relation_type_descr          VARCHAR(100)     COLLATE 'en-ci' COMMENT 'description of the relation type',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_COUPON_RELATION_TYPE PRIMARY KEY (coupon_relation_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. This minor entity describes how anything (e.g. item / store) is related to the coupon, e.g. a store might accept the coupon, or the price of an item is reduced by the coupon, ...';

