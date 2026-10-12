--==============================================================
-- Table: t_ref_company_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_company_status_1
   generated from Powerdesigner on Donnerstag, 16. November 2023 09:34:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_company_status_1 (
company_status_cd STRING(20) NOT NULL
OPTIONS(description='The code for the status_1 of the company. (column  will likely be deleted and table doesn\'t exist on SF)'),
company_status_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the company_status_cd written out in group language (column  will likely be deleted and table doesn\'t exist on SF)'),
company_status_descr_de STRING(100)
OPTIONS(description='A textual description for the company_status_cd written out in German. (column  will likely be deleted and table doesn\'t exist on SF)'),
company_status_descr_en STRING(100)
OPTIONS(description='A textual description for the company_status_cd written out in English. (column  will likely be deleted and table doesn\'t exist on SF)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (company_status_cd) NOT ENFORCED
) OPTIONS(description='The current status_1 of a company');