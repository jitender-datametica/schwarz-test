CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GP_1 AS
   -- LOOKUP FWWS Lieferant (gp_1) Stammdaten
   -- 2010KW42PU INITIAL (Erweiterung Lieferant)
   -- 2010KW47 Erweiterung Nummernkreis (VZ)
   -- 2011KW07 Spalte zahlungsziel entfernt
   -- 2011KW37 Erweiterung KMO
   -- 2012KW07 AL iln_id entfernt
   -- 2024-01-15 muellerpatri Zahlart_id entfernt

   SELECT

   v01.mandant_id, v01.gp_id, v01.gp_name, v01.gp_strasse, v01.gp_plz, v01.gp_ort, v01.land_id AS gp_land_id, v01.gp_branche_id, v01.dat_von AS gp_dat_von, v01.dat_bis AS gp_dat_bis, v01.einkaufsorganisation_id, v01.anlieferung_id, v01.hgp_id, v01.zek_id, v01.lieferzeit, v01.agb_id, v01.iso_id, v01.eigenverpackung_id, v01.eigenmarke_id, v01.audit_id, v01.audit_dat, v01.herst_fg, ZEROIFNULL(v01.retour_sperr_fg)  retour_sperr_fg, ZEROIFNULL(v01.loesch_fg)  loesch_fg

   FROM dbp_view.v_gp_1  v01

   WHERE v01.dat_bis = '9999-12-31'
   AND
   (
   (
   v01.mandant_id = 1
   AND
   (
   v01.gp_id > 999999  -- nur Lieferanten
   OR v01.gp_id BETWEEN 9210 AND 9230  -- IWT-Betriebe
   OR v01.gp_id BETWEEN 6900 AND 6910  -- VZ
   )
   )
   OR
   (
   v01.mandant_id <> 1
   AND v01.gp_id > 999
   )
   );