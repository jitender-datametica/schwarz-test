CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_BRANCHE_VORGABE_2 as
   -- 2009-06-15
   -- LOOKUP branche_vorgabe (akt. Kalenderjahr)
   -- Vorgabewerte aus WSA (mandant_2, branche, miet_region, flaeche, kunden, kl_baecker)
   -- 2009KW17 Erweiterung; EUR + LW über waehrungstyp
   -- 2009KW27 Historisierung Kurs_2
   -- 2009KW47 Umstellung mv_zeit_2 auf v_monat_2
   -- 2010KW28 Erweiterung durch bl_id für Branchen Vorgaben auf Bundesland Ebene
   -- 2014-02-07 Bugfix Waehrung/Zeitabhaengigkeit

   SELECT
   bv.mandant_id,
   bv.miet_region_id,
   bv.bl_id,
   bv.branche_id,
   bv.konzessionaer_id /* immer 0 */,
   bv.kaufland_baecker_fg,
   bv.flaeche_groesse_von,
   bv.flaeche_groesse_bis,
   bv.kunden_anzahl_von,
   bv.kunden_anzahl_bis,
   bv.branche_mix,
   bv.vorgabe_prozent,
   bv.vorgabe_betrag * kurs_2  vorgabe_betrag,
   bv.vorgabe_prodvt * kurs_2  vorgabe_prodvt,
   bv.vorgabe_miete  * kurs_2  vorgabe_miete,
   bv.vorgabe_achsen_abschnitt,
   bv.vorgabe_steigung,
   kurs.wrg_id,
   kurs.wrg_typ_id
  FROM dbp_view.v_ivs_branche_vorgabe_2  bv
   INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2  kurs_2
   ON kurs.mandant_id = bv.mandant_id
   AND kurs_dat_bis = '9999-12-31'
;