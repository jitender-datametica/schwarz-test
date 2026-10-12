CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_USER_WRG_AUSWAHL_1
   (
    USER_ID
   ,WRG_TYP_ID
   ,WRG_TYP_BEZ
   ,BERICHTSKURS_TYP_ID
   ,BERICHTSKURS_TYP_BEZ
   )
   AS
SELECT 
 v01.user_id
,v01.wrg_typ_id
,CASE WHEN wrg_typ_id = 0 THEN 'EURO'
      WHEN wrg_typ_id = 1 THEN 'Land_1'
      ELSE 'keine Auswahl' END AS wrg_typ_bez
,v01.berichtskurs_typ_id
,CASE WHEN v01.wrg_typ_id = 1 THEN 'Local Currency'
      WHEN v01.wrg_typ_id = 0 AND v01.berichtskurs_typ_id = 0 THEN 'EURO - akt. Berichtskurs'
      WHEN v01.wrg_typ_id = 0 AND v01.berichtskurs_typ_id = 1 THEN 'EURO - Berichtskurs je GJ'
      END AS BERICHTSKURS_TYP_BEZ
FROM dbp_msi_v_view.v_user_wrg_typ_zu_1 v01;