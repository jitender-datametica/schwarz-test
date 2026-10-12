-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

-- 18.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt

-- 13.02.2014 twie: Artbew_2 Aggregation auf Vertriebsweg, ohne Kunde

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_artbew_vw_sum_2 AS
-- Landesbeleg in Euro wird in Landeswaehrung angezeigt
 -- Landesbeleg in Landeswaehrung wird in Euro angezeigt

-- Landesbeleg in Euro wird in Landeswaehrung angezeigt
 -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
 SELECT
 V01.dat,
 V01.mandant_id,
 V01.art_id,
 V01.vw_id,
 V01.in_art_id,
 V01.in_art_nr,
 V01.vk_menge_org,
 V01.basismenge_einh_id,
 V01.vk_menge_st,
 V01.vk_menge_kg,
 V01.ek_mep_umsatz_temp,
 V01.bewart_id,
 V01.gp_id,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.umsatz_netto, 0)
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.umsatz_netto, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.umsatz_netto, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.umsatz_netto, 0)
   ELSE NULL
   END AS NUMERIC) AS umsatz_netto,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0)
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_mep_umsatz_temp, 0)
   ELSE NULL
   END AS NUMERIC) AS ek_mep_umsatz,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_artbew_vw_sum_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
   AND V500.nach_wrg_id = 'EUR' AND V01.dat BETWEEN V500.dat_von AND V500.dat_bis;