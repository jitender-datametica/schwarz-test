CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_kostenrechnung_2 (buchungskreis_id_ker, buchungsperiode_id, gj
, kjmo, kostenart_id, krk_id, mandant_id, pc_id, plan_fg, planvariante_id, kostenrechnung_betrag_org,
kostenrechnung_betrag, wrg_id_orig, wrg_id) AS SELECT V01.buchungskreis_id_ker,
 V01.buchungsperiode_id,
 V01.gj,
 V01.kjmo,
 V01.kostenart_id,
 V01.krk_id,
 V01.mandant_id,
 V01.pc_id,
 V01.plan_fg,
 V01.planvariante_id,
 V01.kostenrechnung_betrag_org,
 CAST(CASE
   WHEN V01.wrg_id_orig <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.kostenrechnung_betrag_org, 0)
   WHEN V01.wrg_id_orig <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.kostenrechnung_betrag_org, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id_orig = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.kostenrechnung_betrag_org, 0) * V500.umrechnungskurs
   WHEN V01.wrg_id_orig = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.kostenrechnung_betrag_org, 0)
   ELSE NULL
   END AS NUMERIC) AS kostenrechnung_betrag,
 V01.wrg_id_orig,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_kostenrechnung_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id_orig = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.max_dat BETWEEN V500.dat_von AND V500.dat_bis;