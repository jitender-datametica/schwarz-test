CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_party_type_2 (
party_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of party e.g. company, organization, person etc.'),
party_type_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the party_type_cd written out in group language (German).'),
party_type_descr_de STRING(100) OPTIONS(description='A textual description for the party_type_cd written outin German.'),
party_type_descr_en STRING(100)
OPTIONS(description='A textual description for the party_type_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (party_type_cd) NOT ENFORCED
)
OPTIONS(description='Describes whether a party is a company (Unternehmen), organization unit_2 (Organisationseinheit) or a person. Those types refere to the party. ');