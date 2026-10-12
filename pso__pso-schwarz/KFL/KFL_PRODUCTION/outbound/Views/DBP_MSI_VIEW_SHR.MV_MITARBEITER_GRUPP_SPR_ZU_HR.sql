CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_mitarbeiter_grupp_spr_zu_hr (mandant_id, mitarbeiter_gruppe_id
, mitarbeiter_gruppe_bez) AS SELECT mandant_id,
 mitarbeiter_gruppe_id,
 mitarbeiter_gruppe_bez
FROM kfl_production_dbp_view.v_mitarbeiter_gruppe_spr_zu AS V01
WHERE spr_id = 65;