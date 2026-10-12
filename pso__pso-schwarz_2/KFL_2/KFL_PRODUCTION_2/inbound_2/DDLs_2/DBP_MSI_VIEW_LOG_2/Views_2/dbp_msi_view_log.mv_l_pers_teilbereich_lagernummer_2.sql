CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_PERS_TEILBEREICH_LAGERNUMMER_2(
	PERS_TEILBEREICH_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	LAGERNUMMER_ID
) AS
--2023-08-18, AP0145540 ,dknop, initial
SELECT DISTINCT
v01.pers_teilbereich_id,
v01.mandant_id,
v01.nb_id,
v01.wup_id,
v01.lagernummer_id
--COALESCE(CASE WHEN v01.lagernummer_id='' THEN NULL ELSE v01.lagernummer_id END,'-1') AS lagernummer_id
FROM dbp_view.v_l_lagernummer_2 v01

UNION

SELECT 
 v01.pers_teilbereich_id
,v01.mandant_id
,'-111' AS nb_id
,v01.wup_id
,'-1'
FROM dbp_view.v_l_lagernummer_2 v01;