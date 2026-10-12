CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mo_nutzung_spr_zu AS SELECT mandant_id,
 mo_nutzung_id,
 spr_id,
 mo_nutzung_bez
FROM kfl_production_dbp_data.immo_mo_nutzung_spr_zu;