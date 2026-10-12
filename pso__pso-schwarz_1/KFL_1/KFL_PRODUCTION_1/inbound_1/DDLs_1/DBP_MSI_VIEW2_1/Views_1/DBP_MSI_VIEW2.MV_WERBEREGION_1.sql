CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WERBEREGION_1
(
 wreg_id
,wreg_bez

)
AS
   SELECT
   CASE 
   WHEN v01.vs_id IN (2,7)
   THEN 1
   WHEN v01.vs_id IN (1,3)
   THEN 2
   WHEN v01.vs_id IN (6,8)
   THEN 3
   END AS wreg_id
  ,CASE 
   WHEN v01.vs_id IN (2,7)
   THEN 'Süd'
   WHEN v01.vs_id IN (1,3)
   THEN 'Ost'
   WHEN v01.vs_id IN (6,8)
   THEN 'West'
   END AS wreg_bez 

   FROM dbp_view.v_vs_1 v01
   WHERE v01.mandant_id = 1
   AND v01.vk_id = 1
   GROUP BY 1,2;