CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_kostenstelle_austr_int_1 (mandant_id, mitarbeiter_id, kjmo,
kostenstelle_id, austritt_intern) AS SELECT V01.mandant_id,
 V01.mitarbeiter_id,
 V01.kjmo,
 V04.kostenstelle_id AS kostenstelle_id_alt,
 1 AS austritt_intern
FROM kfl_production_dbp_view.v_ma_kostenstelle_zu_per_1 AS V01
 INNER JOIN kfl_production_dbp_msi_view_shr.mv_monat_1 AS V03 ON V01.kjmo = V03.kjmo
 INNER JOIN kfl_production_dbp_view.v_ma_kostenstelle_zu_per_1 AS V04 ON V01.mitarbeiter_id = V04.mitarbeiter_id AND V03.kjmo_vm
     = V04.kjmo AND V01.mandant_id = V04.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_mitarbeiterbew_1 AS V99 ON V01.mitarbeiter_id = V99.mitarbeiter_id AND V03.kjmo = V99
    .kjmo AND V01.mandant_id = V99.mandant_id
WHERE V04.kostenstelle_id IS NOT NULL
 AND V99.ma_austritt_kz IN (1, 3)
 AND V99.ma_eintritt_kz = 1
GROUP BY V01.mandant_id,
 V01.mitarbeiter_id,
 V01.kjmo,
 kostenstelle_id_alt,
 austritt_intern;