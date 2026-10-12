CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_art_monat_vw_plan_1 (mandant_id, in_art_id, werk_id, gjmo
, in_vw_id, wa_betrag_org, wa_menge_kg, wa_menge_bme, wa_betrag, wrg_id_orig) AS SELECT V01.mandant_id,
 V01.in_art_id,
 V01.werk_id,
 V01.gjmo,
 V01.in_vw_id,
 V01.wa_menge_kg AS wa_betrag_org,
 V01.wa_menge_bme AS wa_menge_kg,
 V01.wa_betrag_org AS wa_betrag_org0,
 CAST(CASE
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V01.wa_betrag_org
   WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
   THEN V01.wa_betrag_org / V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
   THEN V01.wa_betrag_org * V500.umrechnungskurs
   WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
   THEN V01.wa_betrag_org
   ELSE NULL
   END AS NUMERIC) AS wa_betrag,
 V01.wrg_id AS wrg_id_orig
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_art_monat_vw_plan_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_1 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_1 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
   AND V500.nach_wrg_id = 'EUR' AND V01.max_dat BETWEEN V500.dat_von AND V500.dat_bis;