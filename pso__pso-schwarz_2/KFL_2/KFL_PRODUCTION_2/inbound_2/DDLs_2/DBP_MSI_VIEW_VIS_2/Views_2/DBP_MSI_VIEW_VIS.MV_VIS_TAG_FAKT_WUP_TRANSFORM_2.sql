create or replace view DBP_MSI_VIEW_VIS.MV_VIS_TAG_FAKT_WUP_TRANSFORM_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	DAT,
	AKT_TAG,
	UMS_NETTO,
	UMS_NETTO_PLAN,
	UMS_NETTO_PLAN_EXTERN,
	UMS_NETTO_PLAN_X,
	UMS_NETTO_WVJ,
	UMS_NETTO_WVVJ,
	UMS_NETTO_KVJ,
	UMS_NETTO_KVVJ,
	ANZ_KUNDE,
	ANZ_KUNDE_WVJ,
	ANZ_KUNDE_WVVJ,
	ANZ_KUNDE_KVJ,
	ANZ_KUNDE_KVVJ,
	ANZ_OFFEN,
	ANZ_OFFEN_WVJ,
	ANZ_OFFEN_WVVJ,
	ANZ_OFFEN_KVJ,
	ANZ_OFFEN_KVVJ,
	UMS_BRUTTO,
	UMS_BRUTTO_WVJ,
	UMS_BRUTTO_WVVJ,
	UMS_BRUTTO_KVJ,
	UMS_BRUTTO_KVVJ
) as
-- FAKT-AGGREGAT Umsatz/Kunden/Offen pro Filiale/Tag_2
-- Datenumfang:  10 GJ
-- 2011KW07 INITIAL
-- 2012KW04 TBac: Erweiterung um Brutto-Spalten und Kundenspalten pro Bedienkonzept
-- 2019.0314 ssch0611 : Erweiterung ums_netto_plan_extern
-- 2021-03-05 ssch0611 : added transformations kunde_vvj, removed kum, removed bedienkonzept
SELECT
vis.mandant_id,
vis.nb_id,
vis.wup_id,
vis.wrg_id,
vis.dat,
vis.akt_tag,
vis.ums_netto,
vis.ums_netto_plan,
vis.ums_netto_plan_extern,
CASE
WHEN vis.ums_netto_plan_extern <> 0 THEN vis.ums_netto_plan_extern
ELSE vis.ums_netto_plan END  AS ums_netto_plan_x,
vis.ums_netto_wvj,
vis.ums_netto_wvvj,
vis.ums_netto_kvj,
vis.ums_netto_kvvj,
vis.anz_kunde,
vis.anz_kunde_wvj,
vis_wvvj.anz_kunde AS anz_kunde_wvvj,
vis.anz_kunde_kvj,
vis_kvvj.anz_kunde AS anz_kunde_kvvj,
vis.anz_offen,
vis.anz_offen_wvj,
vis.anz_offen_wvvj,
vis.anz_offen_kvj,
vis.anz_offen_kvvj,
vis.ums_brutto,
vis.ums_brutto_wvj,
vis.ums_brutto_wvvj,
vis.ums_brutto_kvj,
vis.ums_brutto_kvvj
FROM dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 vis

LEFT JOIN dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 vis_wvvj
ON vis_wvvj.mandant_id = vis.mandant_id AND vis_wvvj.wup_id = vis.wup_id AND vis_wvvj.wrg_id = vis.wrg_id
AND vis_wvvj.dat = (vis.dat - 728)

LEFT JOIN dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 vis_kvvj
ON vis_kvvj.mandant_id = vis.mandant_id AND vis_kvvj.wup_id = vis.wup_id AND vis_kvvj.wrg_id = vis.wrg_id
AND vis_kvvj.dat = Add_Months(vis.dat, -24);