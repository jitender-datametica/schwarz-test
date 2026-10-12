CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_zahlungsmittel_spr_zu_2 AS SELECT zahlungsmittel_id,
 mandant_id,
 spr_id,
 zahlungsmittel_bez
FROM kfl_production_dbp_ods.zahlungsmittel_spr_zu_2;