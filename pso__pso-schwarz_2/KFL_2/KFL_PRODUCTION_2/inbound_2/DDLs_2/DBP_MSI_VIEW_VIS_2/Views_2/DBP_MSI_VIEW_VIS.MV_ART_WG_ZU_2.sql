create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_ART_WG_ZU_2(
	MANDANT_ID,
	ARTHIERTYP_ID,
	ART_ID,
	WUG_ID,
	WG_ID,
	DAT_VON,
	DAT_BIS
) as
   -- ZUORDNUNG : Artikel_2 (Fehlmengen)
   -- 2010KW07 : Review arthiertyp_2 1
   -- 2011KW50 : Anpassung arthiertyp_2 2
   -- 2012KW07 : Einschraenkung mandant_id=1 entfernt

   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.art_id, v01.wug_id, v01.wg_id, v01.dat_von, v01.dat_bis
   FROM dbp_view.v_art_wg_zu_per_2 v01

   WHERE v01.arthiertyp_id = 2
   AND   v01.dat_bis = '9999-12-31';
