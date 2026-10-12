/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_site_status_2
Description		| Lifecycle status_2 of a site
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_site_status_2 (site_status_cd
OPTIONS(description='The code for the status_2 of the site.'), site_status_descr
OPTIONS(description='A textual description for the site_status_cd written out in group language (German).'))
OPTIONS(DESCRIPTION = `THIS DIMENSION TRACKS THE LIFECYCLE STATUS_2 OF A SITE. E.G. A SITE CAN BE ACTIVE OR DELETED.`) AS
SELECT site_status_cd,
 site_status_descr
FROM ldl_score_core.t_dim_site_status_2;