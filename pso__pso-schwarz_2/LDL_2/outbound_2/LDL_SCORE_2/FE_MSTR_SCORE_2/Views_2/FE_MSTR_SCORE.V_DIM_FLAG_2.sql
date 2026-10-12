/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_flag_2
Description		| List of transport prices
Created on    |	06.12.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_flag_2 (fg OPTIONS(description='The flag (true or false)'), fg_name
OPTIONS(description='The name for the flag (yes / no) in group language, i.e. German.'), fg_name_de
OPTIONS(description='The name for the flag (yes / no) in.German.'), fg_short_name_de
OPTIONS(description='The abbreviation for the flag (Y/N) in.German.'))
OPTIONS(DESCRIPTION = `IF THE FRONTEND REQUIRES A LIST OF VALUES FOR FLAGS (I.E. TRUE AND FALSE), THIS MINOR DIMENSION CAN BE USED AS A LOOKUP.`)
AS SELECT fg,
 fg_name,
 fg_name_de,
 fg_short_name_de
FROM ldl_score_core.t_dim_flag_2;