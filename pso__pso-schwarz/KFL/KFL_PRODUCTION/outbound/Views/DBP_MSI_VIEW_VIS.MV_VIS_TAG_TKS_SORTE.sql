CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_tks_sorte (mandant_id, wup_id, nb_id, dat,
tks_sorte_id, tks_sorte_bez, ums_netto, ums_brutto, menge_liter, anz_kunde, wrg_id) AS SELECT V01.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.dat,
 V01.tks_sorte_id,
 V01.tks_sorte_bez,
 V01.ums_netto,
 V01.ums_brutto,
 V01.menge_liter,
 V01.anz_kunde,
 V01.wrg_id
FROM kfl_production_dbp_view.v_vis_tag_tks_sorte AS V01
 INNER JOIN kfl_production_dbp_data.wup AS WUP ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id
WHERE V01.mandant_id = 1;