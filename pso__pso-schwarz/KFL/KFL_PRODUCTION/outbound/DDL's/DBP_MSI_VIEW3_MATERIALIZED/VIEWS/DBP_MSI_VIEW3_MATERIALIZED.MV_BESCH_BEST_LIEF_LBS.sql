-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_besch_best_lief_lbs (USERID STRING) AS SELECT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.dat_buch,
 V01.endlief_fg,
 V01.best_menge_orig_fg,
 V01.annahmeverweigerung_id,
 V01.nb_id,
 V01.art_id,
 V01.gp_id,
 V01.wup_id,
 V01.lagerort_id,
 V01.bestellart_id,
 V01.dat_best_beleg,
 V01.dat_lief_wunsch,
 V01.dat_lief_bewertung,
 V01.menge_lief,
 V01.betrag_lagerbew_ek_n,
 V01.betrag_best_ek_n,
 V01.menge_best_bme,
 V01.fehllieferung_kz,
 V01.menge_lief_ist_kolli AS menge_lagerbew_kolli,
 V01.menge_lief_soll_kolli AS menge_best_kolli,
 V01.betrag_fehlmenge_vk_brutto,
 V04.wrg_id,
 V04.wrg_typ_id,
 V02.spaet_lief_tage,
 V06.prozent_akzeptanz_unterlief
FROM kfl_production_dbp_view.v_besch_best_lief_lbs AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_mandant AS V02 ON V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_kurs AS V03 ON V01.wrg_id = V03.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V04 ON V01.mandant_id = V04.mandant_id
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS V07 ON V04.wrg_typ_id = V07.wrg_typ_id
  
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu AS V05 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_ek_infosatz_wup_zu AS V06 ON V01.mandant_id = V06.mandant_id AND V01.wup_id = V06
   .wup_id;
