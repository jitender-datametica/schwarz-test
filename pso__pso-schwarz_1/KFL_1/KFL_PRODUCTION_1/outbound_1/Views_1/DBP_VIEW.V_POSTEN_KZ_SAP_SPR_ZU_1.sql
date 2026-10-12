CREATE OR REPLACE VIEW kfl_production_dbp_view.v_posten_kz_sap_spr_zu_1 AS SELECT mandant_id,
 spr_id,
 posten_kz_sap,
 posten_bez_sap,
 td_update,
 td_insert
FROM kfl_production_dbp_data.posten_kz_sap_spr_zu_1;