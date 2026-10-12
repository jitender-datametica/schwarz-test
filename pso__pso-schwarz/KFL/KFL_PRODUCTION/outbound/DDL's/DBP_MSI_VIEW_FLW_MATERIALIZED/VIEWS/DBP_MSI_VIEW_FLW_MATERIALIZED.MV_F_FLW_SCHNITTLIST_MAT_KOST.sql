CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_flw_schnittlist_mat_kost (mandant_id,
schnittliste_id, sek_schl_typ_id, sek_schl_id, in_art_id, input_material_typ_id, kosten_block_id, intern_var_kosten,
wrg_id) AS SELECT V01.mandant_id,
 V01.schnittliste_id,
 V01.sek_schl_typ_id,
 V01.sek_schl_id,
 V01.in_art_id,
 V01.input_material_typ_id,
 V01.kosten_block_id,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.intern_var_kosten, 0)
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.intern_var_kosten, 0) / CAST(V500.umrechnungskurs AS NUMERIC)
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V01.intern_var_kosten, 0) * CAST(V500.umrechnungskurs AS NUMERIC)
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V01.intern_var_kosten, 0)
   ELSE NULL
   END AS NUMERIC) AS intern_var_kosten,
 V01.wrg_id
FROM kfl_production_dbp_msi_view_flw_materialized.tbl_mv_f_flw_schnittlist_mat_kost AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
   AND V500.nach_wrg_id = 'EUR' AND CASE
    WHEN V01.sek_schl_typ_id = 'M'
    THEN V01.dat_kalk_ab_v02
    WHEN V01.sek_schl_typ_id = 'P'
    THEN V01.dat_kalk_ab_v03
    ELSE NULL
    END BETWEEN V500.dat_von AND V500.dat_bis;