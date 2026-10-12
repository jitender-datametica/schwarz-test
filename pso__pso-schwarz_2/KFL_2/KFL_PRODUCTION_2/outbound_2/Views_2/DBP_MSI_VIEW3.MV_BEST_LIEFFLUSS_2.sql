CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_best_lieffluss_2 (best_beleg_id, best_beleg_pos_id,
best_entw_typ_id, bestaetigung_lfd_nr, lief_beleg_id, lief_beleg_pos_id, kj, kontierung_pos_id, mandant_id, menge,
menge_best, nb_id, vorgart_best_entw_id, wup_id, kj_lief_beleg) AS SELECT V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.best_entw_typ_id,
 V01.bestaetigung_lfd_nr,
 V01.folge_beleg_id AS lief_beleg_id,
 V01.folge_beleg_pos_id AS lief_beleg_pos_id,
 V01.kj,
 V01.kontierung_pos_id,
 V01.mandant_id,
 V01.menge_anteil AS menge,
 V01.menge_best,
 V01.nb_id,
 V01.vorgart_best_entw_id,
 V01.wup_id,
 V02.kj AS kj_lief_beleg
FROM kfl_production_dbp_view.v_best_belegfluss_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_besch_lief_2 AS V02 ON V01.folge_beleg_id = V02.lief_beleg_id AND V01.mandant_id =
    V02.mandant_id AND EXTRACT(YEAR FROM V01.dat_buch) BETWEEN V02.kj - 1 AND (V02.kj + 1)
WHERE V01.best_entw_typ_id IN ('L')
 AND V01.kj >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;