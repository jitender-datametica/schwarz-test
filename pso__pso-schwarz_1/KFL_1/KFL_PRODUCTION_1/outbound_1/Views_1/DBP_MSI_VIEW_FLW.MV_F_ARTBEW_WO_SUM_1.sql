-- 18.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt

-- Waehrungsumrechnung, Achtung Tabelle hat keine wrg_id, manche Fakten sind immer in Euro, manche immer in Landeswrg.

-- 13.02.2014 twie: neues artbew_1 Aggregat auf Woche_1 kjwo_kl (!= kjwo), Mapping erfolt in der mv_woche_kj_kl_1

-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_artbew_wo_sum_1 (kjwo_kl, mandant_id, art_id, in_kunde_id,
kunde_nr, kunde_name, in_art_id, in_art_nr, vk_menge_org, basismenge_einh_id, vk_menge_st, vk_menge_kg, umsatz_netto,
ek_mep_umsatz_temp, ek_mep_umsatz, bewart_id, gp_id, wrg_id) AS SELECT V01.kjwo_kl,
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
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_artbew_wo_sum_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.default_wrg = V500.von_wrg_id
     AND V01.kjwo_kl_dat_bis BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V01.mandant_id IN (1, 2)
 AND V01.arthiertyp_id = 2;