--==============================================================
-- Table: t_route_segment_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_route_segment_1
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_route_segment_1 (
route_segment_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier of an transport route segment. Transportwegabschnitt'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
route_segment_type_cd STRING(20) NOT NULL
OPTIONS(description='The code of a route segment type. Kombitour = Kombi etc. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (route_segment_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A route segment describe the route between a departure site and a destination site. In some special special scenarios they may be multiple destination or departure sites for one route (A route of the Type STRECKE can have one to several departure site but only one receiving site. If there are several receiving site and only one departure site, this is a combination tour_1 (KOMBI).');