--==============================================================
-- Table: t_ref_site_open_status_type
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_site_open_status_type
   generated from Powerdesigner on Mittwoch, 7. August 2024 16:23:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_site_open_status_type (
site_open_status_type_cd STRING(20) NOT NULL
OPTIONS(description='Code for the opening status of the site (crossdock). '),
site_open_status_type_descr STRING(100) NOT NULL
OPTIONS(description='Description of the site_open_status_type_cd in group language.'),
site_open_status_type_descr_de STRING(100)
OPTIONS(description='A textual description of site_open_status_type_cd (written out) in German.'),
site_open_status_type_descr_en STRING(100)
OPTIONS(description='A textual description of site_open_status_type_cd (written out) in group language English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (site_open_status_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the opening status of the site (crossdock). Such as\'opened\',\'closed\' or\'partly opened\'. ');