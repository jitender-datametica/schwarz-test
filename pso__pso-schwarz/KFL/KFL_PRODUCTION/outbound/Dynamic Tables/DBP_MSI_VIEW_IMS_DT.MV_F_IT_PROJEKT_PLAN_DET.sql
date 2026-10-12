CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ims_dt.mv_f_it_projekt_plan_det
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  plan_revision_id AS plan_version_id,
  it_projekt_id AS it_projekt_id,
  sparte_id AS sparte_id,
  gj AS gj,
  berichts_position_it_id AS berichts_position_it_id,
  plan_betrag AS plan_betrag,
  plan_betrag_betrieb AS plan_betrag_betrieb,
  aufwand_euro AS plan_aufwand_betrag,
  ahk_euro AS plan_ahk_betrag
FROM kfl_production_dbp_view.v_it_projekt_plan_det AS v01;
