CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_coi_ump_umsatzplan_massnahmen_zu (mandant_id, gj_plan,
version_id, wup_id, nb_id, dat_plan, arthiertyp_id, hwg_id, massnahme_art_id, massnahme_typ_bez, massnahme_id,
massnahme_art_bez, massnahme_auswirkung_bez, faktor, wert_massnahme, betriebsunterbrechung_fg) AS SELECT V01.mandant_id
 ,
 V01.gj_plan,
 V01.version_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat_plan,
 V01.arthiertyp_id,
 V01.hwg_id,
 V01.massnahme_art_id,
 V01.massnahme_typ_bez,
 V01.massnahme_id,
 V01.massnahme_art_bez,
 V01.massnahme_auswirkung_bez,
 V01.faktor,
  CASE
  WHEN V01.wert IS NULL
  THEN V01.faktor * V03.umsatz_netto_basis_3
  ELSE V01.wert
  END AS wert_massnahme,
 COALESCE(V02.betriebsunterbrechung_fg, 0) AS betriebsunterbrechung_fg
FROM kfl_production_dbp_view.v_coi_ump_umsatzplan_massnahmen_zu AS V01
 LEFT JOIN kfl_production_dbp_view.v_coi_ump_wup_immo_massnahme_per AS V02 ON V01.mandant_id = V02.mandant_id AND V01.gj_plan
      = V02.gj_plan AND V01.version_id = V02.version_id AND V01.massnahme_id = V02.massnahme_id
 INNER JOIN kfl_production_dbp_view.v_coi_ump_umsatzplan_hwg AS V03 ON V01.mandant_id = V03.mandant_id AND V01.gj_plan =
        V03.gj_plan AND V01.version_id = V03.version_id AND V01.dat_plan = V03.dat_plan AND V01.wup_id = V03.wup_id AND
    V01.nb_id = V03.nb_id AND V01.hwg_id = V03.hwg_id;