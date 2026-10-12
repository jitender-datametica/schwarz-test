CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wup_typ_1 (wup_typ_id, wup_typ_bez) AS SELECT wup_typ_id,
 wup_typ_bez
FROM kfl_production_dbp_view.v_wup_typ_1
WHERE wup_typ_id <> 3;