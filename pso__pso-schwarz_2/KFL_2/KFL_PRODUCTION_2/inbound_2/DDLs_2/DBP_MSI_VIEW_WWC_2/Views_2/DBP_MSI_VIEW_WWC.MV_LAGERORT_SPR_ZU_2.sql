CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_LAGERORT_SPR_ZU_2
(
mandant_id
, spr_id
, WERKS
, nb_id
, LGORT
, lagerort_bez
)
AS
   SELECT
   v01.mandant_id, v01.spr_id, v01.wup_id AS WERKS, v01.nb_id, v01.lagerort_id AS LGORT, v01.lagerort_bez

   FROM dbp_view.v_lagerort_spr_zu_2 v01
   WHERE v01.spr_id = 22;