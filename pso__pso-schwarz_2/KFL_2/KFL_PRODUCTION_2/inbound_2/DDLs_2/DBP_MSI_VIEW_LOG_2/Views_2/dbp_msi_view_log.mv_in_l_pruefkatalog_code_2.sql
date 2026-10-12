CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_L_PRUEFKATALOG_CODE_2(
	MANDANT_ID,
	KATALOGART_ID,
	CODEGRUPPE_ID,
	PRUEFCODE_ID,
	VERSION_ID
) AS
--2022-08-29, AP0133256,SPEC0166769,dknop, initial based on LIS
   SELECT 
 v01.mandant_id
,v01.katalogart_id
,v01.codegruppe_id
,v01.pruefcode_id
,v01.version_id

FROM
   (
   SELECT
 v01_1.mandant_id
,v01_1.katalogart_id
,CASE WHEN v01_1.codegruppe_id = 'KLOAUTM' THEN SUBSTR(v01_1.codegruppe_id,1,3) ELSE v01_1.codegruppe_id END AS codegruppe_id
,v01_1.pruefcode_id, v01_1.version_id
FROM dbp_view.v_in_l_pruefkatalog_code_2 v01_1
   ) v01

GROUP BY 
 v01.mandant_id
,v01.katalogart_id
,v01.codegruppe_id
,v01.pruefcode_id
,v01.version_id
;