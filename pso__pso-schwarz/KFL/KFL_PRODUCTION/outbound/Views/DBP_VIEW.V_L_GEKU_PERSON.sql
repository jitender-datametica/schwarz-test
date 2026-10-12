CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_person AS SELECT geku_person_id,
 name,
 vorname,
 orga_nr,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_person;