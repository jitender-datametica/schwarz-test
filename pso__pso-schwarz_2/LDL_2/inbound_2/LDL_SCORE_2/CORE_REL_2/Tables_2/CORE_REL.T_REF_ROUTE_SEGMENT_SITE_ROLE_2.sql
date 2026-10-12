--==============================================================
-- Table: t_ref_route_segment_site_role_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_route_segment_site_role_2
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_ROUTE_SEGMENT_SITE_ROLE_2 (
   route_segment_site_role_cd          VARCHAR(20)      NOT NULL COMMENT 'Code for the roles a site can play in the route segment to site relationship - departure site-abgangsort  or  destination site - empfangsort (''AO'',''EO'')',
   route_segment_site_role_descr       VARCHAR(100)     COMMENT 'Description for the codes indicating the roles a site can play in the route segment to site relationship - AO=departure site-abgansort  or  destinationsite - EO = empfangsort (',
   route_segment_site_role_descr_de    VARCHAR(100)     COMMENT 'German description for the codes indicating the roles a site can play in the route segment to site relationship - AO=departure site-abgansort  or  destinationsite - EO = empfangsort (',
   route_segment_site_role_descr_en    VARCHAR(100)     COMMENT 'English description for the codes indicating the roles a site can play in the route segment to site relationship - AO=departure site-abgansort  or  destinationsite - EO = empfangsort (',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_ROUTE_SEGMENT_SITE_ROLE PRIMARY KEY (route_segment_site_role_cd) NOT ENFORCED 
)  COMMENT = 'This reference table defines the role of a site (destination site/departure site).';

