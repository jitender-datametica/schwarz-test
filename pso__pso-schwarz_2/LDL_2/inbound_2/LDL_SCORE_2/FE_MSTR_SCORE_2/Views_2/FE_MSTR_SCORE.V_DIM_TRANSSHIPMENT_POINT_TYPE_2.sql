/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_transshipment_point_type_2
Description		| Type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_transshipment_point_type_2(
	transpoint_type_cd COMMENT 'The code for the type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.',
	transpoint_type_descr COMMENT 'A textual description for the transpoint_type_cd written out in group language (German).'
) COMMENT='This dimension defines type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.'
 AS 
SELECT
  transpoint_type_cd
  ,transpoint_type_descr
FROM core.t_dim_transshipment_point_type_2;