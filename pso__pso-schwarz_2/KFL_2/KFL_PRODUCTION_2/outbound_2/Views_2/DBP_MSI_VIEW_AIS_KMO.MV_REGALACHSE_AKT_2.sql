CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_regalachse_akt_2 (aktiv_fg, art_id, display_art_id, ek_mep,
fachboden_nr, fachboden_pos, fbb_nr, kapazitaet, kapazitaet_faktor, kapazitaet_menge_einh_id, mandant_id, nb_id,
regional_kz, soll_ist_kz, vk_brutto_umrechnung, mwst, vk_netto, wup_id, regalachse_flaeche) AS
/* CAST(
   CASE WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 0 THEN COALESCE( v01.ek_mep ,0)
  -- Landesbeleg in Euro wird in Landeswährung angezeigt
        WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 1 THEN COALESCE(v01.ek_mep ,0) / v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Euro angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 0  THEN COALESCE(v01.ek_mep ,0) * v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Landeswährung angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 1  THEN COALESCE(v01.ek_mep ,0)
        END AS NUMERIC(18,6)) AS ek_mep, */
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025

/* CAST(
   CASE WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 0 THEN COALESCE(v01.vk_brutto ,0)
  -- Landesbeleg in Euro wird in Landeswährung angezeigt
        WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 1 THEN COALESCE(v01.vk_brutto ,0) / v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Euro angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 0  THEN COALESCE(v01.vk_brutto ,0) * v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Landeswährung angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 1  THEN COALESCE(v01.vk_brutto ,0)
        END AS NUMERIC(18,6)) AS vk_brutto_umrechnung, */
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
 SELECT V01.aktiv_fg,
 V01.art_id,
 V01.display_art_id,
 ROUND(CAST(CASE
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN COALESCE(V01.ek_mep, 0) * V01.umrechnungskurs_0
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN COALESCE(V01.ek_mep, 0) * V01.umrechnungskurs_1
    ELSE COALESCE(V01.ek_mep, 0)
    END AS NUMERIC), 6) AS ek_mep,
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
 ROUND(CAST(CASE
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
    THEN COALESCE(V01.vk_brutto, 0) * V01.umrechnungskurs_0
    WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
    THEN COALESCE(V01.vk_brutto, 0) * V01.umrechnungskurs_1
    ELSE COALESCE(V01.vk_brutto, 0)
    END AS NUMERIC), 6) AS vk_brutto_umrechnung,
 V01.mwst,
   ROUND(CAST(CASE
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 0
      THEN COALESCE(V01.vk_brutto, 0) * V01.umrechnungskurs_0
      WHEN V200.wrg_typ_id = 0 AND V200.berichtskurs_typ_id = 1
      THEN COALESCE(V01.vk_brutto, 0) * V01.umrechnungskurs_1
      ELSE COALESCE(V01.vk_brutto, 0)
      END AS NUMERIC), 6) / (100.000 + V01.mwst) * 100 AS vk_netto,
 V01.wup_id,
 V01.regalachse_flaeche
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_regalachse_akt_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE;