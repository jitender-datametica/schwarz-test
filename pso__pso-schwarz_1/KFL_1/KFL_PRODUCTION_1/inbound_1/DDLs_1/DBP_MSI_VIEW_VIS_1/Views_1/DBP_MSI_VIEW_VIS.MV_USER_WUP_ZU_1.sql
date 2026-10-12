CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_USER_WUP_ZU_1(
	USER_ID,
	MANDANT_ID,
	WUP_ID
) AS
/*	SECURITY VIS : Zuordnung User-Filiale
	2009KW47 Initial. Einführung VIS User Security
	2023-10-26 ssch0611 : ipldap7 erfordert LOWER(user_id) 
*/

SELECT
  LOWER(t01.user_id)
, t01.mandant_id
, t01.wup_id
FROM dbp_msi_v_view.v_user_wup_zu_1 t01
;
