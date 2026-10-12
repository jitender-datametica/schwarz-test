CREATE OR REPLACE VIEW FE_MSTR_NFMD.MV_L_REGIONALGESELLSCHAFT
--Lookup View for the regions 
(
 vs_id
,mandant_id
,vs_bez
)
AS
   SELECT distinct 
   v01.vs_id,
   v01.mandant_id,
   v02.vs_bez

   FROM CORE.SRC_TERADATA_MASTER_DATA_WUP v01
   INNER JOIN CORE.L_REGION_IDS v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.vs_id = v02.vs_id
   
   -- eventuell spater wenn wir nicht L_REGION_IDS verwenden, sondern von KFL dbp_data.vs 
   --AND v02.vk_id in(0,1) AND NOT (v01.mandant_id=1 AND v01.vs_id=0);
   
   ;