CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_DISPONENT_WUP_ZU
(
mandant_id
, wup_id
, nb_id
, disponent_id
, disponent_name
)
AS
   SELECT
   v00.mandant_id, v00.wup_id, v00.nb_id, v00.disponent_id, v00.disponent_name

   FROM
   (
   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.disponent_id, v01.disponent_name, 1 as prio
   FROM dbp_view.v_disponent_wup_zu v01
   WHERE
   v01.nb_id=-111
   UNION ALL
   SELECT
   v02.mandant_id, v02.wup_id, v02.nb_id, '-1' AS disponent_id, 'nicht gepflegt / not maintained' AS disponent_name, 2 as prio
   FROM dbp_view.v_wup v02
   WHERE v02.nb_id=-111
   ) v00
   QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, wup_id, nb_id, disponent_id ORDER BY PRIO) = 1;