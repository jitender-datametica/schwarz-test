CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ivs_mietvertrag_flaeche_z_p_1 AS SELECT AMVF.mandant_id,
 AMVF.mietvertrag_id_hilfe,
 AMVF.mietvertrag_id,
 AMVF.flaeche_id,
 AMVF.flaeche_status_id,
 AMVF.dat_von,
 AMVF.dat_bis,
 AMVF.dat_flaeche_uebergabe,
 AMVF.dat_flaeche_rueckgabe,
 AMVF.vertrag_aktiv_fg,
 AMVF.immo_objekt_id,
 AMVF.flaeche_typ_id,
 AMVF.branche_id,
 AMVF.miete_umsatz_prozent,
 AMVF.miete_referenz_id,
 AMVF.mietart_id,
 AMVF.dat_frei_flaeche_seit,
  CASE
  WHEN CURRENT_DATE >= AMVF.dat_frei_flaeche_seit
  THEN DATE_DIFF(CURRENT_DATE, AMVF.dat_frei_flaeche_seit, DAY)
  ELSE NULL
  END AS flaeche_frei_seit_tagen,
  AMVF.miete_betrag * KURS.kurs_1 AS miete_betrag,
  AMVF.nebenkosten_betrag * KURS.kurs_1 AS nebenkosten_betrag,
  AMVF.nebenkosten_abschlag * KURS.kurs_1 AS nebenkosten_abschlag,
  AMVF.miete_umsatz_abschlag * KURS.kurs_1 AS miete_umsatz_abschlag,
  AMVF.investmiete_betrag * KURS.kurs_1 AS investmiete_betrag,
  AMVF.sonst_betrag * KURS.kurs_1 AS sonst_betrag,
  AMVF.immo_verw_betrag * KURS.kurs_1 AS immo_verw_betrag,
 KURS.wrg_id
FROM kfl_production_dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi_1 AS AMVF
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per_1 AS KURS_1 ON AMVF.mandant_id = KURS.mandant_id;