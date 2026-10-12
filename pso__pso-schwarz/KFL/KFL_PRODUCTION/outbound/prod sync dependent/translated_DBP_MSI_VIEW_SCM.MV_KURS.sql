-- 20220804: AP0132142 SPEC0154921, richternic, Fuer die Waehrungsauswahl

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_kurs (dat_bis, dat_von, kurstyp_id, nach_wrg_id,
umrechnungskurs, von_wrg_id) AS SELECT dat_bis,
 dat_von,
 kurstyp_id,
 nach_wrg_id,
 umrechnungskurs,
 von_wrg_id
FROM kfl_production_dbp_view.v_kurs
WHERE dat_bis = DATE '9999-12-31'
 AND kurstyp_id = 3;