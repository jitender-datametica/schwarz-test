CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fipo_person_2 AS SELECT fipo_person_id,
 mandant_id,
 fipo_pos_id,
 rev_fb_id,
 fipo_person_name,
 fipo_person_vorname,
 fipo_person_anrede,
 dat_bis,
 fipo_person_organisation
FROM kfl_production_dbp_data.fipo_person_2;