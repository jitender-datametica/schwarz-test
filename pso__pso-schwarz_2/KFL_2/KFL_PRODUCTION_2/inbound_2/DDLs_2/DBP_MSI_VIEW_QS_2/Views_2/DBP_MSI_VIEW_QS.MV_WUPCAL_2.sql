CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_WUPCAL_2
(
wup_id
, mandant_id
, nb_id
, dat
, offen
, werbewoche
, datenlieferung_artbew_wg_sum
, bonanzahl
, datenlieferung_bonanzahl
, bonanzahl_misvier
, datenlieferung_misvier
, datenlieferung_artbew
, datenlieferung_qbm_status
, bonanzahl_imbiss
, pruef_status_umsatz
, pruef_status_kunde
, pruef_grund_id_umsatz
, pruef_grund_id_kunde
, dat_extrakt_umsatz
, count_wup
)
AS
SELECT
v01.wup_id
, v01.mandant_id
, v01.nb_id
, v01.dat
, v01.offen
, v01.werbewoche
, v01.datenlieferung_artbew_wg_sum
, v01.bonanzahl
, v01.datenlieferung_bonanzahl
, v01.bonanzahl_misvier
, v01.datenlieferung_misvier
, v01.datenlieferung_artbew
, v01.datenlieferung_qbm_status
, v01.bonanzahl_imbiss
, v01.pruef_status_id_umsatz
, v01.pruef_status_id_kunde
, v01.pruef_grund_id_umsatz
, v01.pruef_grund_id_kunde
, v01.dat_extrakt_umsatz
, 1

FROM dbp_view.v_wupcal_2 v01;