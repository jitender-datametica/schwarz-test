--==============================================================
-- Table: t_route_segment_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_route_segment_2
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_ROUTE_SEGMENT_2 (
   route_segment_sid                   NUMBER           NOT NULL COMMENT 'The unique identifier of an transport route segment. Transportwegabschnitt',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN          NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   route_segment_type_cd               VARCHAR(20)      NOT NULL COMMENT 'The code of a route segment type. Kombitour = Kombi etc. ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_ROUTE_SEGMENT PRIMARY KEY (route_segment_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'A route segment describe the route between a departure site and a destination site. In some special special scenarios they may be multiple destination or departure sites for one route (A route of the Type STRECKE can have one to several departure site but only one receiving site. If there are several receiving site and only one departure site, this is a combination tour_2 (KOMBI).';

