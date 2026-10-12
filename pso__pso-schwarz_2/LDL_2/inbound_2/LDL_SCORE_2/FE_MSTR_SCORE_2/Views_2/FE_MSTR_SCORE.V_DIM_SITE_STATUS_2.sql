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

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_site_status_2(
	site_status_cd COMMENT 'The code for the status_2 of the site.',
	site_status_descr COMMENT 'A textual description for the site_status_cd written out in group language (German).'
) COMMENT='This dimension tracks the lifecycle status_2 of a site. E.g. a site can be active or deleted.'
 AS 
SELECT
   site_status_cd
  ,site_status_descr
FROM core.t_dim_site_status_2;