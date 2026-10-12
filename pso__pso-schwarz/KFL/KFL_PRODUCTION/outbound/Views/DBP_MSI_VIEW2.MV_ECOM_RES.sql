CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_ecom_res (art_id, mandant_id, wup_id, nb_id, dat_von, dat_bis,
aktion_id, bewart_id, reservierbar_fg) AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat_von,
 dat_bis,
 aktion_id,
 bewart_id,
 1 AS reservierbar_fg
FROM kfl_production_dbp_view.v_ecom_res
WHERE mandant_id = 1;