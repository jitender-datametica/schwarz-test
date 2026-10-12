create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_ZEIT_TAG_ZU(
	ZEIT_ID,
	DAT,
	AKT_TAG,
	WTAG_ID,
	KJWO,
	AKT_WO,
	KJMO,
	AKT_MO,
	MO_KJ,
	GJ,
	AKT_GJ,
	KJ
) as
 -- ZEIT/HIERARCHIE : flexible/kombinierte Zeitstruktur - Basis Tag
 -- 2020.0121 ssch0611 : Initial
 -- 2020.0204 ssch0611 : Review
 -- 2020.0720 ssch0611 : Multi-Language
 -- 2020.0818 ssch0611 : Extended weeks (history)
 
   SELECT  -- 2 GJ past (bis gestern)
  -10000 + (akt_gj * 10000)::SMALLINT AS zeit_id
, dat, akt_tag, wtag_id, kjwo, akt_wo, kjmo, akt_mo, mo_kj, gj, akt_gj, kj
FROM dbp_view.v_tag
WHERE akt_tag < 1 AND akt_gj IN (-1, 0)

UNION ALL -- 13 Monate past (bis gestern)
SELECT 
  -1000 + (akt_mo * 100) + (akt_gj * 10000)::SMALLINT AS zeit_id
, dat, akt_tag, wtag_id, kjwo, akt_wo, kjmo, akt_mo, mo_kj, gj, akt_gj, kj
FROM dbp_view.v_tag
WHERE akt_tag < 1 AND akt_mo BETWEEN -12 AND 0 

UNION ALL -- 11 Wochen past (bis gestern)
SELECT 
  -100 + (akt_wo * 10)::SMALLINT  AS zeitraum_id
, dat, akt_tag, wtag_id, kjwo, akt_wo, kjmo, akt_mo, mo_kj, gj, akt_gj, kj
FROM dbp_view.v_tag
WHERE akt_tag < 1 AND akt_wo BETWEEN -10 AND 0 

UNION ALL -- 5 Wochen future (full)
SELECT
  100 + (akt_wo * 10)::SMALLINT  AS zeitraum_id
, dat, akt_tag, wtag_id, kjwo, akt_wo, kjmo, akt_mo, mo_kj, gj, akt_gj, kj
FROM dbp_view.v_tag
WHERE akt_wo BETWEEN 0 AND 4 

UNION ALL -- 6 + 4 Wochen (full, day level)
SELECT 
  akt_tag::SMALLINT       AS zeit_id
, dat, akt_tag, wtag_id, kjwo, akt_wo, kjmo, akt_mo, mo_kj, gj, akt_gj, kj
FROM dbp_view.v_tag
WHERE akt_wo BETWEEN -5 AND 4 

UNION ALL -- 12 Monate future (full)
SELECT 
  1000 + (akt_mo * 100) + (akt_gj * 10000)::SMALLINT AS zeit_id
, dat, akt_tag, wtag_id, kjwo, akt_wo, kjmo, akt_mo, mo_kj, gj, akt_gj, kj
FROM dbp_view.v_tag
WHERE akt_mo BETWEEN 0 AND 11

UNION ALL -- akt. GJ (full)
SELECT 
  10000 + (akt_gj * 10000)::SMALLINT AS zeit_id
, dat, akt_tag, wtag_id, kjwo, akt_wo, kjmo, akt_mo, mo_kj, gj, akt_gj, kj
FROM dbp_view.v_tag
WHERE akt_gj IN (0);
