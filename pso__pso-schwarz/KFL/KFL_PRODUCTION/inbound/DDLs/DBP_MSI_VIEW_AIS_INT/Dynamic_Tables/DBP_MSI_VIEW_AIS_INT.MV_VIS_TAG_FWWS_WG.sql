CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_VIS_TAG_FWWS_WG 
(
   mandant_id, 
   nb_id, 
   wup_id, 
   bezugsweg_id, 
   arthiertyp_id, 
   abt_id, 
   wg_id, 
   dat, 
   kjwo, 
   kjmo, 
   gj, 
   akt_tag, 
   anz_artikel_autodispo, 
   anz_artikel_markt_gelistet_okd, 
   anz_artikel_markt_gelistet, 
   anz_artikel_exc209, 
   anz_artikel_exc214, 
   anz_artikel_autodispo_dm12, 
   sum_artikel_autodispo, 
   sum_artikel_markt_gelistet_okd, 
   sum_artikel_markt_gelistet
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
   -- FAKT-AGGREGAT FWWS Autodispo (Anz. Artikel) pro Woche/Tag - Markt/Abt/WG

   SELECT
   v01.mandant_id, 
   v01.nb_id, 
   v01.wup_id, 
   v01.bezugsweg_id, 
   v01.arthiertyp_id, 
   v01.abt_id, 
   v01.wg_id, 
   v01.dat, 
   v01.kjwo, 
   v01.kjmo, 
   v01.gj, 
   v01.akt_tag, 
   v01.anz_artikel_autodispo, 
   v01.anz_artikel_markt_gelistet_okd, 
   v01.anz_artikel_markt_gelistet, 
   v01.anz_artikel_exc209, 
   v01.anz_artikel_exc214, 
   v01.anz_artikel_autodispo_dm12, 
   v01.sum_artikel_autodispo, 
   v01.sum_artikel_markt_gelistet_okd, 
   v01.sum_artikel_markt_gelistet

   FROM dbp_msi_v_view.v_vis_tag_fwws_wg  v01
   WHERE v01.mandant_id = 1;