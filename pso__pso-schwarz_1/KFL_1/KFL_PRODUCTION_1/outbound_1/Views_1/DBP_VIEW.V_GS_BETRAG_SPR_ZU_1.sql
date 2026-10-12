CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gs_betrag_spr_zu_1 AS SELECT mandant_id,
 ausgeber_typ_id,
 spr_id,
 betrag_von,
 betrag_bez
FROM kfl_production_dbp_data.gs_betrag_spr_zu_1;