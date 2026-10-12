CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_l_betrag AS SELECT mandant_id,
 ausgeber_typ_id,
 betrag_von,
 betrag_bis
FROM kfl_production_dbp_view.v_l_gs_betrag AS V01;