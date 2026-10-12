CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_MIS_LIEFERQUOTE_2
(
mandant_id
, lieferquote_def
, datenquote_def
)
AS
SELECT
v01.mandant_id
, v01.lieferquote
, v01.datenquote

FROM dbp_msi_v_view.v_mis_lieferquote_2 v01;