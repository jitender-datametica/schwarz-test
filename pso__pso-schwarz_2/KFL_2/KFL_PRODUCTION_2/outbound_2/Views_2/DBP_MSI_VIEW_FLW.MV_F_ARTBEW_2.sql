-- 26.10.2011 system_id entfernt

-- 23.10.2013 twie: reine Retailartikel ohne Industriependant mit Retailumrechnungsfaktor umrechnen

-- 18.09.2018 naku:  Sicherung wegen WG Umstellung und Anpassungen

-- 21.10.2013 twie: CROSS JOIN auf in_art_2 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen

-- 30.11.2011 MR Performance art_id Verbindung
 -- 13.02.2014 twie: diff_umsatz_netto_konz entfernen

-- 02.10.2013 twie: Erweitert um mandant_id 2
 -- 29.01.2014 twie: Waehrungsumrechnung

-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
 -- 24.10.2013 twie: gp_id ausgeben

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_artbew_2 AS
-- Landesbeleg in Euro wird in Landeswaehrung angezeigt
 -- Landesbeleg in Landeswaehrung wird in Euro angezeigt

-- Landesbeleg in Euro wird in Landeswaehrung angezeigt
 -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
 SELECT
 V01.dat,
 V01.mandant_id,
 V01.art_id,
 V01.in_kunde_id,
 V01.kunde_nr,
 V01.kunde_name,
 V01.in_art_id,
 V01.in_art_nr,
 V01.vk_menge_org,
 V01.basismenge_einh_id,
 V01.vk_menge_st,
 V01.vk_menge_kg,
 CAST(CASE
   WHEN V01.wrg_2 <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.umsatz_netto, 0)
   WHEN V01.wrg_2 <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.umsatz_netto, 0) / V500.umrechnungskurs
   WHEN V01.wrg_2 = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.umsatz_netto, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V01.wrg_2 = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.umsatz_netto, 0)
   ELSE NULL
   END AS NUMERIC) AS umsatz_netto,
 V01.ek_mep_umsatz_temp,
 CAST(CASE
   WHEN V01.wrg_2 <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0)
   WHEN V01.wrg_2 <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0) / V500.umrechnungskurs
   WHEN V01.wrg_2 = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V01.wrg_2 = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0)
   ELSE NULL
   END AS NUMERIC) AS ek_mep_umsatz,
 V01.bewart_id,
 V01.gp_id,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_artbew_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_2 = V500.von_wrg_id AND
    V500.nach_wrg_id = 'EUR' AND V01.dat BETWEEN V500.dat_von AND V500.dat_bis;