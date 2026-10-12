CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_site_capacity (
site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
logistic_temp_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
site_capacity BIGNUMERIC OPTIONS(description='Capacity of a site in the form of storage spaces.'),
site_capacity_reserve BIGNUMERIC OPTIONS(description='Additional capacity of a site in the form of storage spaces.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (site_sid, logistic_temp_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Indicates how much capacity a site still has to store goods. If the capacity is exhausted, you can also access any existing reserves of the site. ');