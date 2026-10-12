create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_AUFTRAG_GRUND_SPR_ZU(
	AUFTRAG_GRUND_BEZ,
	AUFTRAG_GRUND_ID,
	MANDANT_ID,
	SPR_ID
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.auftrag_grund_bez,
   v01.auftrag_grund_id,
   v01.mandant_id,
   v01.spr_id
FROM
   dbp_view.v_auftrag_grund_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;