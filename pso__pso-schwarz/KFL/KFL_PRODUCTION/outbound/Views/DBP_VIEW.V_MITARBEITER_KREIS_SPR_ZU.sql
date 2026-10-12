CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mitarbeiter_kreis_spr_zu AS SELECT mandant_id,
 mitarbeiter_kreis_id,
 spr_id,
 mitarbeiterkreis_bez
FROM kfl_production_dbp_data.mitarbeiter_kreis_spr_zu;