create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_JAHR_GJ(
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT
) as
   SELECT
  gj
  , akt_gj
  , akt_gj_komplett
   FROM dbp_view.v_jahr_gj
   WHERE gj>2001;