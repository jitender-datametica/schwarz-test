CREATE OR REPLACE VIEW kfl_production_dbp_view.v_buchungskreis_spr_zu_2 (mandant_id, buchungskreis_id, spr_id, system_id,
buchungskreis_bez, strasse, plz, ort, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_data.buchungskreis_spr_zu_2;