CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_geku_person_2 (geku_person_id, name, vorname, orga_nr) AS
SELECT geku_person_id,
 name,
 vorname,
 orga_nr
FROM kfl_production_dbp_view.v_l_geku_person_2;