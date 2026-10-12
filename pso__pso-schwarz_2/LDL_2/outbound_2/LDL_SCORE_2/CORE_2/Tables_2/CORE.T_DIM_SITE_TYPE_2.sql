--==============================================================
-- Table: t_dim_site_type_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_site_type_2
   generated from Powerdesigner on Dienstag, 2. April 2024 10:01:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_site_type_2 (
site_type_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of site e.g. TRANS = Warenumschlagplatz..'),
site_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the site_type_cd written out in group language (German).'),
site_type_descr_de STRING(100) OPTIONS(description='A textual description for the site_type_cd written out in German.'),
site_type_descr_en STRING(100) OPTIONS(description='A textual description for the site_type_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (site_type_cd) NOT ENFORCED
)
OPTIONS(description='This Dimension contains information about type of site. There are 5 possible types of site:             (WH Lager, PROD Produktionsstätte, LOAD Verladestandort, TURNS Drehkreuz, HEAD Firmensitz)             ');