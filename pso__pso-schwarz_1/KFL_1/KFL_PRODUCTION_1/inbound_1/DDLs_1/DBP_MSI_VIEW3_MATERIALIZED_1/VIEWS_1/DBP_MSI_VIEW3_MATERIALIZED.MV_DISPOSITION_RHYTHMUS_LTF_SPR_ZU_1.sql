create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_DISPOSITION_RHYTHMUS_LTF_SPR_ZU_1(
	MANDANT_ID,
	SPR_ID,
	DISPOSITION_RHYTHMUS_LTF_ID,
	DISPOSITION_RHYTHMUS_LTF_ID_BEZ,
	DISPOSITION_RHYTHMUS_LTF_BEZ
) as 
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
-- 26.09.2018, AP0018098 - Disporhythmus, srom0404, Erweiterung -1 = nicht gepflegt
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   t01.mandant_id,
   t01.spr_id,
   t01.disposition_rhythmus_ltf_id,
   t01.disposition_rhythmus_ltf_id_bez,
   t01.disposition_rhythmus_ltf_bez
FROM
   DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_DISPOSITION_RHYTHMUS_LTF_SPR_ZU_1 t01
   INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v03 
   ON t01.spr_id = v03.spr_id;