CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_USER_VIS_BENCHMARK_1(
	MANDANT_ID,
	USER_ID,
	HIERARCHIE_EBENE_ID,
	HIERARCHIE_ELEMENT_ID
) AS
/*	SECURITY VIS Mobile : Zuordnung User-Rolle
	Ergänzung für user_wup_zu_1
	2013-05-22 Initial. VIS Mobile
	2023-10-26 ssch0611 : ipldap7 erfordert LOWER(user_id) 
*/
 
SELECT
  t01.mandant_id
, LOWER(t01.user_id)
, t01.hierarchie_ebene_id
, t01.hierarchie_element_id
FROM dbp_msi_v_view.v_user_vis_benchmark_zu_1 t01
;