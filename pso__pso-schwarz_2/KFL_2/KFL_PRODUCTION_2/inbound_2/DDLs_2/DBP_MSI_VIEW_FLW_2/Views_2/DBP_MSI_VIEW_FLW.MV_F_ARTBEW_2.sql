CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_ARTBEW_2 -- 30.11.2011 MR Performance art_id Verbindung
-- 26.10.2011 system_id entfernt
-- 02.10.2013 twie: Erweitert um mandant_id 2
-- 21.10.2013 twie: Join auf in_art_2 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen
-- 23.10.2013 twie: reine Retailartikel ohne Industriependant mit Retailumrechnungsfaktor umrechnen
-- 24.10.2013 twie: gp_id ausgeben
-- 29.01.2014 twie: Waehrungsumrechnung
-- 13.02.2014 twie: diff_umsatz_netto_konz entfernen
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
--18.09.2018 naku:  Sicherung wegen WG Umstellung und Anpassungen
AS
SELECT
   v01.dat,
   v01.mandant_id,
   v01.art_id,
   in_kunde_id,
   kunde_nr,
   kunde_name,
   in_art_id,
   in_art_nr,
   vk_menge_org,
   basismenge_einh_id,
   vk_menge_st,
   vk_menge_kg,
   CAST(
      CASE
         WHEN v01.wrg_2 <> v01.default_wrg
         AND v200.wrg_typ_id = 0 THEN COALESCE(v01.umsatz_netto, 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
         WHEN v01.wrg_2 <> v01.default_wrg
         AND v200.wrg_typ_id = 1 THEN (
            COALESCE(v01.umsatz_netto, 0) / v500.umrechnungskurs
         ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
         WHEN v01.wrg_2 = v01.default_wrg
         AND v200.wrg_typ_id = 0 THEN COALESCE(v01.umsatz_netto, 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
         WHEN v01.wrg_2 = v01.default_wrg
         AND v200.wrg_typ_id = 1 THEN COALESCE(v01.umsatz_netto, 0)
      END AS DECIMAL(18, 4)
   ) AS umsatz_netto,
   ek_mep_umsatz_temp,
   CAST(
      CASE
         WHEN v01.wrg_2 <> v01.default_wrg
         AND v200.wrg_typ_id = 0 THEN COALESCE(ek_mep_umsatz_temp, 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
         WHEN v01.wrg_2 <> v01.default_wrg
         AND v200.wrg_typ_id = 1 THEN (
            COALESCE(ek_mep_umsatz_temp, 0) / v500.umrechnungskurs
         ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
         WHEN v01.wrg_2 = v01.default_wrg
         AND v200.wrg_typ_id = 0 THEN COALESCE(ek_mep_umsatz_temp, 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
         WHEN v01.wrg_2 = v01.default_wrg
         AND v200.wrg_typ_id = 1 THEN COALESCE(ek_mep_umsatz_temp, 0)
      END AS DECIMAL(18, 4)
   ) AS ek_mep_umsatz,
   v01.bewart_id,
   v01.gp_id,
   v400.wrg_id
FROM
   DBP_MSI_VIEW_FLW.tbl_MV_F_ARTBEW_2 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_2 v300
   JOIN dbp_view.v_mandant_wrg_typ_zu_2 v400 ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs_2 v500 ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_2 = v500.von_wrg_id
   AND v500.nach_wrg_id = 'EUR'
   AND v01.dat BETWEEN v500.dat_von
   AND v500.dat_bis;