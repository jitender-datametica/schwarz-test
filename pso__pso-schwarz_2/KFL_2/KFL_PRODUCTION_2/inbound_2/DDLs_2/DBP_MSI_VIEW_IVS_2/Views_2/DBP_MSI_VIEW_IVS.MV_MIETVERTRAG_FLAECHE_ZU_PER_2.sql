CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MIETVERTRAG_FLAECHE_ZU_PER_2 as
   SELECT
   amvf.mandant_id,
   amvf.mietvertrag_id_hilfe,
   amvf.mietvertrag_id,
   amvf.flaeche_id,
   amvf.dat_von,
   amvf.dat_bis,
   amvf.dat_flaeche_uebergabe,
   amvf.dat_flaeche_rueckgabe,
   amvf.vertrag_aktiv_fg,
   amvf.immo_objekt_id,
   amvf.flaeche_typ_id,
   amvf.branche_id,
   amvf.miete_umsatz_prozent,
   amvf.miete_referenz_id,
   amvf.mietart_id,
   amvf.dat_frei_flaeche_seit,
   CASE WHEN CURRENT_DATE >= amvf.dat_frei_flaeche_seit
   THEN CURRENT_DATE - amvf.dat_frei_flaeche_seit
   END flaeche_frei_seit_tagen,
   amvf.miete_betrag          * kurs_2 miete_betrag,
   amvf.nebenkosten_betrag    * kurs_2 nebenkosten_betrag,
   amvf.nebenkosten_abschlag  * kurs_2 nebenkosten_abschlag,
   amvf.miete_umsatz_abschlag * kurs_2 miete_umsatz_abschlag,
   amvf.investmiete_betrag    * kurs_2 investmiete_betrag,
   amvf.sonst_betrag          * kurs_2 sonst_betrag,
   amvf.immo_verw_betrag      * kurs_2 immo_verw_betrag,
   kurs.wrg_id,
   kurs.wrg_typ_id,
   amvf.flaeche_status_id
  FROM dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi_2 amvf
   INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2  kurs_2
   ON kurs.mandant_id = amvf.mandant_id
   AND CURRENT_DATE BETWEEN kurs_dat_von AND kurs_dat_bis
;