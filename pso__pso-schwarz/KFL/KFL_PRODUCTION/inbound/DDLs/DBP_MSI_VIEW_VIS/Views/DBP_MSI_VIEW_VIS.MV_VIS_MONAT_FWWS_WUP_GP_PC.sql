CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FWWS_WUP_GP_PC
AS
   -- FAKT-AGGREGAT FWWS Anz Fehlermeldung pro Monat - Markt/Lieferant - Problemcode
   -- Datenumfang:
   -- 2013KW37 INITIAL

   SELECT
   v01.mandant_id, v01.nb_id, v01.wup_id, v01.gp_id, v01.problemcode_id, v01.kjmo, v01.anz_fehler, v01.anz_fehler_kum

   FROM dbp_msi_v_view.v_vis_monat_gp_wup_probleme  v01
;