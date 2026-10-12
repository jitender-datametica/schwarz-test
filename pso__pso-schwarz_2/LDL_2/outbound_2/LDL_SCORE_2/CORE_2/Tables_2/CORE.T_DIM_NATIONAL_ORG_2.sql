--==============================================================
-- Table: t_dim_national_org_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_national_org_2
   generated from Powerdesigner on Dienstag, 13. August 2024 09:23:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_national_org_2 (
national_org_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the national organization (Landesgesellschaft).'),
national_org_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the nation for the business.'),
national_org_name STRING(100)
OPTIONS(description='A national organization manages many regional organizations. The complete name is listed here. '),
national_org_short_name STRING(100) OPTIONS(description='The short name of the national organization.'),
is_onlineshop_fg BOOL OPTIONS(description='Indicator for a online shop '),
vat_nr STRING(20) OPTIONS(description='The vat number (Umsatzsteuer ID). '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (national_org_sid) NOT ENFORCED
)
OPTIONS(description='The Lidl Stiftung & Co. KG (Lidl International) and the national companies. Lidl International bundles competencies in the areas of sales_2, procurement, IT, logistics, administration, purchasing, construction and real estate at the Neckarsulm site and supports the national companies with the further development of Europe-wide procedures and the optimization of processes and standards. The regional distribution center (Betriebsgesellschaft) with their Lidl stores are subordinate to the national organization (Landesgesellschaft). In Germany, for example, around 3,300 Lidl stores are managed by 37 regional distribution centers that operate under the common brand_2 of Lidl Dienstleistung GmbH & Co. KG (Lidl Germany).');