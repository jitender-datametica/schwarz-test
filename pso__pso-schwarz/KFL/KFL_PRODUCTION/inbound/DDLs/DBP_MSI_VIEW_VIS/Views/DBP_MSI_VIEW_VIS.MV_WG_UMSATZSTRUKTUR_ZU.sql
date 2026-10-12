CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WG_UMSATZSTRUKTUR_ZU as
   -- 04.10.2010 AL Erstellt. View bildet bestehende Zuordnung zwischen Umsatzstruktur und WG ab.
   --                   View dient der Ablösung der dynamischen Gruppierung Umsatzstruktur.
   SELECT

   mandant_id, wg_hierarchie_id              AS wg_id, wg_hierarchie_mutter_id  AS umsatzstruktur_id
   FROM dbp_view.v_wg_hierarchie_zu_per
   WHERE arthiertyp_id=8 and dat_bis='9999-12-31';