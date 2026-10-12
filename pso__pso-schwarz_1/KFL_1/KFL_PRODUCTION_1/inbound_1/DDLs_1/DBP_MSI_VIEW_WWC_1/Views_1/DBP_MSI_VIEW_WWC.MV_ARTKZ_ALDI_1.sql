CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_ALDI_1
(
aldi_id
,aldi_bez
)
AS
   SELECT aldi_id, CASE WHEN aldi_bez='system generated'
   THEN 'kein Aldiartikel'
   ELSE aldi_bez END AS aldi_bez
   FROM dbp_view.v_artkz_aldi_1
   WHERE mandant_id = 1
;