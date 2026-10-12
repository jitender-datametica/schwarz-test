/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGER_CLASSIFICATION_2
   generated from Powerdesigner on Mittwoch, 9. Juli 2025 09:38:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_charger_classification_2 (
charger_classification_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of the classification of a charger.'),
charger_label_prefix_cd STRING(50) NOT NULL
OPTIONS(description='Business/Natural Key - The first letter of the label a charger can have that define the division.'),
charger_provider_system_cd STRING(50) NOT NULL
OPTIONS(description='Business/Natural Key - The provider system of the charger.'),
charger_power_class_cd STRING(50) NOT NULL
OPTIONS(description='Business/Natural Key - The code defining the ability of the charger to charge different types of vehicles.'),
charger_classification_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - The name of the charger classification.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charger_classification_id) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Provides a classification on chargers based on their provider, division and provided power. - Source - Manual');