create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGERTYP_SPR_ZU_1(
	LAGERNUMMER_ID,
	LAGERTYP_BEZ,
	LAGERTYP_ID,
	MANDANT_ID,
	NB_ID,
	SPR_ID,
	WUP_ID
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.lagernummer_id,
   UPPER(v01.lagertyp_bez),
   v01.lagertyp_id,
   v01.mandant_id,
   v01.nb_id,
   v01.spr_id,
   v01.wup_id
FROM
   dbp_view.v_lagertyp_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;