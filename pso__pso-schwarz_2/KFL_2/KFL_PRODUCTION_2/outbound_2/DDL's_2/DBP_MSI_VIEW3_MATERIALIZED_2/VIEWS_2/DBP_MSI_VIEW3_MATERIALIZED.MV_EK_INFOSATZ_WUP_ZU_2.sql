CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_ek_infosatz_wup_zu_2 (mandant_id, ek_infosatz_id,
wup_id, nb_id, prozent_akzeptanz_unterlief) AS SELECT mandant_id,
 ek_infosatz_id,
 wup_id,
 nb_id,
 prozent_akzeptanz_unterlief
FROM kfl_production_dbp_view.v_ek_infosatz_wup_zu_2;