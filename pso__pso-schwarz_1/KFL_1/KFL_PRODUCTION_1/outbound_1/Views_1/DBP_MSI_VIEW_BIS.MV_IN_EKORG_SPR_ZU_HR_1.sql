CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_in_ekorg_spr_zu_hr_1 AS SELECT einkaufsorganisation_id,
 mandant_id,
 einkaufsorganisation_bez
FROM kfl_production_dbp_view.v_in_ekorg_spr_zu_1
WHERE spr_id = 65;