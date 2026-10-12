/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_route_segment_type
Description		| Route segment type
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_route_segment_type (route_segment_type_cd
OPTIONS(description='The code of a route segment type. Kombitour = Kombi etc. '), route_segment_type_descr
OPTIONS(description='Values: KOMBI - Combination Route Segment, STRECKE - Route Segment, STRECKE_AO - Departure  Point Route Segment, UNBEKANNT - Unknown'))
OPTIONS(DESCRIPTION = `ROUTE SEGMENT TYPE`) AS SELECT route_segment_type_cd,
 route_segment_type_descr
FROM ldl_score_core.t_dim_route_segment_type;