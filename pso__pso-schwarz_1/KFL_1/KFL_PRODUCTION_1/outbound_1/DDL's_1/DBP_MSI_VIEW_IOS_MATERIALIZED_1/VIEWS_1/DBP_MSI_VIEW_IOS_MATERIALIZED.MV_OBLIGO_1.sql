CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_obligo_1 (mandant_id, psp_id, projekt_typ_id, gj, dat_buch,
dat_beleg, ref_beleg_id, ref_beleg_pos_id, in_lief_id, betrag, auftrag_id, dat_von, dat_bis, bestell_text, betrag_plan)
AS SELECT V01.mandant_id,
 V01.psp_id,
 V03.ims_projekt_typ_id AS projekt_typ_id,
 V01.gj,
 V01.dat_buch,
 V01.dat_beleg,
 V01.ref_beleg_id,
 V01.ref_beleg_pos_id,
 COALESCE(V01.in_lief_id, -1) AS in_lief_id,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.betrag
  ELSE V01.betrag * V500.umrechnungskurs
  END AS betrag,
 V01.auftrag_id,
 V01.dat_von,
 V01.dat_bis,
 V01.bestell_text,
 V01.betrag_plan
FROM kfl_production_dbp_view.v_obligo_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_psp_element_1 AS V02 ON V01.psp_id = V02.psp_id AND V01.mandant_id = V02.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_in_projekt_1 AS V03 ON V02.in_projekt_id = V03.in_projekt_id AND V02.mandant_id =
   V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V500.dat_bis = DATE '9999-12-31';