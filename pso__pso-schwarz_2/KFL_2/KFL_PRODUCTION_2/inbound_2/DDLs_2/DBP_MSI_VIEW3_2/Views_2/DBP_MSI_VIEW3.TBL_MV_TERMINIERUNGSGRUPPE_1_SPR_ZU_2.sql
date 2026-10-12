CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_TERMINIERUNGSGRUPPE_1_SPR_ZU_2
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
-- Es gibt zur Zeit_2 keine Sprachtabelle. Damit es einheitlich und vom Schema vorbereitet ist, wird hier eine_2 Bezeichnung generiert
-- 24.04.2018, AP0018098 - Disporhythmus, srom0404, Anpassung bzgl. Text für -1
(
mandant_id
,spr_id
,terminierungsgruppe_1_id
,terminierungsgruppe_1_bez
)
AS
   SELECT
   t01.mandant_id, t01.spr_id, t01.terminierungsgruppe_1_id, t01.terminierungsgruppe_1_bez
   FROM
   ( -- t01
   SELECT v01.mandant_id, v02.spr_id, v01.terminierungsgruppe_1_id, CASE WHEN v01.terminierungsgruppe_1_id = '-1' THEN CAST('nicht gepflegt' AS CHAR(20))
   ELSE CAST(v01.terminierungsgruppe_1_id AS CHAR(20))
   END AS terminierungsgruppe_1_bez
   FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_2 v01
   CROSS JOIN dbp_view.v_mandant_spr_zu_2 v02
   GROUP BY v01.mandant_id
   ,v02.spr_id
   ,v01.terminierungsgruppe_1_id
   ) t01

   UNION

   SELECT
   t01.mandant_id, t01.spr_id, t01.terminierungsgruppe_1_id, t01.terminierungsgruppe_1_bez
   FROM
   ( --t01
   SELECT v01.mandant_id, v02.spr_id, '-1' AS terminierungsgruppe_1_id, 'nicht gepflegt' AS terminierungsgruppe_1_bez
   FROM dbp_view.v_mandant_2 v01
   CROSS JOIN dbp_view.v_mandant_spr_zu_2 v02
   WHERE (v01.mandant_id, '-1') NOT IN (SELECT mandant_id, terminierungsgruppe_1_id FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_2)
   ) t01
   ;