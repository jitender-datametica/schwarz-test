CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_REGIONALGESELLSCHAFT AS 
   SELECT DISTINCT
   v01.vs_id,
   v01.mandant_id,
   v02.vs_bez

   FROM DBP_VIEW.V_WUP v01
   INNER JOIN  DBP_VIEW.V_VS v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.vs_id = v02.vs_id
   AND v02.vk_id IN(0,1) AND NOT (v01.mandant_id=1 AND v01.vs_id=0)
   ;