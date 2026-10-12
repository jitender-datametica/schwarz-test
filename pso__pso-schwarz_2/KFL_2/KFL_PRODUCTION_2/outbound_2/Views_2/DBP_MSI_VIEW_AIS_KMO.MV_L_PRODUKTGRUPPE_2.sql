CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_produktgruppe_2 (mandant_id, produktgruppe_id,
platzierungswg_id) AS SELECT mandant_id,
 produktgruppe_id,
 platzierungswg_id
FROM kfl_production_dbp_view.v_l_produktgruppe_2
WHERE mandant_id <> 1;