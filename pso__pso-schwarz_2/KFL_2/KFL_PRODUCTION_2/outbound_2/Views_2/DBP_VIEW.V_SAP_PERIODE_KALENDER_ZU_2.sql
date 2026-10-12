CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sap_periode_kalender_zu_2 AS SELECT mandant_id,
 krk_id,
 buchungsperiode_id,
 sap_buchungs_jahr,
 kjmo
FROM kfl_production_dbp_data.sap_periode_kalender_zu_2;