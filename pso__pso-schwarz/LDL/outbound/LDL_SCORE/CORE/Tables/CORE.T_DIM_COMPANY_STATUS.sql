--==============================================================
-- Table: t_dim_company_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_company_status
   generated from Powerdesigner on Donnerstag, 16. November 2023 09:27:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_company_status (
company_status_cd STRING(20) NOT NULL
OPTIONS(description='The code for the status of the company. (column  will likely be deleted and table doesn\'t exist on SF)'),
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
) OPTIONS(description='The current status of a company');