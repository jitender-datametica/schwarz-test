--==============================================================
-- Table: t_ref_site_type_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_site_type_1
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_site_type_1 (
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
OPTIONS(description='This Entity contains information about type of site. There are 5 possible types of site:             (WH Lager, PROD Produktionsstätte, LOAD Verladestandort, TURNS Drehkreuz, HEAD Firmensitz)');