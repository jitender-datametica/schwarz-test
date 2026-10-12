/* --------------------------------------------------------------------------------
   DDL for table: T_CLIENT_1
   generated from Powerdesigner on Montag, 20. Januar 2025 08:40:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_client_1 (
party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the company.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
client_name STRING(100) NOT NULL OPTIONS(description='Descriptive attribute - Name of the recipient'),
street_address_location_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the location.'),
client_nr STRING(250) NOT NULL
OPTIONS(description='Natural/Business Key - The identifying number of the internal organization'),
additional_name_1_txt STRING(1000)
OPTIONS(description='Descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like\'GmbH\',\'Limited\', Co. KG\' or others but could also be just a part of a companies name'),
additional_name_2_txt STRING(1000)
OPTIONS(description='Descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like\'GmbH\',\'Limited\', Co. KG\' or others but could also be just a part of a companies name'),
international_location_1_nr BIGNUMERIC(38,0)
OPTIONS(description='Natural/Business Key - First part of the international location_1 number.'),
international_location_2_nr BIGNUMERIC(38,0)
OPTIONS(description='Natural/Business Key - Second part of the international location_1 number.'),
international_location_checksum_nr BIGNUMERIC(38,0)
OPTIONS(description='Natural/Business Key - Checksum for the international location_1 numbers.'),
sort_txt STRING(1000) OPTIONS(description='Descriptive attribute - A simple short text used for sorting'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (party_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - A client is the party that ordered goods from an external company like a supplier. - Source - LExIS');