CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_ANLASS_KZ_1 as
   -- 12.03.2019 dsim0608 - SPEC0049429

   SELECT DISTINCT '-1' AS Anlass_kz, 'kein definierter Anlass -> Manueller Nachdruck usw.' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'AS' AS Anlass_kz, 'Auslistung' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'MD' AS Anlass_kz, 'Anforderung per MDE-Gerät' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'NA' AS Anlass_kz, 'Neuanlage' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'PE' AS Anlass_kz, 'Preiserhöhung' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'PS' AS Anlass_kz, 'Preissenkung' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'RA_1' AS Anlass_kz, 'Rücksetzung Aktion_1' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'RS_1' AS Anlass_kz, 'Rücksetzung' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'RN' AS Anlass_kz, 'Rücksetzung Neu im Sortiment' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'SA' AS Anlass_kz, 'Sonderaktion / Werbung' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'SO' AS Anlass_kz, 'Sonstiger Anlass' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1
   UNION ALL
   SELECT DISTINCT 'PX' AS Anlass_kz, 'Textzeilenänderung Plakate' AS Beschreibung FROM dbp_msi_view_vis.mv_mandant_1;