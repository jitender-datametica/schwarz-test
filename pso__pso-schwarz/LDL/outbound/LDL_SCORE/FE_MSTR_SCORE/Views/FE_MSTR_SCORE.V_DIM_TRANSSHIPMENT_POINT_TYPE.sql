/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_transshipment_point_type
Description		| Type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_transshipment_point_type (transpoint_type_cd
OPTIONS(description='The code for the type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.'),
transpoint_type_descr
OPTIONS(description='A textual description for the transpoint_type_cd written out in group language (German).'))
OPTIONS(DESCRIPTION = `THIS DIMENSION DEFINES TYPE OF TRANSSHIPMENT POINT E.G. WH = LAGER, HEAD = FIRMENSITZ.`) AS
SELECT transpoint_type_cd,
 transpoint_type_descr
FROM ldl_score_core.t_dim_transshipment_point_type;