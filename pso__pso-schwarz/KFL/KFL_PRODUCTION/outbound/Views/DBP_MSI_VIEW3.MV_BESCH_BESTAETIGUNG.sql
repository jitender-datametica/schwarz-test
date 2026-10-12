CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_besch_bestaetigung (best_beleg_id, ext_beleg_id,
best_beleg_pos_id, bestaetigung_lfd_nr, bestaetigung_typ_id, dat_bestaetigung, dat_lief_plan, lief_beleg_id,
lief_beleg_pos_id, mandant_id, menge_bestaetigung, menge_dispo, zeit_bestaetigung, zeit_lief_plan, kj_lief_beleg) AS
SELECT best_beleg_id,
 ext_beleg_id,
 best_beleg_pos_id,
 bestaetigung_lfd_nr,
 bestaetigung_typ_id,
 dat_bestaetigung,
 dat_lief_plan,
 lief_beleg_id,
 lief_beleg_pos_id,
 mandant_id,
 menge_bestaetigung,
 menge_dispo,
 zeit_bestaetigung,
 zeit_lief_plan,
 kj_lief_beleg
FROM kfl_production_dbp_view.v_besch_bestaetigung
WHERE EXTRACT(YEAR FROM dat_bestaetigung) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;