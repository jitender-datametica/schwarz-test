CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_IVS_MIETVERTRAG_FLAECHE_Z_P_2 as
   -- 2009-06-15
   -- FAKTVIEW auf Basis msi_data (Akt. Datenstand)
   -- Mietvertrags-Flaechendaten
   -- 2012KW25 : Initial von IVS nach VIS übernommen, ohne Währungsumrechnung
   -- 2013KW10 Erweiterung Kurs_2/Waehrungsumrechnung

   SELECT
   amvf.mandant_id, amvf.mietvertrag_id_hilfe, amvf.mietvertrag_id, amvf.flaeche_id, amvf.flaeche_status_id, amvf.dat_von, amvf.dat_bis, amvf.dat_flaeche_uebergabe, amvf.dat_flaeche_rueckgabe, amvf.vertrag_aktiv_fg, amvf.immo_objekt_id, amvf.flaeche_typ_id, amvf.branche_id, amvf.miete_umsatz_prozent, amvf.miete_referenz_id, amvf.mietart_id, amvf.dat_frei_flaeche_seit, CASE WHEN CURRENT_DATE >= amvf.dat_frei_flaeche_seit THEN CURRENT_DATE - amvf.dat_frei_flaeche_seit
   END AS flaeche_frei_seit_tagen, amvf.miete_betrag * kurs_2          AS miete_betrag, amvf.nebenkosten_betrag * kurs_2    AS nebenkosten_betrag, amvf.nebenkosten_abschlag * kurs_2  AS nebenkosten_abschlag, amvf.miete_umsatz_abschlag * kurs_2 AS miete_umsatz_abschlag, amvf.investmiete_betrag * kurs_2    AS investmiete_betrag, amvf.sonst_betrag * kurs_2          AS sonst_betrag, amvf.immo_verw_betrag * kurs_2      AS immo_verw_betrag, kurs.wrg_id
   FROM dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi_2  amvf
   INNER JOIN dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per_2  kurs_2
   ON kurs.mandant_id = amvf.mandant_id
   ;