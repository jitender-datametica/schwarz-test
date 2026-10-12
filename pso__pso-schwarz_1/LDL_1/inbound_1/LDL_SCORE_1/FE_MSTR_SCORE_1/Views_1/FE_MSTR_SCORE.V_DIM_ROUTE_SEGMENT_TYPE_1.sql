/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_route_segment_type_1
Description		| Route segment type
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_ROUTE_SEGMENT_TYPE_1(
	ROUTE_SEGMENT_TYPE_CD COMMENT 'The code of a route segment type. Kombitour = Kombi etc. ',
	ROUTE_SEGMENT_TYPE_DESCR COMMENT 'Values: KOMBI - Combination Route Segment, STRECKE - Route Segment, STRECKE_AO - Departure  Point Route Segment, UNBEKANNT - Unknown'
) COMMENT='Route segment type'
 AS 
SELECT
   route_segment_type_cd
  ,route_segment_type_descr
FROM CORE.T_DIM_ROUTE_SEGMENT_TYPE_1;