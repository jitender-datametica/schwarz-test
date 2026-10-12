CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_RFI_D_TANKKUNDEN_1
(
mandant_id
, wup_id
, nb_id
, dat
, rfi_datum
, rfi_fehlergrund
, de_kundenzahl
)
AS 
SELECT
1 AS mandant_id
, CAST(t01.marktnummer AS INTEGER) AS wup_id
, v01.nb_id
, TO_DATE(t01.datum,'YYYY-MM_1-DD') AS dat
, t01.rfi_datum
, t01.rfi_fehlergrund
, SUM(CAST(t01.wert AS INTEGER))

FROM dbp_rfi.d_tankkunden_1 t01

JOIN dbp_view.v_wup_1 v01
ON t01.marktnummer = v01.wup_id
AND v01.mandant_id = 1

WHERE t01.schluessel2 = 'KUNDEN_GESAMT'

GROUP BY 1,2,3,4,5,6;