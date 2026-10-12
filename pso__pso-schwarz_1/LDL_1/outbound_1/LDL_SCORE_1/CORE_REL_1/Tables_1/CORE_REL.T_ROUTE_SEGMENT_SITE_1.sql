--==============================================================
-- Table: t_route_segment_site_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_route_segment_site_1
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_route_segment_site_1 (
site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
route_segment_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier of an transport route segment. Transportwegabschnitt'),
route_segment_site_role_cd STRING(20) NOT NULL
OPTIONS(description='Code for the roles a site can play in the route segment to site relationship - departure site-abgansort  or  destinationsite - empfangsort (tbc codes / descriptions from business)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (site_sid, route_segment_sid, dwh_valid_from_tmsp, route_segment_site_role_cd) NOT ENFORCED
) OPTIONS(description='Associative table resolving the many to many relationship between route segment and site.');