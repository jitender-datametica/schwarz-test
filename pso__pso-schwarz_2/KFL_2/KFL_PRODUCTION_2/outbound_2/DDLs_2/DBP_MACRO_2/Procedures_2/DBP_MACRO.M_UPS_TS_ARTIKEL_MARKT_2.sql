CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_artikel_markt(p_mandant_id FLOAT64, p_wup_id BIGNUMERIC, p_nb_id BIGNUMERIC, p_art_id FLOAT64, p_aktion_id STRING, p_angebot_id STRING, p_dat_von DATE, p_dat_bis DATE, p_gk_fg INT64, p_menge_mindestplatzierung_bme NUMERIC, p_top_gk_fg INT64, p_fixmenge_wfl_bme INT64, p_adjustment_id INT64, p_max_kapa_fg FLOAT64, p_dat_letzte_nachversorgung STRING, p_faktor_max_kapa_endbestand BIGNUMERIC, p_faktor_rest_von_normalbestand BIGNUMERIC, p_nachversorgung_schwellwert_pal_abrundung_proz BIGNUMERIC, p_nachversorgung_schwellwert_pal_aufrundung_proz BIGNUMERIC, OUT return_value STRING)
  BEGIN
    DECLARE dummy_2 FLOAT64;
    DELETE FROM kfl_production_dbp_data.ts_wbs_art_aktion_markt_2 WHERE ts_wbs_art_aktion_markt.mandant_id = p_mandant_id
     AND ts_wbs_art_aktion_markt.dat_von = p_dat_von
     AND ts_wbs_art_aktion_markt.dat_bis = p_dat_bis
     AND ts_wbs_art_aktion_markt.angebot_nr = p_angebot_id
     AND ts_wbs_art_aktion_markt.aktion_id = p_aktion_id
     AND ts_wbs_art_aktion_markt.art_id = p_art_id
     AND ts_wbs_art_aktion_markt.wup_id = p_wup_id
     AND ts_wbs_art_aktion_markt.nb_id = p_nb_id;
    INSERT INTO kfl_production_dbp_data.ts_wbs_art_aktion_markt_2 (mandant_id, wup_id, nb_id, art_id, aktion_id, angebot_nr, dat_von, dat_bis, gk_fg, menge_mindestplatzierung_bme, top_gk_fg, fixmenge_wfl_bme, td_update, td_insert, adjustment_id, max_kapa_fg, dat_letzte_nachversorgung, max_kapa_endbestand_proz, rest_von_normalbestand_proz, nachversorgung_schwellwert_pal_abrundung_proz, nachversorgung_schwellwert_pal_aufrundung_proz)
      SELECT
          CAST(p_mandant_id AS INTEGER),
          CAST(p_wup_id AS INTEGER),
          CAST(p_nb_id AS INTEGER),
          CAST(p_art_id AS INTEGER),
          p_aktion_id,
          p_angebot_id,
          p_dat_von,
          p_dat_bis,
          p_gk_fg,
          p_menge_mindestplatzierung_bme,
          p_top_gk_fg,
          p_fixmenge_wfl_bme,
          CAST(current_date() AS TIMESTAMP),
          CAST(current_date() AS TIMESTAMP),
          p_adjustment_id,
          CAST(p_max_kapa_fg AS INTEGER),
          CAST(p_dat_letzte_nachversorgung AS DATE),
          CAST(p_faktor_max_kapa_endbestand AS INTEGER),
          CAST(p_faktor_rest_von_normalbestand AS NUMERIC),
          CAST(p_nachversorgung_schwellwert_pal_abrundung_proz AS NUMERIC),
          CAST(p_nachversorgung_schwellwert_pal_aufrundung_proz AS NUMERIC)
    ;
    SET return_value = 'Artikel_2 gespeichert';
    RETURN;
  END;
