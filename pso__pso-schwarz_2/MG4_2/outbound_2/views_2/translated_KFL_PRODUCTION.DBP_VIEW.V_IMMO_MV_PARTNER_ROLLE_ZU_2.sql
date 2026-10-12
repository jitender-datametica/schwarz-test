CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_mv_partner_rolle_zu_2 (mandant_id, mv_intreno, rolle_kz, partner_id
, td_update, td_insert) AS SELECT mandant_id,
 mv_intreno,
 rolle_kz,
 partner_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.immo_mv_partner_rolle_zu_2;