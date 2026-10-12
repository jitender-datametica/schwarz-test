CREATE OR REPLACE VIEW DBP_MSI_VIEW_DEMO.MV_ARTBEW_WG_MO_SUM_2
(
mandant_id
,wup_id
,nb_id
,kjmo
,wg_id
,menge
,umsatz_netto
,default_wrg
)
AS
SELECT
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.kjmo,
v01.wg_id,
v01.menge,
v01.umsatz_netto,
v02.default_wrg
FROM dbp_view.v_artbew_wg_mo_sum_2 v01
INNER JOIN dbp_view.v_mandant_2 v02
ON v01.mandant_id = v02.mandant_id;


