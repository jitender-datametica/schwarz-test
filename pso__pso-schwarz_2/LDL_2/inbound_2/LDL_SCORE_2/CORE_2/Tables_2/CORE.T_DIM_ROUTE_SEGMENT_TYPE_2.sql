--==============================================================
-- Table: t_dim_route_segment_type_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_route_segment_type_2
   generated from Powerdesigner on Dienstag, 16. Juli 2024 13:46:34
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_ROUTE_SEGMENT_TYPE_2 (
   route_segment_type_cd               VARCHAR(20)     NOT NULL COMMENT 'The code of a route segment type. Kombitour = Kombi etc. ',
   route_segment_type_descr            VARCHAR(100)    COMMENT 'Values: KOMBI - Combination Route Segment, STRECKE - Route Segment, STRECKE_AO - Departure  Point Route Segment, UNBEKANNT - Unknown',
   route_segment_type_descr_de         VARCHAR(100)    COMMENT 'German description of: KOMBI - Combination Route Segment, STRECKE - Route Segment, STRECKE_AO - Departure  Point Route Segment, UNBEKANNT - Unknown',
   route_segment_type_descr_en         VARCHAR(100)    COMMENT 'English description of: KOMBI - Combination Route Segment,STRECKE - Route Segment,STRECKE_AO - Departure  Point Route Segment,UNBEKANNT - Unknown',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_ROUTE_SEGMENT_TYPE PRIMARY KEY (route_segment_type_cd) NOT ENFORCED 
)  COMMENT = 'Route segment tyupe can be of values:KOMBI - Combination Route Segment - Loading and unloading in multiple departure sites,STRECKE - Route Segment with single loading and unloading points but sometimes can involve multiple departure sites (similar to Kombi) or multiple destination sites, UNBEKANNT - Unknown.';
