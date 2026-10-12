-- 24.10.2013 twie: gp_id ausgeben
 -- ,system_id

-- 21.10.2013 twie: CROSS JOIN auf in_art_2 jetzt auf MV-VIEW, damit auch reine Retailartikel mitkommen

-- 23.10.2013 twie: reine Retailartikel ohne Industriependant mit Retailumrechnungsfaktor umrechnen

-- 26.10.2011 system_id entfernt
 -- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

-- 13.02.2014 twie: ek_mep ausgeben, diff_umsatz_netto_konz entfernen

-- 18.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt

-- 22.10.2013 twie: CROSS JOIN zu in_kunde_2 vereinfacht ueber wup_id

-- 29.01.2014 twie: Waehrungsumrechnung, Achtung Tabelle hat keine wrg_id, manche Fakten sind immer in Euro, manche immer in Landeswrg.

-- 02.10.2013 twie: Erweitert um mandant_id 2
 -- 30.11.2011 MR Performance art_id Verbindung

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_artbew_mo_sum_2 (kjmo, mandant_id, art_id, in_kunde_id,
kunde_nr, kunde_name, in_art_id, in_art_nr, vk_menge_org, basismenge_einh_id, vk_menge_st, vk_menge_kg, umsatz_netto,
ek_mep_umsatz_temp, ek_mep_umsatz, bewart_id, gp_id, wrg_id) AS SELECT V01.kjmo,
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
   WHEN V200.wrg_typ_id = 0
   THEN COALESCE(V01.umsatz_netto, 0) * V500.umrechnungskurs -- umsatz_netto ist immer in Landeswaehrung -> wird fuer User in Landeswaehrung angezeigt

   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.umsatz_netto, 0)
   ELSE NULL
   END AS NUMERIC) AS umsatz_netto,
 V01.ek_mep_umsatz_temp,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0) * V500.umrechnungskurs -- ek_mep_umsatz_temp ist immer in Landeswaehrung -> wird fuer User in Landeswaehrung angezeigt

   WHEN V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0)
   ELSE NULL
   END AS NUMERIC) AS ek_mep_umsatz,
 V01.bewart_id,
 V01.gp_id,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_artbew_mo_sum_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.default_wrg = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.max_dat BETWEEN V500.dat_von AND V500.dat_bis;