/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_site_operator_status_1
Description		| Lifecycle status_1 of a site operator
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_site_operator_status_1(
	site_operator_status_cd COMMENT 'The code for the status_1 of the site.',
	site_operator_status_descr COMMENT 'A textual description for the site_status_cd written out in group language (German).'
) COMMENT='This dimension tracks the lifecycle status_1 of a site operator. E.g. a site can be active or deleted.'
 AS 
SELECT
   site_operator_status_cd
  ,site_operator_status_descr
FROM core.t_dim_site_operator_status_1;