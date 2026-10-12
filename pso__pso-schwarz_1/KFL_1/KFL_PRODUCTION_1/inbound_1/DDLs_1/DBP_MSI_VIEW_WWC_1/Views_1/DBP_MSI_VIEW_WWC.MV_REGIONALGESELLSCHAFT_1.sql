CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_REGIONALGESELLSCHAFT_1(
VS_ID,
VS_BEZ,
VSVT_BEZ,
SORTIER_ID_VZ,
SORTIER_EKCO
) AS
   --11.06.2024, SPEC0255380, prescherad, Neualange 
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
   CASE 
   WHEN v01.vs_id = 1 THEN 4
   WHEN v01.vs_id = 2 THEN 2
   WHEN v01.vs_id = 3 THEN 3
   WHEN v01.vs_id = 6 THEN 6
   WHEN v01.vs_id = 7 THEN 1
   WHEN v01.vs_id = 8 THEN 5
   END AS sortier_ekco

   FROM dbp_view.v_wup_1 v01
   INNER JOIN dbp_view.v_vs_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.vs_id = v02.vs_id
   AND v01.mandant_id = 1
   AND v02.vk_id = 1
   GROUP BY 4,3,2,1;