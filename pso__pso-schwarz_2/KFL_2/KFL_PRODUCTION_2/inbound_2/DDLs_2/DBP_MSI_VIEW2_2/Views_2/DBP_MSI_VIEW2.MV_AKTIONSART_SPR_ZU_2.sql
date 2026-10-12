CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_AKTIONSART_SPR_ZU_2
(
aktionsart_id
,mandant_id
,spr_id
,aktionsart_bez
)
AS
   SELECT
  v01.aktionsart_id, v01.mandant_id, v02.spr_id, v02.aktionsart_bez

   FROM dbp_view.v_l_aktionsart_2 AS v01
   INNER JOIN dbp_view.v_aktionsart_spr_zu_2 AS v02
   ON
   v01.aktionsart_id = v02.aktionsart_id
   AND
   v01.mandant_id = v02.mandant_id
   WHERE
   v01.mandant_id = 1
   AND
   v02.spr_id = 22;