create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TERMINIERUNGSGRUPPE_3_SPR_ZU_2(
	MANDANT_ID,
	SPR_ID,
	TERMINIERUNGSGRUPPE_3_ID,
	TERMINIERUNGSGRUPPE_3_BEZ
) as
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
-- Es gibt zur Zeit_2 keine Sprachtabelle. Damit es einheitlich und vom Schema vorbereitet ist, wird hier eine_2 Bezeichnung generiert
-- 24.04.2018, AP0018098 - Disporhythmus, srom0404, Anpassung bzgl. Text für -1
-- 20230717 staeblern Umstellung auf Session Variable
   SELECT
   t01.mandant_id, t01.spr_id, t01.terminierungsgruppe_3_id, t01.terminierungsgruppe_3_bez
   FROM
   DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_TERMINIERUNGSGRUPPE_3_SPR_ZU_2 t01
   INNER  JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v03
   ON t01.spr_id = v03.spr_id;