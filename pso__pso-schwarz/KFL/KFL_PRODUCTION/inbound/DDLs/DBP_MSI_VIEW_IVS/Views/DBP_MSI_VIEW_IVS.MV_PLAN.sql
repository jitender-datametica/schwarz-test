CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_PLAN as
   -- 2009-03-12
   -- FAKTVIEW Planwerte / Mietertragsplanung (KJMO)
   -- Spalten plan_wert_konz + kostenstelle_id nicht benutzt!
   -- 2009KW17 EUR + LW über waehrungstyp
   -- 2009KW27 Historisierung Kurs
   --  2009KW47 Umstellung mv_zeit auf v_monat

   SELECT
   pl.mandant_id,
   pl.plan_objekt_id  flaeche_id,
   zeit.gj,
   pl.kjmo,
   pl.plandetail_id,
   pl.plantyp_id,
   pl.plan_wert *kurs planwert,
   kurs.wrg_id,
   kurs.wrg_typ_id
  FROM dbp_view.v_ivs_plan pl
   INNER JOIN dbp_view.v_monat  zeit
   ON zeit.kjmo = pl.kjmo
   AND zeit.akt_gj BETWEEN -1 AND 0
   INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per  kurs
   ON kurs.mandant_id = pl.mandant_id
   AND max_dat BETWEEN kurs_dat_von AND kurs_dat_bis;