create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MONAT(
	GJMO,
	GJMO_VJ,
	MO_GJ,
	KJMO,
	KJMO_VJ,
	MO_KJ,
	AKT_MO,
	AKT_MO_KOMPLETT,
	GJQU,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	KJQU,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	GJ,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	KJ,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	KJMO_VM,
	AKT_MO_KALENDARISCH
) as
   SELECT
  gjmo
  , gjmo_vj
  , mo_gj
  , kjmo
  , kjmo_vj
  , mo_kj
  , akt_mo
  , akt_mo_komplett
  , gjqu
  , akt_gjqu
  , akt_gjqu_komplett
  , kjqu
  , akt_kjqu
  , akt_kjqu_komplett
  , gj
  , akt_gj
  , akt_gj_komplett
  , kj
  , akt_kj
  , akt_kj_komplett
  -- , TRUNC(ADD_MONTHS(CAST(kjmo*100-19000000+1 AS DATE),-1)/100) + 190000
  , YEAR(ADD_MONTHS(CAST(LEFT((kjmo)::VARCHAR(10),4) || '-' || RIGHT((kjmo)::VARCHAR(10),2) || '-20' AS DATE),-1))::VARCHAR(10)
   || MONTH(ADD_MONTHS(CAST(LEFT((kjmo)::VARCHAR(10),4) || '-' || RIGHT((kjmo)::VARCHAR(10),2) || '-20' AS DATE),-1))::VARCHAR(10)::INT
  , (kj-EXTRACT(YEAR FROM CURRENT_DATE))*12+(MOD(kjmo, 100))-EXTRACT(MONTH FROM CURRENT_DATE)
   FROM dbp_view.v_monat
   WHERE kjmo>=200201;