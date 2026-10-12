--==============================================================
-- Table: t_dim_org_unit_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_org_unit_status
   generated from Powerdesigner on Donnerstag, 16. November 2023 09:35:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core.t_dim_org_unit_status (
org_unit_status_cd STRING(20) NOT NULL OPTIONS(description='The code for the status of the org unit.'),
org_unit_status_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the org_unit_status_cd written out in group language (German).'),
org_unit_status_descr_de STRING(100)
OPTIONS(description='A textual description for the org_unit_status_cd written out in German.'),
org_unit_status_descr_en STRING(100)
OPTIONS(description='A textual description for the org_unit_status_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (org_unit_status_cd) NOT ENFORCED
) OPTIONS(description='This dimension tracks the lifecycle status of a org unit. E.g. a site can be active or deleted.');