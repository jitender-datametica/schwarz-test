CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_POSTEN_RO_1
(
mandant_id
, posten_id
, spr_id
, posten_bez
, posten_kz
)
AS
   SELECT
   v01.mandant_id, v01.posten_id, v01.spr_id, v01.posten_bez, CASE WHEN v01.mandant_id = 1 AND v01.posten_id IN ('PN','PF') THEN 'X'
   WHEN v01.mandant_id <> 1 AND v01.posten_id = '1' THEN 'X'
   ELSE ''
   END AS posten_kz
   FROM dbp_view.v_artkz_posten_1 v01
   WHERE spr_id = 95;