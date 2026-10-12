CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_rohertrag_plan_ist_1 (mandant_id, in_art_id, gjmo, plan_fg
, werk_id, rohertrag_betrag_org, rohertrag_betrag, wrg_id_org) AS SELECT V01.mandant_id,
 V01.in_art_id,
 V01.gjmo,
 V01.plan_fg,
 V01.werk_id,
 V01.rohertrag_betrag_org,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V01.rohertrag_betrag_org
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN V01.rohertrag_betrag_org / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V01.rohertrag_betrag_org * V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN V01.rohertrag_betrag_org
   ELSE NULL
   END AS NUMERIC) AS rohertrag_betrag,
 V01.wrg_id AS wrg_id_org
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_rohertrag_plan_ist_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
   AND V500.nach_wrg_id = 'EUR' AND V01.max_dat BETWEEN V500.dat_von AND V500.dat_bis;