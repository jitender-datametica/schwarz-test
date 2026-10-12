--==============================================================
-- Table: t_route_segment_site_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_route_segment_site_1
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_ROUTE_SEGMENT_SITE_1 (
   site_sid                            NUMBER           NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   route_segment_sid                   NUMBER           NOT NULL COMMENT 'The unique identifier of an transport route segment. Transportwegabschnitt',
   route_segment_site_role_cd          VARCHAR(20)      NOT NULL COMMENT 'Code for the roles a site can play in the route segment to site relationship - departure site-abgansort  or  destinationsite - empfangsort (tbc codes / descriptions from business)',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN          NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_ROUTE_SEGMENT_SITE PRIMARY KEY (site_sid, route_segment_sid, dwh_valid_from_tmsp, route_segment_site_role_cd) NOT ENFORCED 
)  COMMENT = 'Associative table resolving the many to many relationship between route segment and site.';

