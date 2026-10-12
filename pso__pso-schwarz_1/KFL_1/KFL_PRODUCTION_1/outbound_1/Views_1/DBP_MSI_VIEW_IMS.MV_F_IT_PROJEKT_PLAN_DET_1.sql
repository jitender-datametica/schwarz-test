CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_f_it_projekt_plan_det_1 AS SELECT plan_revision_id AS
 plan_version_id,
 it_projekt_id,
 sparte_id,
 gj,
 berichts_position_it_id,
 plan_betrag,
 plan_betrag_betrieb,
 aufwand_euro AS plan_aufwand_betrag,
 ahk_euro AS plan_ahk_betrag
FROM kfl_production_dbp_view.v_it_projekt_plan_det_1 AS V01;