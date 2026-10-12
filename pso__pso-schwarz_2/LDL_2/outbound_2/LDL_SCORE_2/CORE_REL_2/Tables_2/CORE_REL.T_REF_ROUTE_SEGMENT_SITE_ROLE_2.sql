--==============================================================
-- Table: t_ref_route_segment_site_role_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_route_segment_site_role_2
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_route_segment_site_role_2 (
route_segment_site_role_cd STRING(20) NOT NULL
OPTIONS(description='Code for the roles a site can play in the route segment to site relationship - departure site-abgangsort  or  destination site - empfangsort (\'AO\',\'EO\')'),
route_segment_site_role_descr STRING(100)
OPTIONS(description='Description for the codes indicating the roles a site can play in the route segment to site relationship - AO=departure site-abgansort  or  destinationsite - EO = empfangsort ('),
route_segment_site_role_descr_de STRING(100)
OPTIONS(description='German description for the codes indicating the roles a site can play in the route segment to site relationship - AO=departure site-abgansort  or  destinationsite - EO = empfangsort ('),
route_segment_site_role_descr_en STRING(100)
OPTIONS(description='English description for the codes indicating the roles a site can play in the route segment to site relationship - AO=departure site-abgansort  or  destinationsite - EO = empfangsort ('),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (route_segment_site_role_cd) NOT ENFORCED
) OPTIONS(description='This reference table defines the role of a site (destination site/departure site).');