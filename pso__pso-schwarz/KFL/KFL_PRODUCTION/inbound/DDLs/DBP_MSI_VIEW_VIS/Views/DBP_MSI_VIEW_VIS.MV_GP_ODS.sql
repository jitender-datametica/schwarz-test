CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GP_ODS AS
   -- Lookup: Lieferant (für Kassenberichte)
   -- ungefiltert
   -- 20120120 : iln_id entfernt
   -- 2024-01-15 muellerpatri Zahlart_id entfernt

   SELECT
   mandant_id, gp_id, einkaufsorganisation_id, dat_von, dat_bis, anlieferung_id, gp_name, gp_strasse, gp_plz, gp_ort, land_id, hgp_id, zek_id, lieferzeit, zahlungsziel_id, agb_id, iso_id, eigenverpackung_id, eigenmarke_id, audit_id, audit_dat, herst_fg, retour_sperr_fg, system_id, gp_branche_id, wewa_fg, loesch_fg, region_id, min_pal_faktor_lkw
   FROM dbp_view.v_gp;