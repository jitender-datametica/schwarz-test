CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_we_partner_rolle_zu_per_2 AS SELECT mandant_id,
 we_intreno,
 rolle_kz,
 dat_von,
 dat_bis,
 partner_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_we_partner_rolle_zu_per_2;