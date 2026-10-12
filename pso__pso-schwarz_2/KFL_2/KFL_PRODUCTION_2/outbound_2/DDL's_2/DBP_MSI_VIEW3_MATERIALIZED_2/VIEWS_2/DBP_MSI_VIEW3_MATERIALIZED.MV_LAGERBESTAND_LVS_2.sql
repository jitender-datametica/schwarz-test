-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

-- 05.12.2019 baranowska: AP0041558, SPEC0066698 kj_lief_beleg

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_lagerbestand_lvs_2 (USERID STRING) AS SELECT
 V01.art_id,
 V01.best_qualifikation_id,
 V01.dat,
 V01.dat_haltbarkeit,
 V01.lagernummer_id,
 V01.lagertyp_id,
 V01.lagerplatz_id,
 V01.lagerort_id,
 V01.lagerquant_id,
 V01.lief_beleg_id,
 V01.lief_beleg_pos_id,
 V01.mandant_id,
 V01.menge_lgbest_lvs_frei_bme,
 V01.menge_lgbest_lvs_ges_bme,
 V01.menge_lgbest_lvs_kolli,
 V01.menge_lgbest_lvs_off_trans_bme,
 V01.menge_lgbest_lvs_palette,
 V01.menge_lgbest_lvs_auslager AS menge_lgbest_lvs_bme,
  V01.betrag_lgbest_lvs * V02.ek_anzeige_fg AS betrag_lgbest_lvs,
 V01.nb_id,
 V01.sond_best_id,
 V01.wup_id,
 V01.system_id,
  CASE
  WHEN V05.wrg_typ_id = 0
  THEN V01.vk_netto_lgbest_lvs * V04.umrechnungskurs
  ELSE V01.vk_netto_lgbest_lvs
  END AS vk_netto_lgbest_lvs,
 DATE_SUB(V01.dat_haltbarkeit, INTERVAL CAST(ROUND(V03.mhd_zeitraum * V03.lager_prozent / 100 + 0.5) AS INTEGER) DAY)
 AS letzter_we_markt_bestand,
 V01.lager_einheiten_typ,
 V01.gewicht_gesamt,
 V01.dat_letzte_bewegung,
 DATE_DIFF(CURRENT_DATE, V01.dat_letzte_bewegung, DAY) AS dauer_bestand_tage,
 V01.volumen_kolli,
 V01.volumen_palette,
 V05.wrg_id,
 V05.wrg_typ_id,
 V01.kj_lief_beleg
FROM kfl_production_dbp_view.v_lagerbestand_lvs_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_2 AS V02 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_art_2 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_kurs_2 AS V04 ON V01.wrg_id = V04.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V05 ON V01.mandant_id = V05.mandant_id
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS V06 ON V05.wrg_typ_id = V06.wrg_typ_id;
