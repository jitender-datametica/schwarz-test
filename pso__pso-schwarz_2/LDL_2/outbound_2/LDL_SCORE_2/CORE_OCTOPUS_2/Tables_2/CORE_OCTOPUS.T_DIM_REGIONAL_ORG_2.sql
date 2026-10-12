CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_regional_org_2 (
regional_org_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the regional organization.'),
regional_org_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the region_2 for the business.'),
regional_org_name STRING(100)
OPTIONS(description='The name of the regional organization. Regional organization are subordinate to the national organization (Landesgesellschaft)'),
regional_org_short_name STRING(100) OPTIONS(description='The short name of the regional organization. '),
national_org_sid BIGNUMERIC
OPTIONS(description='Surrogate key for the national organization. One national organization contains many regional organization. '),
national_org_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the nation for the business.'),
national_org_name STRING(100)
OPTIONS(description='A national organization manages many regional organizations. The complete name is listed here. '),
is_onlineshop_fg BOOL OPTIONS(description='Indicator for a online shop '),
vat_nr STRING(20) OPTIONS(description='The vat number (Umsatzsteuer ID). '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (regional_org_sid) NOT ENFORCED
)
OPTIONS(description='This table lists all the corresponding regional destribution centers (Betriebsgesellschaft). The regional distribution center is responsible for deliveries to a group of stores.');