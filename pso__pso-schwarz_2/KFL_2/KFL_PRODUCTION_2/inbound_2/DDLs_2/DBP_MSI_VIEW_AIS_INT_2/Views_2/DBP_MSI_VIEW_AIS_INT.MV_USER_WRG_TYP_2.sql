CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_USER_WRG_TYP_2(
 user_id
,wrg_typ_id
,berichtskurs_typ_id
,currency_type
) 
AS
SELECT 
v01.user_id
,v01.wrg_typ_id
,v01.berichtskurs_typ_id
,CASE WHEN v01.wrg_typ_id = 1 THEN 'Local Currency'
      WHEN v01.wrg_typ_id = 0 AND v01.berichtskurs_typ_id = 0 THEN 'EURO - akt. Berichtskurs'
      WHEN v01.wrg_typ_id = 0 AND v01.berichtskurs_typ_id = 1 THEN 'EURO - Berichtskurs je GJ'
      END AS currency_type
/*,CASE WHEN v01.wrg_typ_id = 1 THEN 'Local Currency' 
        ELSE 'EURO' END AS currency_type */

FROM
dbp_msi.akt_msi_user_wrg_typ_zu_2 v01;