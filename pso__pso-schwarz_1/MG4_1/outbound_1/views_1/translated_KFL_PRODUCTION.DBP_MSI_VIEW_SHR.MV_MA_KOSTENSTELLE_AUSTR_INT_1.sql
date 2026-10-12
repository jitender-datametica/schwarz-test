CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_kostenstelle_austr_int_1 (mandant_id, mitarbeiter_id, kjmo,
kostenstelle_id, austritt_intern) AS -- AND haupt_kst_fg_ = 1
 SELECT v01.mandant_id,
 v01.mitarbeiter_id,
 v01.kjmo,
 v04.kostenstelle_id AS kostenstelle_id_alt,
 1 AS austritt_intern
FROM kfl_production_dbp_view.v_ma_kostenstelle_zu_per_1 AS v01
 INNER JOIN kfl_production_dbp_msi_view_shr.mv_monat_1 AS v03 ON v01.kjmo = v03.kjmo
 INNER JOIN kfl_production_dbp_view.v_ma_kostenstelle_zu_per_1 AS v04 ON v01.mitarbeiter_id = v04.mitarbeiter_id AND v03.kjmo_vm
     = v04.kjmo AND v01.mandant_id = v04.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_mitarbeiterbew_1 AS v99 ON v01.mitarbeiter_id = v99.mitarbeiter_id AND v03.kjmo = v99
    .kjmo AND v01.mandant_id = v99.mandant_id
   -- WHERE SUBSTR(v01.kostenstelle_id,1,4) <> SUBSTR(v04.kostenstelle_id ,1,4)

   -- AND       v04.kostenstelle_id IS NOT NULL

WHERE v99.ma_austritt_kz IN (1, 3)
 AND v99.ma_eintritt_kz = 1
 AND v04.kostenstelle_id IS NOT NULL
GROUP BY v01.mandant_id,
 v01.mitarbeiter_id,
 v01.kjmo,
 kostenstelle_id_alt,
 austritt_intern;