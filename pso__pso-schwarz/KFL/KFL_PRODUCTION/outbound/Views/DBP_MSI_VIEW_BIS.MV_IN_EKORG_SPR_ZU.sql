CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_in_ekorg_spr_zu AS SELECT V01.einkaufsorganisation_id,
 V01.mandant_id,
 V01.einkaufsorganisation_bez
FROM kfl_production_dbp_view.v_in_ekorg_spr_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_in_l_ekorg AS V02 ON V01.mandant_id = V02.mandant_id AND V01.einkaufsorganisation_id
     = V02.einkaufsorganisation_id AND V02.sako_fg = 1
WHERE V01.spr_id = 22;