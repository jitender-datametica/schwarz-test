CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WEWA
AS 
--   03.04.2012 AL neu erstellt
-- 19.09.2012 AL ergänzt um ekn2 (ek_nettonetto)
-- 05.11.2012 AL Datentypanpassung EK nettonetto und Einstandspreis auf NUMBER(38,5)
-- 03.07.2013 #585784 sschücke / Erweiterung um Feld betrag_vk_netto
--25.11.2019 SPEC0066248 -fields konditionsbetrag_zar5 and ek_brutto added
-- 21.11.2023 staeblern / Umbenennung der Spalte Betrag zu betrag_ek_netto
-- 12.12.2023 staeblern / Aktionskonditionsmetriken 
-- 31.01.2024 staeblern / Aktionskonditionsmetriken ADD COALESCE ek_netto_normal, da nicht immer vorhanden
-- 28.02.2024 staeblern / Simulationsmetriken angleichen - zwei neue Fakten für die Anpassung der Metriken im FE
-- 23.06.2025 prescher / SPEC0313583- Aufnahme Fakt Kalkulationsbasis 
 SELECT
   v01.mandant_id,
   wewa_beleg_id,
   wewa_beleg_pos_id,
   wewa_jahr,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v01.gp_id,
   v01.lager_bewart_id,
   v01.dat_buch,
   menge_basis,
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN v01.betrag_ek_netto
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  v01.betrag_ek_netto * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  v01.betrag_ek_netto * umrechnungskurs_1
             END AS DECIMAL(18,6))   AS betrag_ekn,
   CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN v01.betrag_vk_netto
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  v01.betrag_vk_netto* umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  v01.betrag_vk_netto* umrechnungskurs_1
             END AS DECIMAL(18,6))   AS betrag_vk_netto,
   CASE WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = -111 THEN menge_basis END AS wewa_menge_zl,
   CASE WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = 0      THEN menge_basis END AS wewa_menge_dz,
   CASE WHEN lager_bewart_id IN (161, 162) AND nb_id = -111 THEN menge_basis END     AS wewa_menge_ret_zl,
   CASE WHEN lager_bewart_id IN (161, 162) AND nb_id = 0      THEN menge_basis END     AS wewa_menge_ret_dz,
   CASE WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = -111 THEN betrag_ekn END AS wewa_betrag_zl,
   CASE WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = 0      THEN betrag_ekn END AS wewa_betrag_dz,
   CASE WHEN lager_bewart_id IN (161, 162) AND nb_id = -111 THEN betrag_ekn END     AS wewa_betrag_ret_zl,
   CASE WHEN lager_bewart_id IN (161, 162) AND nb_id = 0      THEN betrag_ekn END     AS wewa_betrag_ret_dz,
      CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(einstandspreis_v02,einstandspreis_v03)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(einstandspreis_v02,einstandspreis_v03)  * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(einstandspreis_v02,einstandspreis_v03)  * umrechnungskurs_1
             END AS NUMBER(38,5))   AS einstandspreis,
   CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(ek_mep_vor_fwu_v02,ek_mep_vor_fwu_v03)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(ek_mep_vor_fwu_v02,ek_mep_vor_fwu_v03)  * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(ek_mep_vor_fwu_v02,ek_mep_vor_fwu_v03)  * umrechnungskurs_1
             END AS NUMBER(38,5))   AS ek_mep_vor_fwu,
   CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(ek_mep_v02,ek_mep_v03)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(ek_mep_v02,ek_mep_v03)  * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(ek_mep_v02,ek_mep_v03)  * umrechnungskurs_1
             END AS NUMBER(38,5))   AS ek_mep,
	CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(ek_kalkulationsbasis_v02,ek_kalkulationsbasis_v03)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(ek_kalkulationsbasis_v02,ek_kalkulationsbasis_v03)  * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(ek_kalkulationsbasis_v02,ek_kalkulationsbasis_v03)  * umrechnungskurs_1
             END AS NUMBER(38,5))   AS ek_kalkulationsbasis,			 
    CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(ek_kalkulationsbasis_ohne_fwu_v02,ek_kalkulationsbasis_ohne_fwu_v03)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(ek_kalkulationsbasis_ohne_fwu_v02,ek_kalkulationsbasis_ohne_fwu_v03)  * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(ek_kalkulationsbasis_ohne_fwu_v02,ek_kalkulationsbasis_ohne_fwu_v03)  * umrechnungskurs_1
             END AS NUMBER(38,5))   AS ek_kalkulationsbasis_ohne_fwu,	
   CAST(CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(ek_nettonetto_v02,ek_nettonetto_v03)
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(ek_nettonetto_v02,ek_nettonetto_v03)  * umrechnungskurs_0
             WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(ek_nettonetto_v02,ek_nettonetto_v03)  * umrechnungskurs_1
             END AS NUMBER(38,5))   AS ek_nettonetto,
			v01.konditionsbetrag_zar5,
   CAST (CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(ek_brutto_v02,ek_brutto_v03)
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(ek_brutto_v02,ek_brutto_v03)  * umrechnungskurs_0
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(ek_brutto_v02,ek_brutto_v03)  * umrechnungskurs_1
              END AS NUMBER(38,5)) AS ek_brutto,
   CAST (CASE WHEN v200.wrg_typ_id  = 1 THEN COALESCE(ek_brutto_normal_v02,ek_brutto_normal_v03)
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN  COALESCE(ek_brutto_normal_v02,ek_brutto_normal_v03)  * umrechnungskurs_0
              WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN  COALESCE(ek_brutto_normal_v02,ek_brutto_normal_v03)  * umrechnungskurs_1
              END AS NUMBER(38,5)) AS ek_brutto_normal,
   wewa_status,
   v01.wrg_id,
   v01.posten_kz_per,
  CASE 
      WHEN mandant_id = 7 
      THEN ( COALESCE((menge_basis * ek_brutto_normal),0)-(menge_basis * ek_brutto))+((((menge_basis * ek_brutto) * konditionsbetrag_zar5) / 1000) * -1)
      ELSE ((((menge_basis * ek_brutto) * konditionsbetrag_zar5) / 1000) * -1)
  END AS WE_Betrag_Aktionskond,
  CASE 
      WHEN mandant_id = 7 
      THEN NULLIFZERO((menge_basis * ek_brutto_normal))
      ELSE NULLIFZERO((menge_basis * ek_brutto))
  END AS WE_Wert_EK_brutto_Normalkalk_inkl_Ret,
  -- nochmals die Werte damit nur bei RO wir werte erhalten. 
  CASE 
      WHEN mandant_id = 7 
      THEN (COALESCE((menge_basis * ek_brutto_normal),0)-(menge_basis * ek_brutto))+((((menge_basis * ek_brutto) * konditionsbetrag_zar5) / 1000) * -1)
      ELSE 0
  END AS WE_Betrag_Aktionskond_nur_ro,
  CASE 
      WHEN mandant_id = 7 
      THEN NULLIFZERO((menge_basis * ek_brutto_normal))
      ELSE NULLIFZERO(0)
  END AS WE_Wert_EK_brutto_Normalkalk_inkl_Ret_nur_ro 
   FROM dbp_msi_view_ais_kmo.TBL_MV_WEWA v01 
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200;