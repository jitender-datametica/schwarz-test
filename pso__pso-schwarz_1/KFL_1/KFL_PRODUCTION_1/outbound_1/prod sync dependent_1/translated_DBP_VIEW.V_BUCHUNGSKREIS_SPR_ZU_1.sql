CREATE OR REPLACE VIEW kfl_production_dbp_view.v_buchungskreis_spr_zu_1 (mandant_id, buchungskreis_id, spr_id, system_id,
buchungskreis_bez, strasse, plz, ort, td_update, td_insert) AS SELECT mandant_id,
 buchungskreis_id,
 spr_id,
 system_id,
 buchungskreis_bez,
 strasse,
 plz,
 ort,
 td_update,
 td_insert
FROM kfl_production_dbp_data.buchungskreis_spr_zu_1;