CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_kurstyp AS SELECT kurstyp_id,
 sap_kurstyp_id
FROM kfl_production_dbp_data.l_kurstyp;