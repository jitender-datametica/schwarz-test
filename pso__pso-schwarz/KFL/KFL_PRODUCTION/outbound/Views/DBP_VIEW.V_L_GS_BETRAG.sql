CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_gs_betrag AS SELECT mandant_id,
 ausgeber_typ_id,
 betrag_von,
 betrag_bis,
 wrg_id
FROM kfl_production_dbp_data.l_gs_betrag;