CREATE OR REPLACE VIEW kfl_production_dbp_view.v_it_projekt_plan_det AS SELECT it_projekt_id,
 plan_revision_id,
 berichts_position_it_id,
 gj,
 sparte_id,
 plan_betrag,
 plan_betrag_betrieb,
 ahk_aufwand_kz,
 ahk_euro,
 ahk_quote,
 aufwand_euro
FROM kfl_production_dbp_data.it_projekt_plan_det;