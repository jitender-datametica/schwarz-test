CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_kalk_preise (umrechnungsfaktor, mandant_id,
schnittliste_id, sek_schl_typ_id, sek_schl_id, in_art_id, input_material_typ_id, menge, gesamt_wert, menge_dme,
dme_einh_id, wrg_id, preis_kg) AS SELECT CASE
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
  THEN 1
  WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
  THEN 1 / V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
  THEN V500.umrechnungskurs
  WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
  THEN 1
  ELSE NULL
  END AS umrechnungsfaktor,
 V01.mandant_id,
 V01.schnittliste_id,
 V01.sek_schl_typ_id,
 V01.sek_schl_id,
 V01.in_art_id,
 V01.input_material_typ_id,
 V01.menge,
 CAST(V01.gesamt_wert * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS gesamt_wert,
 V01.menge_dme,
 V01.dme_einh_id,
 V01.wrg_id,
 CAST(COALESCE(V01.preis_kg, 0) * CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN 1
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1 / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN 1
    ELSE NULL
    END AS NUMERIC) AS preis_kg
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_kalk_preise AS V01
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