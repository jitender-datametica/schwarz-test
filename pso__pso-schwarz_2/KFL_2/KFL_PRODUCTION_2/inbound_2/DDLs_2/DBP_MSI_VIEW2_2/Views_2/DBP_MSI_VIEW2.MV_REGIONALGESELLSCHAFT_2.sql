CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGIONALGESELLSCHAFT_2
(
vs_id
,vs_bez
,vsvt_bez
,sortier_id_vz
,sortier_ekco
)
AS
--NSR4039136, staeblern: Entfernen 690 von der sortier_id_vz  
   SELECT
  v01.vs_id, 
  v02.vs_bez, 
  v02.vsvt_bez,
  CASE 
   WHEN v01.vs_id = 1 THEN 2
   WHEN v01.vs_id = 2 THEN 3
   WHEN v01.vs_id = 3 THEN 1
   WHEN v01.vs_id = 6 THEN 5
   WHEN v01.vs_id = 7 THEN 4
   WHEN v01.vs_id = 8 THEN 6
   END AS sortier_id_vz,
   -- Sortierung fuer EK Reporting SAISON REPORTING
   CASE 
      WHEN v01.vs_id = 1 THEN 4
      WHEN v01.vs_id = 2 THEN 2
      WHEN v01.vs_id = 3 THEN 3
      WHEN v01.vs_id = 6 THEN 6
      WHEN v01.vs_id = 7 THEN 1
      WHEN v01.vs_id = 8 THEN 5
      END AS sortier_ekco

   FROM dbp_view.v_wup_2 v01
   INNER JOIN dbp_view.v_vs_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.vs_id = v02.vs_id
   AND v01.mandant_id = 1
   AND v02.vk_id = 1
   GROUP BY 4,3,2,1;