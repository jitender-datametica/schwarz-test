CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_ARTBEW_VW_SUM_2
   -- 13.02.2014 twie: Artbew_2 Aggregation auf Vertriebsweg, ohne Kunde
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
--18.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt
   AS 
   SELECT
DAT,	v01.MANDANT_ID,	ART_ID,	VW_ID,	IN_ART_ID,	IN_ART_NR,	VK_MENGE_ORG,	BASISMENGE_EINH_ID,	VK_MENGE_ST,	VK_MENGE_KG,	EK_MEP_UMSATZ_TEMP,	BEWART_ID,	GP_ID 
  ,  CAST(
   CASE WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.umsatz_netto,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v01.umsatz_netto,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v01.umsatz_netto,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v01.umsatz_netto,0)
   END
   AS DECIMAL(18,4))
   AS umsatz_netto
   ,  CAST(
   CASE WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(ek_mep_umsatz_temp,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(ek_mep_umsatz_temp,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(ek_mep_umsatz_temp,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(ek_mep_umsatz_temp,0)
   END
   AS DECIMAL(18,4))
   AS ek_mep_umsatz
   , v400.wrg_id
    FROM 
    DBP_MSI_VIEW_FLW.tbl_MV_F_ARTBEW_VW_SUM_2 v01 
    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300
   JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs_2 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat BETWEEN v500.dat_von AND v500.dat_bis;