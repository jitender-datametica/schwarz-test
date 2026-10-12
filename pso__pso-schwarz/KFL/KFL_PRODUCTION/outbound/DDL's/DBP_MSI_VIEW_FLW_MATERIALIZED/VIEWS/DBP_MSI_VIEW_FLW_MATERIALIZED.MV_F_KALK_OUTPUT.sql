CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_f_kalk_output (mandant_id, schnittliste_id,
sek_schl_id, sek_schl_typ_id, werk_id, in_art_id, dat_kalk_ab, dat_kalk_bis, kalk_nr, kalk_bez, kalk_kennz, wrg_id_org,
wrg_id, schnitt_id, schnitt_pos_id, menge_schnitt, betrag_schnitt_output, fertig_einzel_kosten_kg,
fertig_einzel_kosten_gesamt, kalk_variante_id) AS SELECT v10.mandant_id,
 v10.schnittliste_id,
 V17.sek_schl_id,
 V17.sek_schl_typ_id,
 v10.werk_id,
 V17.flw_art_id AS in_art_id,
 v10.dat_kalk_ab,
 v10.dat_kalk_bis,
 v10.kalk_nr,
 v10.kalk_bez,
 v10.kalk_kennz,
 v19.wrg_id AS wrg_org,
 v19.wrg_id,
 V17.schnitt_id,
 V17.schnitt_pos_id,
 MAX(V17.menge_schnitt) AS menge_schnitt,
 SUM(CAST(CASE
    WHEN V17.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(V17.betrag_schnitt_output, 0)
    WHEN V17.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(V17.betrag_schnitt_output, 0) / V500.umrechnungskurs
    WHEN V17.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(V17.betrag_schnitt_output, 0) * V500.umrechnungskurs
    WHEN V17.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(V17.betrag_schnitt_output, 0)
    ELSE NULL
    END AS NUMERIC)) AS betrag_schnitt_output,
 SUM(CAST(CASE
    WHEN v19.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(v19.fertig_einzel_kosten_kg, 0)
    WHEN v19.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(v19.fertig_einzel_kosten_kg, 0) / V500.umrechnungskurs
    WHEN v19.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(v19.fertig_einzel_kosten_kg, 0) * V500.umrechnungskurs
    WHEN v19.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(v19.fertig_einzel_kosten_kg, 0)
    ELSE NULL
    END AS NUMERIC)) AS fertig_einzel_kosten_kg,
 SUM(CAST(CASE
    WHEN v19.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(v19.fertig_einzel_kosten_gesamt, 0)
    WHEN v19.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(v19.fertig_einzel_kosten_gesamt, 0) / V500.umrechnungskurs
    WHEN v19.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 0
    THEN COALESCE(v19.fertig_einzel_kosten_gesamt, 0) * V500.umrechnungskurs
    WHEN v19.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 1
    THEN COALESCE(v19.fertig_einzel_kosten_gesamt, 0)
    ELSE NULL
    END AS NUMERIC)) AS fertig_einzel_kosten_gesamt,
 v10.kalk_variante_id
FROM (SELECT V01.mandant_id,
    V01.schnittliste_id,
    V01.werk_id,
    V01.dat_kalk_ab,
    V01.dat_kalk_bis,
    V01.plan_kalk_id AS kalk_nr,
    V02.plan_kalk_bez AS kalk_bez,
    'PK' AS kalk_kennz,
    V01.kalk_variante_id
   FROM kfl_production_dbp_view.v_flw_kalk_plan AS V01
    LEFT JOIN kfl_production_dbp_view.v_flw_kalk_plan_spr_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.plan_kalk_id
       = V02.plan_kalk_id
    INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V03 ON V02.spr_id = V03.spr_id
   UNION ALL
   SELECT V04.mandant_id,
    V04.schnittliste_id,
    V04.werk_id,
    V04.dat_kalk_ab,
    V04.dat_kalk_bis,
    V04.materialwert_kalk_id AS kalk_nr,
    V05.material_kalk_bez AS kalk_bez,
    'MWK' AS kalk_kennz,
    V04.kalk_variante_id
   FROM kfl_production_dbp_view.v_flw_kalk_material AS V04
    LEFT JOIN kfl_production_dbp_view.v_flw_kalk_material_spr_zu AS V05 ON V04.mandant_id = V05.mandant_id AND V04.materialwert_kalk_id
       = V05.materialwert_kalk_id
    INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V06 ON V05.spr_id = V06.spr_id) AS v10
 INNER JOIN kfl_production_dbp_view.v_flw_schnitt_output_det AS V17 ON v10.mandant_id = V17.mandant_id AND v10.kalk_nr =
    V17.sek_schl_id AND V17.sek_schl_typ_id IN ('M', 'P')
 LEFT JOIN (SELECT mandant_id,
   sek_schl_id,
   sek_schl_typ_id,
   schnitt_id,
   schnitt_pos_id,
   MAX(wrg_id) AS wrg_id,
   SUM(fertig_einzel_kosten_kg) AS fertig_einzel_kosten_kg,
   SUM(fertig_einzel_kosten_gesamt) AS fertig_einzel_kosten_gesamt
  FROM kfl_production_dbp_view.v_flw_schnitt_output_kosten
  WHERE sek_schl_typ_id IN ('M', 'P')
  GROUP BY mandant_id,
   sek_schl_id,
   sek_schl_typ_id,
   schnitt_id,
   schnitt_pos_id) AS v19 ON V17.mandant_id = v19.mandant_id AND V17.sek_schl_id = v19.sek_schl_id AND V17.sek_schl_typ_id
      = v19.sek_schl_typ_id AND V17.schnitt_id = v19.schnitt_id AND V17.schnitt_pos_id = v19.schnitt_pos_id
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON v10.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V400 ON v10.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND v19.wrg_id = V500.von_wrg_id
   AND V500.nach_wrg_id = 'EUR' AND v10.dat_kalk_ab BETWEEN V500.dat_von AND V500.dat_bis
GROUP BY v10.mandant_id,
 v10.schnittliste_id,
 V17.sek_schl_id,
 V17.sek_schl_typ_id,
 v10.werk_id,
 in_art_id,
 v10.dat_kalk_ab,
 v10.dat_kalk_bis,
 v10.kalk_nr,
 v10.kalk_bez,
 v10.kalk_kennz,
 wrg_org,
 V400.wrg_id,
 V17.schnitt_id,
 V17.schnitt_pos_id,
 v10.kalk_variante_id;