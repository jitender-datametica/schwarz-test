CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_REGIONALGESELLSCHAFT_2

(
 vs_id
,mandant_id
,vs_bez
,vsvt_bez
,sortier_id_vz
)
AS
--20200408 lsvi0303: All countries added to the view
--AP0120447, SPEC0146326: Sortierung nach VZ (nur DE)
--NSR4039136, staeblern: Entfernen 690 von der sortier_id_vz nur bei DE 
   SELECT
   v01.vs_id,
   v01.mandant_id,
   v02.vs_bez,
   v02.vsvt_bez,
  CASE 
   WHEN v01.vs_id = 1 AND v01.mandant_id = 1 THEN 2
   WHEN v01.vs_id = 2 AND v01.mandant_id = 1 THEN 3
   WHEN v01.vs_id = 3 AND v01.mandant_id = 1 THEN 1
   WHEN v01.vs_id = 6 AND v01.mandant_id = 1 THEN 5
   WHEN v01.vs_id = 7 AND v01.mandant_id = 1 THEN 4
   WHEN v01.vs_id = 8 AND v01.mandant_id = 1 THEN 6
   WHEN v01.mandant_id = 2 THEN 1
   WHEN v01.mandant_id = 3 AND v01.vs_id = 0 THEN 1
   WHEN v01.mandant_id = 3 AND v01.vs_id = 1 THEN 2
   WHEN v01.mandant_id = 3 AND v01.vs_id = 2 THEN 3
   WHEN v01.mandant_id = 4 THEN 1
   WHEN v01.mandant_id = 5 THEN 1
   WHEN v01.mandant_id = 6 THEN 1
   WHEN v01.mandant_id = 7 THEN 1
   WHEN v01.mandant_id = 8 THEN 1
   END AS sortier_id_vz

   FROM dbp_view.v_wup_2 v01
   INNER JOIN dbp_view.v_vs_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.vs_id = v02.vs_id

   AND v02.vk_id IN (0,1) AND NOT (v01.mandant_id=1 AND v01.vs_id=0)
   GROUP BY 2,1,3,4;