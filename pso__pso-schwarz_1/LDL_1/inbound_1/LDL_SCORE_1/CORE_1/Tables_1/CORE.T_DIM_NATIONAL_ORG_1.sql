--==============================================================
-- Table: t_dim_national_org_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_national_org_1
   generated from Powerdesigner on Dienstag, 13. August 2024 09:23:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NATIONAL_ORG_1 (
   national_org_sid                    NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the national organization (Landesgesellschaft).',
   national_org_nr                     VARCHAR(20)     COMMENT 'A numeric or alphanumeric value which identifies the nation for the business.',
   national_org_name                   VARCHAR(100)    COMMENT 'A national organization manages many regional organizations. The complete name is listed here. ',
   national_org_short_name             VARCHAR(100)    COMMENT 'The short name of the national organization.',
   is_onlineshop_fg                    BOOLEAN         COMMENT 'Indicator for a online shop ',
   vat_nr                              VARCHAR(20)     COMMENT 'The vat number (Umsatzsteuer ID). ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_NATIONAL_ORG PRIMARY KEY (national_org_sid) NOT ENFORCED 
)  COMMENT = 'The Lidl Stiftung & Co. KG (Lidl International) and the national companies. Lidl International bundles competencies in the areas of sales_1, procurement, IT, logistics, administration, purchasing, construction and real estate at the Neckarsulm site and supports the national companies with the further development of Europe-wide procedures and the optimization of processes and standards. The regional distribution center (Betriebsgesellschaft) with their Lidl stores are subordinate to the national organization (Landesgesellschaft). In Germany, for example, around 3,300 Lidl stores are managed by 37 regional distribution centers that operate under the common brand_1 of Lidl Dienstleistung GmbH & Co. KG (Lidl Germany).';
