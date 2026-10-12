CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_art_kreistyp_gruppe_wup_zu_2 (mandant_id, wup_id, nb_id, art_id
, kreistyp_gruppe_id) AS SELECT *
FROM kfl_production_dbp_view.v_art_kreistyp_gruppe_wup_zu_2
WHERE nb_id = 0;