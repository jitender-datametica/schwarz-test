CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_KALK_PREISE
-- 26.10.2011 system_id entfernt
-- 08.12.2011 AL Einschraenkung auf sek_schl_typ_id in ('M', 'P')
-- 12.01.2012 TWIE Waehrungsumrechnung hinzugefuegt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, schnittliste_id
, sek_schl_typ_id
, sek_schl_id
, in_art_id
, input_material_typ_id
, menge
, gesamt_wert
, menge_dme
, dme_einh_id
, wrg_id
, preis_kg
, default_wrg
, dat_kalk_ab_v02
, dat_kalk_ab_v03
)
AS
   SELECT
	v01.mandant_id, 
	v01.schnittliste_id, 
	v01.sek_schl_typ_id, 
	v01.sek_schl_id, 
	v01.flw_art_id AS in_art_id, 
	v01.input_material_typ_id, 
	v01.menge, 
	v01.gesamt_wert, 
	v01.menge_dme, 
	v01.dme_einh_id, 
	v01.wrg_id, 
	v01.preis_kg,
	v100.default_wrg,
    v02.dat_kalk_ab as dat_kalk_ab_v02,
    v03.dat_kalk_ab as dat_kalk_ab_v03

   FROM dbp_view.v_flw_kalk_preise v01

   LEFT OUTER JOIN dbp_view.v_flw_kalk_material v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.sek_schl_id = v02.materialwert_kalk_id

   LEFT OUTER JOIN dbp_view.v_flw_kalk_plan v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.sek_schl_id = v03.plan_kalk_id

   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id

   WHERE v01.sek_schl_typ_id in ('M', 'P');