CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_org_unit_1 (
org_unit_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the organization unit.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
parent_org_unit_sid BIGNUMERIC
OPTIONS(description='unique identifier (surrogate key) of the organization unit_1 that is parent for the organization unit_1'),
org_unit_type_cd STRING(20)
OPTIONS(description='The code for the type of the organization unit_1 (e.g. regional or country_1 subsidiary).'),
org_unit_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the organization unit_1 for the business.'),
org_unit_name STRING(100) NOT NULL OPTIONS(description='The name by which the organization unit_1 is known.'),
org_unit_short_name STRING(100) OPTIONS(description='Short name for thjois organisation unit_1'),
org_unit_status_cd STRING(20)
OPTIONS(description='The code for the status_1 of the unit_1 org (column  will likely be deleted and table doesn\'t exist on SF)'),
is_onlineshop_fg BOOL OPTIONS(description='Is this an online shop?'),
is_internal_contract_partner_fg BOOL
OPTIONS(description='Is organizations acting as contractual partners for logistics agreements ?'),
vat_nr STRING(20) OPTIONS(description='The vat number (Umsatzsteuer ID).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (org_unit_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='This entity contains all (internal) organization units like country_1 or regional subsidiaries.');