CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_RFI_D_TANKTRESOR_2
(
mandant_id
, wup_id
, nb_id
, dat
, rfi_datum
, rfi_fehlergrund
, de_umsatz_netto_tank
, de_umsatz_brutto_tank
)
AS
SELECT
1 AS mandant_id
, CAST(t01.marktnummer AS INTEGER) AS wup_id
, v01.nb_id
, TO_DATE(t01.datum, 'YYYY-MM_2-DD')  AS dat
, t01.rfi_datum
, t01.rfi_fehlergrund
, CASE WHEN t01.schluessel2 = 'UMSNET' THEN SUM(CAST( t01.wert AS NUMBER(18,2))) ELSE 0 END de_umsatz_netto_tank
, CASE WHEN  t01.schluessel2 IN ('UMSNET','UMSMWST') THEN SUM(CAST( t01.wert AS NUMBER(18,2))) ELSE 0 END de_umsatz_brutto_tank

FROM dbp_rfi.d_tanktresor_2 t01

JOIN dbp_view.v_wup_2 v01
ON t01.marktnummer = v01.wup_id
AND v01.mandant_id = 1

GROUP BY
mandant_id
, t01.marktnummer
, v01.nb_id
, t01.datum
, t01.rfi_datum
, t01.rfi_fehlergrund
, t01.schluessel2;