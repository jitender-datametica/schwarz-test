CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_RFI_WPUKSR_1
(
mandant_id
, wup_id
, nb_id
, dat
, rfi_datum
, rfi_fehlergrund
, anz_bon_rfi
)
AS
SELECT
t01.mandant_id
, CAST(t01.filiale AS INTEGER) AS wup_id
, v01.nb_id
, TO_DATE(t01.belegdatum,'YYYYMMDD') AS dat
, t01.rfi_datum
, t01.rfi_fehlergrund
, SUM(CAST(t01.azbon AS INTEGER))

FROM dbp_rfi.wpuksr_1 t01

JOIN dbp_view.v_wup_1 v01
ON t01.filiale = v01.wup_id
AND t01.mandant_id = v01.mandant_id

GROUP BY 1,2,3,4,5,6;