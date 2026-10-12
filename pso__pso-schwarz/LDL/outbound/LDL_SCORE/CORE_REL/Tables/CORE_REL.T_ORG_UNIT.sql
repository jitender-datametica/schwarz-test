--==============================================================
-- Table: t_org_unit
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_org_unit
   generated from Powerdesigner on Montag, 12. August 2024 14:36:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_org_unit (
org_unit_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the organization unit.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
parent_org_unit_sid BIGNUMERIC
OPTIONS(description='unique identifier (surrogate key) of the organization unit that is parent for the organization unit'),
org_unit_type_cd STRING(20)
OPTIONS(description='The code for the type of the organization unit (e.g. regional or country subsidiary).'),
org_unit_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the organization unit for the business.'),
org_unit_name STRING(100) NOT NULL OPTIONS(description='The name by which the organization unit is known.'),
org_unit_short_name STRING(100) OPTIONS(description='Short name for thjois organisation unit'),
org_unit_status_cd STRING(20)
OPTIONS(description='The code for the status of the unit org (column  will likely be deleted and table doesn\'t exist on SF)'),
is_onlineshop_fg BOOL OPTIONS(description='Is this an online shop?'),
is_internal_contract_partner_fg BOOL
OPTIONS(description='Is organizations acting as contractual partners for logistics agreements ?'),
vat_nr STRING(20) OPTIONS(description='The vat number (Umsatzsteuer ID).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (org_unit_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This entity contains all (internal) organization units like country or regional subsidiaries.');