CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_in_ekorg_spr_zu_ro_2 AS SELECT einkaufsorganisation_id,
 mandant_id,
 einkaufsorganisation_bez
FROM kfl_production_dbp_view.v_in_ekorg_spr_zu_2
WHERE spr_id = 95;