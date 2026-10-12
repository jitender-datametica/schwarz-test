CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_individual_logistics_agreement (
individual_logistics_agmt_sid BIGNUMERIC NOT NULL OPTIONS(description='Agreement Identifier'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record becomes valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
individual_logistics_agmt_term_type_cd STRING(20) NOT NULL
OPTIONS(description='The term type of an individual logistic agreement '),
individual_logistics_agmt_type_cd STRING(20)
OPTIONS(description='The unique code for the type of an individual logistic agreement'),
individual_logistics_agmt_status_cd STRING(20) NOT NULL OPTIONS(description='Status of an agreement'),
individual_logistics_agmt_nr STRING(20)
OPTIONS(description='Business Key for a logistic agreement, defines number of the logistic agreement.'),
individual_logistics_agmt_version_nr STRING(20)
OPTIONS(description='Business Key for a logistic agreement, defines version of the logistic agreement.'),
logistics_framework_agmt_sid BIGNUMERIC OPTIONS(description='Agreement unique identifier'),
agmt_released_tmsp TIMESTAMP OPTIONS(description='Agreement released date time'),
agmt_sent_tmsp TIMESTAMP OPTIONS(description='Agreement  sent  date time'),
agmt_checked_tmsp TIMESTAMP OPTIONS(description='Agreement checked date time'),
agmt_printed_tmsp TIMESTAMP OPTIONS(description='Agreement printed date time'),
agmt_changed_tmsp TIMESTAMP OPTIONS(description='Agreement changed date time'),
agmt_created_tmsp TIMESTAMP OPTIONS(description='Agreement created date time'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the company.'),
org_unit_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the organization unit.'),
logistics_agmt_area_cd STRING(20) OPTIONS(description='Agreement logistics area'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (individual_logistics_agmt_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='CDM: Transportwegabschnitt-Vertrag, - designates a subcategory of a logistics contract that can be based on a logistics master agreement.');