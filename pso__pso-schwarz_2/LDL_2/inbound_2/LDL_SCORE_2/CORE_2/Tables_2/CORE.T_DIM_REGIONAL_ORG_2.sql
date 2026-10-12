--==============================================================
-- Table: t_dim_regional_org_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_regional_org_2
   generated from Powerdesigner on Donnerstag, 8. August 2024 10:54:05
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_REGIONAL_ORG_2 (
   regional_org_sid                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the regional organization.',
   regional_org_nr                     VARCHAR(20)     COMMENT 'A numeric or alphanumeric value which identifies the region_2 for the business.',
   regional_org_name                   VARCHAR(100)    COMMENT 'The name of the regional organization. Regional organization are subordinate to the national organization (Landesgesellschaft)',
   regional_org_short_name             VARCHAR(100)    COMMENT 'The short name of the regional organization. ',
   national_org_sid                    NUMBER          COMMENT 'Surrogate key for the national organization. One national organization contains many regional organization. ',
   national_org_nr                     VARCHAR(20)     COMMENT 'A numeric or alphanumeric value which identifies the nation for the business.',
   national_org_name                   VARCHAR(100)    COMMENT 'A national organization manages many regional organizations. The complete name is listed here. ',
   is_onlineshop_fg                    BOOLEAN         COMMENT 'Indicator for a online shop ',
   vat_nr                              VARCHAR(20)     COMMENT 'The vat number (Umsatzsteuer ID). ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_REGIONAL_ORG PRIMARY KEY (regional_org_sid) NOT ENFORCED 
)  COMMENT = 'This table lists all the corresponding regional destribution centers (Betriebsgesellschaft). The regional distribution center is responsible for deliveries to a group of stores.';

