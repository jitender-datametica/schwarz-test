CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BESCH_BEST
       (
       mandant_id
       ,best_beleg_id
       ,gp_id
       ,dat_best_beleg
       ,bestellart_id
       ,best_beleg_status_id
       ,loesch_fg
       ,nachbest_fg
       ,einkaufsorganisation_id
       ,dat_aenderung
       ,kunde_id
       ,wup_id
       ,nb_id
       ,system_id
       ,kj
       ,submi_id
       ,ref_beleg_id_intern
       )
       AS
          SELECT
          mandant_id,
          best_beleg_id,
          gp_id,
          dat_best_beleg,
          bestellart_id,
          best_beleg_status_id,
          loesch_fg,
          nachbest_fg,
          einkaufsorganisation_id,
          dat_aenderung,
          kunde_id,
          wup_id,
          nb_id,
          7,
          EXTRACT(YEAR FROM dat_best_beleg),
          submi_id,
          ref_beleg_id_intern
          FROM dbp_view.v_besch_best
          WHERE mandant_id = 1
          and einkaufsorganisation_id <> 5000;