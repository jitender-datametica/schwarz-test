/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_site_operator_status
Description		| Lifecycle status of a site operator
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_site_operator_status (site_operator_status_cd
OPTIONS(description='The code for the status of the site.'), site_operator_status_descr
OPTIONS(description='A textual description for the site_status_cd written out in group language (German).'))
OPTIONS(DESCRIPTION = `THIS DIMENSION TRACKS THE LIFECYCLE STATUS OF A SITE OPERATOR. E.G. A SITE CAN BE ACTIVE OR DELETED.`)
AS SELECT site_operator_status_cd,
 site_operator_status_descr
FROM ldl_score_core.t_dim_site_operator_status;