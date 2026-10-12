CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_TERMINIERUNGSGRUPPE_3_SPR_ZU
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
-- Es gibt zur Zeit keine Sprachtabelle. Damit es einheitlich und vom Schema vorbereitet ist, wird hier eine Bezeichnung generiert
-- 24.04.2018, AP0018098 - Disporhythmus, srom0404, Anpassung bzgl. Text für -1
(
mandant_id
,spr_id
,terminierungsgruppe_3_id
,terminierungsgruppe_3_bez
)
AS
   SELECT
   t01.mandant_id, t01.spr_id, t01.terminierungsgruppe_3_id, t01.terminierungsgruppe_3_bez
   FROM
   ( -- t01
   SELECT v01.mandant_id, v02.spr_id, v01.terminierungsgruppe_3_id, CASE WHEN v01.terminierungsgruppe_3_id = '-1' THEN CAST('nicht gepflegt' AS CHAR(20))
   ELSE CAST(v01.terminierungsgruppe_3_id AS CHAR(20))
   END AS terminierungsgruppe_3_bez
   FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per v01
   CROSS JOIN dbp_view.v_mandant_spr_zu v02
   GROUP BY v01.mandant_id
   ,v02.spr_id
   ,v01.terminierungsgruppe_3_id
   ) t01

   UNION

   SELECT
   t01.mandant_id, t01.spr_id, t01.terminierungsgruppe_3_id, t01.terminierungsgruppe_3_bez
   FROM
   ( --t01
   SELECT v01.mandant_id, v02.spr_id, '-1' AS terminierungsgruppe_3_id, 'nicht gepflegt' AS terminierungsgruppe_3_bez
   FROM dbp_view.v_mandant v01
   CROSS JOIN dbp_view.v_mandant_spr_zu v02
   WHERE (v01.mandant_id, '-1') NOT IN (SELECT mandant_id, terminierungsgruppe_3_id FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per)
   ) t01
   ;