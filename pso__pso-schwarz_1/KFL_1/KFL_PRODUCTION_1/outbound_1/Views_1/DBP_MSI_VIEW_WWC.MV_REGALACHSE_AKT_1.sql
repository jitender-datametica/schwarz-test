CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_regalachse_akt_1 (aktiv_fg, art_id, display_art_id, ek_mep,
fachboden_nr, fachboden_pos, fbb_nr, kapazitaet, kapazitaet_faktor, kapazitaet_menge_einh_id, mandant_id, nb_id,
regional_kz, soll_ist_kz, vk_brutto_umrechnung, mwst, vk_netto, wup_id, regalachse_flaeche) AS SELECT V01.aktiv_fg,
 V01.art_id,
 V01.display_art_id,
 CAST(CASE
   WHEN V01.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.ek_mep, 0)
   WHEN V01.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 1
   THEN TRUNC(CAST(COALESCE(V01.ek_mep, 0) / V400.umrechnungskurs AS BIGNUMERIC))
   WHEN V01.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.ek_mep, 0) * V400.umrechnungskurs
   WHEN V01.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.ek_mep, 0)
   ELSE NULL
   END AS NUMERIC) AS ek_mep,
 V01.fachboden_nr,
 V01.fachboden_pos,
 V01.fbb_nr,
 V01.kapazitaet,
 V01.kapazitaet_faktor,
 V01.kapazitaet_menge_einh_id,
 V01.mandant_id,
 V01.nb_id,
 V01.regional_kz,
 V01.soll_ist_kz,
 CAST(CASE
   WHEN V01.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.vk_brutto, 0)
   WHEN V01.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 1
   THEN TRUNC(CAST(COALESCE(V01.vk_brutto, 0) / V400.umrechnungskurs AS BIGNUMERIC))
   WHEN V01.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.vk_brutto, 0) * V400.umrechnungskurs
   WHEN V01.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.vk_brutto, 0)
   ELSE NULL
   END AS NUMERIC) AS vk_brutto_umrechnung,
 COALESCE(V01.mwst, 0) AS mwst,
  TRUNC(CAST(CAST(CASE
       WHEN V01.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 0
       THEN COALESCE(V01.vk_brutto, 0)
       WHEN V01.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 1
       THEN TRUNC(CAST(COALESCE(V01.vk_brutto, 0) / V400.umrechnungskurs AS BIGNUMERIC))
       WHEN V01.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 0
       THEN COALESCE(V01.vk_brutto, 0) * V400.umrechnungskurs
       WHEN V01.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 1
       THEN COALESCE(V01.vk_brutto, 0)
       ELSE NULL
       END AS NUMERIC) / (100.000 + V01.mwst) AS BIGNUMERIC)) * 100 AS vk_netto,
 V01.wup_id,
 V01.regalachse_flaeche
FROM kfl_production_dbp_view.v_regalachse_akt_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V400 ON V01.wrg_id = V400.von_wrg_id AND V400.dat_bis = DATE '9999-12-31'
   AND V400.kurstyp_id = 9 AND V400.nach_wrg_id = 'EUR';