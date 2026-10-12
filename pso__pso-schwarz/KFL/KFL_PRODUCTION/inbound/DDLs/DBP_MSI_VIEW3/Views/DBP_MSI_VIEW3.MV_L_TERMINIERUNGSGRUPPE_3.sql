CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_TERMINIERUNGSGRUPPE_3
-- 24.08.2017, AP0018098 - Disporhythmus, srom0404, initial
(
mandant_id
,terminierungsgruppe_3_id
)
AS
   SELECT v01.mandant_id, v01.terminierungsgruppe_3_id
   FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per v01
   GROUP BY v01.mandant_id
   ,v01.terminierungsgruppe_3_id

   UNION

   SELECT v02.mandant_id, '-1' AS terminierungsgruppe_3_id
   FROM dbp_view.v_mandant v02
   WHERE (v02.mandant_id, '-1') NOT IN (SELECT mandant_id, terminierungsgruppe_3_id FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per);