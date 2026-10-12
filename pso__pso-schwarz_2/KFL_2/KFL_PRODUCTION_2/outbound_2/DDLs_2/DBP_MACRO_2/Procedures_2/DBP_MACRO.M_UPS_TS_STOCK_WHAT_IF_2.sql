CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_stock_what_if(p_art_id FLOAT64, p_wup_id FLOAT64, p_nb_id FLOAT64, p_mandant_id FLOAT64, p_dat_von DATE, p_dat_bis DATE, p_order_proposal FLOAT64, p_order_proposal_wi FLOAT64, p_confirm_fg FLOAT64, OUT return_value STRING)
  BEGIN
    DECLARE dummy_2 FLOAT64;
    DELETE FROM kfl_production_dbp_msi_data.ts_wbs_bestellvorschlag_in_promo_2 WHERE ts_wbs_bestellvorschlag_in_promo.art_id = p_art_id
     AND ts_wbs_bestellvorschlag_in_promo.wup_id = p_wup_id
     AND ts_wbs_bestellvorschlag_in_promo.nb_id = p_nb_id
     AND ts_wbs_bestellvorschlag_in_promo.mandant_id = p_mandant_id
     AND ts_wbs_bestellvorschlag_in_promo.dat_aktion_von = p_dat_von
     AND ts_wbs_bestellvorschlag_in_promo.dat_aktion_bis = p_dat_bis;
    INSERT INTO kfl_production_dbp_msi_data.ts_wbs_bestellvorschlag_in_promo_2 (art_id, wup_id, nb_id, mandant_id, dat_aktion_von, dat_aktion_bis, menge_bestellvorschlag_in_promo_ame, td_insert, td_update)
      SELECT
          CAST(p_art_id AS INTEGER),
          CAST(p_wup_id AS INTEGER),
          CAST(p_nb_id AS INTEGER),
          CAST(p_mandant_id AS INTEGER),
          p_dat_von,
          p_dat_bis,
          CAST(CASE
            WHEN p_confirm_fg = NUMERIC '1' THEN p_order_proposal_wi
            ELSE p_order_proposal
          END AS NUMERIC),
          current_timestamp(),
          current_timestamp()
    ;
    SET return_value = 'Artikel_2 gespeichert';
    RETURN;
  END;
