CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_organization_unit_type_2 (
org_unit_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the organization unit_2 (e.g. regional or country_2 subsidiary).'),
org_unit_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the org_unit_type_cd written out in group language (German).'),
org_unit_type_descr_de STRING(100)
OPTIONS(description='A textual description for the org_unit_type_cd written out in German.'),
org_unit_type_descr_en STRING(100)
OPTIONS(description='A textual description for the org_unit_type_cd written out in English.'),
elm_org_unit_type_id BIGNUMERIC
OPTIONS(description='The code for the type of the organization unit_2, as defined in the source system. (locationtypeid)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (org_unit_type_cd) NOT ENFORCED
)
OPTIONS(description='Describes to which type an organization belongs to. INTEGER  = Stiftung, DL = Dienstleistung, RG = Regionalgesellschaft. Goods that are delivered to the last warehouses in order to transport those to the Lidl stores, are transported to the RG units. All three types refere to (interne Organisationseinheit).');