CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_USER_WRG_AUSWAHL(
	USER_ID,
	WRG_TYP_ID,
	WRG_TYP_BEZ,
	BERICHTSKURS_TYP_ID,
	BERICHTSKURS_TYP_BEZ
) AS
SELECT
    user_id
   ,wrg_typ_id
   ,CASE WHEN wrg_typ_id = 0 THEN 'EURO'
         WHEN wrg_typ_id = 1 THEN 'Land'
         ELSE 'keine Auswahl' END AS wrg_typ_bez
   ,berichtskurs_typ_id
   ,CASE WHEN berichtskurs_typ_id = 0 THEN 'akt. Berichtskurs'
         WHEN berichtskurs_typ_id = 1 THEN 'hist. Berichtskurs'
         END AS berichtskurs_typ_bez
FROM dbp_msi_data.user_wrg_typ_zu;