CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TERMINIERUNGSGRUPPE_3_SPR_ZU_1
(
mandant_id
,spr_id
,terminierungsgruppe_3_id
,terminierungsgruppe_3_bez
)
AS
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
-- Es gibt zur Zeit_1 keine Sprachtabelle. Damit es einheitlich und vom Schema vorbereitet ist, wird hier eine_1 Bezeichnung generiert
-- 24.04.2018, AP0018098 - Disporhythmus, srom0404, Anpassung bzgl. Text für -1
-- 20230717 staeblern Umstellung auf Session Variable
   SELECT
   t01.mandant_id, t01.spr_id, t01.terminierungsgruppe_3_id, t01.terminierungsgruppe_3_bez
   FROM
   DBP_MSI_VIEW3.TBL_MV_TERMINIERUNGSGRUPPE_3_SPR_ZU_1 t01
   INNER  JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_1 v03
   ON t01.spr_id = v03.spr_id
   ;