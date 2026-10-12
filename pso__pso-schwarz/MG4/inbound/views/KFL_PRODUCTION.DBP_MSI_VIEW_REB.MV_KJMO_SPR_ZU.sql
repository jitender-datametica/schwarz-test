create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_KJMO_SPR_ZU(
	SPR_ID,
	MO_BEZ,
	KJMO,
	KJ,
	GJ,
	GJMO,
	MO_BEZ_LANG
) as
   SELECT
   spr_id, kjmo_bez, kjmo, CAST (SUBSTRING(kjmo, 2, 8) AS SMALLINT) AS kj, CAST (SUBSTRING(gjmo, 2, 8) AS SMALLINT) AS gj, gjmo, CAST (kjmo_bez_lang AS VARCHAR(20)) AS kjmo_bez_lang

   FROM dbp_view.v_kjmo_spr_zu
   WHERE spr_id = 22
   AND kjmo >= 200201
;