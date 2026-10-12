CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_route_segment_type (
route_segment_type_cd STRING(20) NOT NULL
OPTIONS(description='The code of a route segment type. Kombitour = Kombi etc. '),
route_segment_type_descr STRING(100)
OPTIONS(description='Values: KOMBI - Combination Route Segment, STRECKE - Route Segment, STRECKE_AO - Departure  Point Route Segment, UNBEKANNT - Unknown'),
route_segment_type_descr_de STRING(100)
OPTIONS(description='German description of: KOMBI - Combination Route Segment, STRECKE - Route Segment, STRECKE_AO - Departure  Point Route Segment, UNBEKANNT - Unknown'),
route_segment_type_descr_en STRING(100)
OPTIONS(description='English description of: KOMBI - Combination Route Segment,STRECKE - Route Segment,STRECKE_AO - Departure  Point Route Segment,UNBEKANNT - Unknown'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (route_segment_type_cd) NOT ENFORCED
)
OPTIONS(description='Route segment tyupe can be of values:KOMBI - Combination Route Segment - Loading and unloading in multiple departure sites,STRECKE - Route Segment with single loading and unloading points but sometimes can involve multiple departure sites (similar to Kombi) or multiple destination sites, UNBEKANNT - Unknown.');