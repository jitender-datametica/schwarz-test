CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FWWS_WUP_PC_1 as
    -- FAKT-AGGREGAT FWWS Anz Fehlermeldung pro Monat_1 - Markt - Problemcode
    -- Datenumfang: 
    -- 2013KW37 INITIAL

   SELECT
     v01.mandant_id, v01.nb_id, v01.wup_id, v01.problemcode_id, v01.kjmo, SUM(v01.anz_fehler)   anz_fehler, SUM (SUM(v01.anz_fehler)) OVER (PARTITION BY v01.mandant_id, v01.wup_id, v01.nb_id, v01.problemcode_id, v02.gj ORDER BY v01.kjmo ROWS UNBOUNDED PRECEDING)  anz_fehler_kum

   FROM dbp_msi_v_view.v_vis_monat_gp_wup_probleme_1  v01
   INNER JOIN dbp_view.v_monat_1 v02
   ON v01.kjmo = v02.kjmo

   GROUP BY
     v01.mandant_id
   , v01.nb_id
   , v01.wup_id
   , v01.problemcode_id
   , v01.kjmo
   , v02.gj
   ;