CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_HANDLING_UNIT_STATUS_SPR_ZU_2
-- 06.07.2017, AP0006317 - srom0404, kein deutscher Text für Ausland in SAP Tabelle
(
mandant_id
,hu_status_id
,hu_status_bez
,spr_id
)
AS
   SELECT  t2.mandant_id, t2.hu_status_id, t2.hu_status_bez, t2.spr_id
   FROM
   ( --t2
   SELECT
   v01.mandant_id, v01.hu_status_id, v01.hu_status_bez, v01.spr_id
   FROM dbp_view.v_handling_unit_status_spr_zu_2 v01

   UNION

   SELECT v02.mandant_id, v02.hu_status_id, t1.hu_status_bez, t1.spr_id
   FROM dbp_view.v_handling_unit_status_spr_zu_2 v02
   LEFT JOIN (-- t1_2
   SELECT v03.hu_status_id, v03.hu_status_bez, v03.spr_id
   FROM dbp_view.v_handling_unit_status_spr_zu_2 v03
   WHERE v03.mandant_id = 1
   AND v03.spr_id = 22
   ) t1_2
   ON v02.hu_status_id = t1.hu_status_id
   WHERE v02.mandant_id <> 1
   ) t2
   ;