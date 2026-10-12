/* --------------------------------------------------------------------------------
   DDL for table: t_ref_storage_test_promotion_type
   generated from Powerdesigner on Dienstag, 19. September 2023 16:51:56
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_STORAGE_TEST_PROMOTION_TYPE (
   storage_test_promo_type_cd          VARCHAR(100)     NOT NULL COMMENT 'A code for promotional clusters used in storage tests (Normal, Promo).',
   storage_test_promo_type_descr       VARCHAR(250)     NOT NULL COMMENT 'A description for promotional clusters used in storage tests.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_REF_STORAGE_TEST_PROMOTION_TYPE PRIMARY KEY (storage_test_promo_type_cd) NOT ENFORCED 
)  COMMENT = 'A reference table that contains definions of promotional clusters used in storage tests (Normal, Promo).
             Source: FTM ( manual static mapping)';
