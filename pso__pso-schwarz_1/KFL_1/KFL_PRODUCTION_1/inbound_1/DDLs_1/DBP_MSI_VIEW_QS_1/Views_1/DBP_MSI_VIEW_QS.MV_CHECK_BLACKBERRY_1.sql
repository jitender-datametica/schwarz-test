CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_CHECK_BLACKBERRY_1
(
dat
, mandant_id
, lieferquote_real
, lieferquote_def
, datenquote_real
, datenquote_def
, bb_fg
, check_fg
, umsatz_ist
, umsatz_vj
, umsatz_plan
, umsatz_vortag
, umsatz_vorwoche
, kunden_ist
, kunden_vj
)
AS
SELECT
v01.dat
, v01.mandant_id
, v01.lieferquote_real
, v01.lieferquote_def
, v01.datenquote_real
, v01.datenquote_def
, v01.bb_fg
, v01.check_fg
, v01.umsatz_ist
, v01.umsatz_vj
, v01.umsatz_plan
, v01.umsatz_vortag
, v01.umsatz_vorwoche
, v01.kunden_ist
, v01.kunden_vj

FROM dbp_msi_v_view.v_check_blackberry_1 v01;