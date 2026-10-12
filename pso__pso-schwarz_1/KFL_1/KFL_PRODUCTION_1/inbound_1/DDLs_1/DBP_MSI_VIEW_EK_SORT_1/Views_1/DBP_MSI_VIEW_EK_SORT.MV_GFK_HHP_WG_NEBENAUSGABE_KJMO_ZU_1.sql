CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_GFK_HHP_WG_NEBENAUSGABE_KJMO_ZU_1
-- 18.05.2018 Erweiterung um WÃýhrungs-ID wrg_id / mmzy2302
-- 11.06.2018 InnerJoin mit Tabelle mandant_wrg_typ_zu_1 / mmzy2302
-- 24.07.2018 Referenzen auf Feld wrg_typ_id sowie InnerJoin mit Tabelle mandant_wrg_typ_zu_1 wurden wieder auskommentiert/ mmzy2302

(
mandant_id
, gfk_account_id
, gfk_wg_id
, kjmo
, wrg_id
-- , wrg_typ_id
, nebenausgaben_anteil
, nebenausgaben_tsd_eur
, nebenausgaben_index
)

AS

SELECT

v01.mandant_id
, gfk_account_id
, gfk_wg_id
, kjmo
, v01.wrg_id
-- , wrg_typ_id
, nebenausgaben_anteil
, nebenausgaben_tsd_eur
, nebenausgaben_index


FROM dbp_view.v_gfk_hhp_wg_account_na_kjmo_zu_1 v01;
-- INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 v02
-- ON v01.mandant_id = v02.mandant_id
-- AND v01.wrg_id = v02.wrg_id
