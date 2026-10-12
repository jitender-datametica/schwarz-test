CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_mietvertrag_flaeche_zu_per_1 AS
SELECT
  amvf.mandant_id AS mandant_id,
  amvf.mietvertrag_id_hilfe AS mietvertrag_id_hilfe,
  amvf.mietvertrag_id AS mietvertrag_id,
  amvf.flaeche_id AS flaeche_id,
  amvf.dat_von AS dat_von,
  amvf.dat_bis AS dat_bis,
  amvf.dat_flaeche_uebergabe AS dat_flaeche_uebergabe,
  amvf.dat_flaeche_rueckgabe AS dat_flaeche_rueckgabe,
  amvf.vertrag_aktiv_fg AS vertrag_aktiv_fg,
  amvf.immo_objekt_id AS immo_objekt_id,
  amvf.flaeche_typ_id AS flaeche_typ_id,
  amvf.branche_id AS branche_id,
  amvf.miete_umsatz_prozent AS miete_umsatz_prozent,
  amvf.miete_referenz_id AS miete_referenz_id,
  amvf.mietart_id AS mietart_id,
  amvf.dat_frei_flaeche_seit AS dat_frei_flaeche_seit,
  CASE
    WHEN CURRENT_DATE >= amvf.dat_frei_flaeche_seit
    THEN DATE_DIFF(CURRENT_DATE, amvf.dat_frei_flaeche_seit, DAY)
    ELSE NULL
  END AS flaeche_frei_seit_tagen,
  amvf.miete_betrag * kurs.kurs_1 AS miete_betrag,
  amvf.nebenkosten_betrag * kurs.kurs_1 AS nebenkosten_betrag,
  amvf.nebenkosten_abschlag * kurs.kurs_1 AS nebenkosten_abschlag,
  amvf.miete_umsatz_abschlag * kurs.kurs_1 AS miete_umsatz_abschlag,
  amvf.investmiete_betrag * kurs.kurs_1 AS investmiete_betrag,
  amvf.sonst_betrag * kurs.kurs_1 AS sonst_betrag,
  amvf.immo_verw_betrag * kurs.kurs_1 AS immo_verw_betrag,
  kurs.wrg_id AS wrg_id,
  kurs.wrg_typ_id AS wrg_typ_id,
  amvf.flaeche_status_id AS flaeche_status_id
FROM kfl_production_dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi_1 AS amvf
INNER JOIN kfl_production_dbp_msi_view_immo.mv_mand_wrg_kurs_zu_per_1 AS kurs_1
  ON amvf.mandant_id = kurs.mandant_id
  AND CURRENT_DATE BETWEEN kurs.kurs_dat_von AND kurs.kurs_dat_bis;
