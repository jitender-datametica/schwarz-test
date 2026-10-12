/* --------------------------------------------------------------------------------
   DDL for table: t_ref_discount_type_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_DISCOUNT_TYPE_1 (
   discount_type_cd                    VARCHAR(6)       NOT NULL COLLATE 'en-ci' COMMENT 'unique code for the discount type, e.g. x% on product X',
   discount_type_short_descr           VARCHAR(100)     COLLATE 'en-ci' COMMENT 'gives a short description for the discount type',
   discount_type_descr                 VARCHAR(100)     COLLATE 'en-ci' COMMENT 'gives a detailed description of the discount type',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_DISCOUNT_TYPE PRIMARY KEY (discount_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. This minor entity describes the type of the discounts, like x% percentage on product X or x [currency] on total basket case';

