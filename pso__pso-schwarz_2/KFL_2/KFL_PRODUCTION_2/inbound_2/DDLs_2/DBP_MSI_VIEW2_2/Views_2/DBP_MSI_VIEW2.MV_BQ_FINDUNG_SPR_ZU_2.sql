CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_BQ_FINDUNG_SPR_ZU_2
(
  mandant_id
, bq_findung_id
, bq_findung_bez
, bq_findung_id_bez
)
AS 
SELECT
  v01.mandant_id
, v01.bq_findung_id
, v01.bq_findung_bez
, v01.bq_findung_id || ' ' || v01.bq_findung_bez AS bq_findung_id_bez

FROM dbp_view.v_bq_findung_spr_zu_2 v01
WHERE spr_id = 22 
AND mandant_id = 1;