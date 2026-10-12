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

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_flag_2(
	fg COMMENT 'The flag (true or false)',
	fg_name COMMENT 'The name for the flag (yes / no) in group language, i.e. German.',
	fg_name_de COMMENT 'The name for the flag (yes / no) in.German.',
	fg_short_name_de COMMENT 'The abbreviation for the flag (Y/N) in.German.'
) COMMENT='If the frontend requires a list of values for flags (i.e. true and false), this minor dimension can be used as a lookup.'
 AS 
SELECT
   fg
  ,fg_name
  ,fg_name_de
  ,fg_short_name_de
FROM core.t_dim_flag_2;
