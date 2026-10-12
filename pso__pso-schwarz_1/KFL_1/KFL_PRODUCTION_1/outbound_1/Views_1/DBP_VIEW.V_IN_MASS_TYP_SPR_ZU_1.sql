CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_mass_typ_spr_zu_1 AS SELECT in_massnahme_typ_id,
 spr_id,
 in_massnahme_typ_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_mass_typ_spr_zu_1;