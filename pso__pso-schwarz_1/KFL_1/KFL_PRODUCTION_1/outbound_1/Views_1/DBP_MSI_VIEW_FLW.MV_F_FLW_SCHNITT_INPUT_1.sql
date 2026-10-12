CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_schnitt_input_1 (mandant_id, schnitt_id, sek_schl_typ_id,
sek_schl_id, in_art_id, werk_id, dat_von, dat_bis, material_einzel_kosten, wrg_id) AS SELECT V01.mandant_id,
 V01.schnitt_id,
 V01.sek_schl_typ_id,
 V01.sek_schl_id,
 V01.in_art_id,
 V01.werk_id,
 V01.dat_von,
 V01.dat_bis,
 CAST(CASE
   WHEN V01.wrg_id_v01 <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.material_einzel_kosten, 0)
   WHEN V01.wrg_id_v01 <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.material_einzel_kosten, 0) / V500.umrechnungskurs
   WHEN V01.wrg_id_v01 = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.material_einzel_kosten, 0) * V500.umrechnungskurs
   WHEN V01.wrg_id_v01 = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.material_einzel_kosten, 0)
   ELSE NULL
   END AS NUMERIC) AS material_einzel_kosten,
 V400.wrg_id
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_schnitt_input_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id_v01 = V500.von_wrg_id
     AND V01.dat_von BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V01.sek_schl_typ_id IN ('M', 'P');