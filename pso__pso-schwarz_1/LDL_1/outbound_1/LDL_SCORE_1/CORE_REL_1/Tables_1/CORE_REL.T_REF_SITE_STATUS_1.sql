--==============================================================
-- Table: t_ref_site_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_site_status_1
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_site_status_1 (
site_status_cd STRING(20) NOT NULL OPTIONS(description='The code for the status_1 of the site.'),
site_status_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the site_status_cd written out in group language (German).'),
site_status_descr_de STRING(100)
OPTIONS(description='A textual description for the site_status_cd written out in German.'),
site_status_descr_en STRING(100)
OPTIONS(description='A textual description for the site_status_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (site_status_cd) NOT ENFORCED
) OPTIONS(description='This entity tracks the lifecycle status_1 of a site. E.g. a site can be active or deleted.');