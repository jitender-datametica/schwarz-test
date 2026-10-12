CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_mass_typ AS SELECT in_massnahme_typ_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_l_mass_typ;