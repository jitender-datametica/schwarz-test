CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_ekorg_2 (einkaufsorganisation_id, mandant_id,
buchungskreis_id) AS SELECT einkaufsorganisation_id,
 mandant_id,
 buchungskreis_id
FROM kfl_production_dbp_view.v_in_l_ekorg_2
WHERE sako_fg = 1;