CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_jahr_inventur_diff_2 AS SELECT mandant_id,
 wup_id,
 gj,
 umsatz_brutto_inventur,
 betrag_inventur_differenz,
 wrg_id
FROM kfl_production_dbp_data.vis_jahr_inventur_diff_2;