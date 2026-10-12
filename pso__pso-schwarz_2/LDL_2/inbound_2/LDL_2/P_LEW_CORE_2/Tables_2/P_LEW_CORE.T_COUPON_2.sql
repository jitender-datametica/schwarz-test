/* --------------------------------------------------------------------------------
   DDL for table: t_coupon_2
   generated from Powerdesigner on Mittwoch, 19. Juni 2024 15:57:09
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_COUPON_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   coupon_sid                          NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the Coupon (surrogate key)',
   src_country                         VARCHAR(20)      COLLATE 'en-ci' COMMENT 'part of the identifier of the coupon within LidlPlus/SCRM source system',
   src_id                              VARCHAR(50)      COLLATE 'en-ci' COMMENT 'part of the identifier of the coupon within LidlPlus/SCRM source system',
   coupon_type_cd                      VARCHAR(40)      COLLATE 'en-ci' COMMENT 'unique code identifying the type of the coupon, e.g. GiftProduct, SpecialPrice, BuyXGetAFree etc.',
   coupon_nr                           VARCHAR(50)      COLLATE 'en-ci' COMMENT 'a number that is used to identify a certain coupon',
   coupon_name                         VARCHAR(100)     COLLATE 'en-ci' COMMENT 'the name of the coupon, i.e. giving a hint for what coupon it is (like Gratis Gasanzuender or 10% Parika-Mischung)',
   loyalty_prog_cd                     VARCHAR(5)       COLLATE 'en-ci' COMMENT 'identifier of the loyalty program: LPLUS (LidlPlus)',
   geo_area_sid                        NUMBER(38,0)     COMMENT 'unique identifier of the geographical area (surrogate key)',
   geo_area_cd                         VARCHAR(5)       COLLATE 'en-ci' COMMENT 'code of the geographical area',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_COUPON PRIMARY KEY (coupon_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. A coupon reduces the amount that the customer needs to pay for his/her purchase or gives free products for the purchase.';
