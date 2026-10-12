CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_USER_WRG_TYP_1(
	USER_ID,
	WRG_TYP_ID,
	BERICHTSKURS_TYP_ID,
	CURRENCY_TYPE
) AS
SELECT 
 v01.user_id
,v01.wrg_typ_id
,v01.berichtskurs_typ_id
,CASE WHEN v01.wrg_typ_id = 1 THEN 'Local Currency'
      WHEN v01.wrg_typ_id = 0 AND v01.berichtskurs_typ_id = 0 THEN 'EURO - curr. reporting rate'
      WHEN v01.wrg_typ_id = 0 AND v01.berichtskurs_typ_id = 1 THEN 'EURO - reporting rate FY'
      END AS currency_type
FROM dbp_msi.akt_msi_user_wrg_typ_zu_1 v01;