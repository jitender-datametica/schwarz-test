--==============================================================
-- Table: t_ref_country_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_country_1
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_country_1 (
country_cd STRING(2) NOT NULL OPTIONS(description='The code for the country_1 to which t_site_1 references on. '),
geo_region_cd STRING(20) OPTIONS(description='Surrogate key for the country_1 region_1 of this country_1'),
curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\',…'),
country_descr STRING(100) NOT NULL
OPTIONS(description='Descriptive name of a country_1 e.g. DE- Germany, GB - Great Britain'),
country_descr_de STRING(100) OPTIONS(description='A textual description for country_cd written out in German.'),
country_descr_en STRING(100) OPTIONS(description='A textual description for country_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (country_cd) NOT ENFORCED
) OPTIONS(description='this is the geographical country_1 with an ISO2 2-letter code e.g. Germany - DE, Italy - IT etc.');