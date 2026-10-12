CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_site_opening_status (
cal_dt DATE NOT NULL
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
site_open_status_type_cd STRING(20) NOT NULL
OPTIONS(description='Code for the opening status of the site (crossdock). '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (cal_dt, site_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Contains the opening date information of the sites (crossdocks).             There is one record for each site and each day defining whether the site is open. ');