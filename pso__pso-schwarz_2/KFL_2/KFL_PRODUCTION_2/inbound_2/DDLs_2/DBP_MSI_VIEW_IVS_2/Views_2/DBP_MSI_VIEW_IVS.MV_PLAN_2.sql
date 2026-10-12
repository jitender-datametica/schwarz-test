CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_PLAN_2 as
   -- 2009-03-12
   -- FAKTVIEW Planwerte / Mietertragsplanung (KJMO)
   -- Spalten plan_wert_konz + kostenstelle_id nicht benutzt!
   -- 2009KW17 EUR + LW über waehrungstyp
   -- 2009KW27 Historisierung Kurs_2
   --  2009KW47 Umstellung mv_zeit_2 auf v_monat_2

   SELECT
   pl.mandant_id,
   pl.plan_objekt_id  flaeche_id,
   zeit.gj,
   pl.kjmo,
   pl.plandetail_id,
   pl.plantyp_id,
   pl.plan_wert *kurs_2 planwert,
   kurs.wrg_id,
   kurs.wrg_typ_id
  FROM dbp_view.v_ivs_plan_2 pl
   INNER JOIN dbp_view.v_monat_2  zeit_2
   ON zeit.kjmo = pl.kjmo
   AND zeit.akt_gj BETWEEN -1 AND 0
   INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2  kurs_2
   ON kurs.mandant_id = pl.mandant_id
   AND max_dat BETWEEN kurs_dat_von AND kurs_dat_bis;