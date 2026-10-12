create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_NFMD.MV_SAISON_SPR_ZU_1(
	MANDANT_ID,
	SAISON_ID,
	SAISON_BEZ,
	SAISON_BEZ_DE,
	SAISON_BEZ_EN,
	SAISON_BEZ_CZ,
	SAISON_BEZ_SK,
	SAISON_BEZ_HR,
	SAISON_BEZ_PL,
	SAISON_BEZ_RO,
	SAISON_BEZ_BG
) as
SELECT
 v01.mandant_id
,v01.saison_id
-- zustaezliche Abfrage auf Saison ID, wenn diese leer ist sollte auch die Bezeichnung leer sein und nicht die Bezeichnung von der spr_zu verwendet werden
,COALESCE(Max(CASE WHEN v01.saison_id = '' THEN '' WHEN v01.spr_id =  22 THEN v01.saison_bez END), 'N/A') AS saison_bez
,COALESCE(Max(CASE WHEN v01.saison_id = '' THEN '' WHEN v01.spr_id =  22 THEN v01.saison_bez END), 'N/A') AS saison_bez_de
,COALESCE(Max(CASE WHEN v01.saison_id = '' THEN '' WHEN v01.spr_id =  24 THEN v01.saison_bez END), saison_bez_de) AS saison_bez_en
,COALESCE(Max(CASE WHEN v01.saison_id = '' THEN '' WHEN v01.spr_id = 124 THEN v01.saison_bez END), saison_bez_en) AS saison_bez_cz
,COALESCE(Max(CASE WHEN v01.saison_id = '' THEN '' WHEN v01.spr_id = 108 THEN v01.saison_bez END), saison_bez_en) AS saison_bez_sk
,COALESCE(Max(CASE WHEN v01.saison_id = '' THEN '' WHEN v01.spr_id =  65 THEN v01.saison_bez END), saison_bez_en) AS saison_bez_hr
,COALESCE(Max(CASE WHEN v01.saison_id = '' THEN '' WHEN v01.spr_id =  90 THEN v01.saison_bez END), saison_bez_en) AS saison_bez_pl
,COALESCE(Max(CASE WHEN v01.saison_id = '' THEN '' WHEN v01.spr_id =  95 THEN v01.saison_bez END), saison_bez_en) AS saison_bez_ro
,COALESCE(Max(CASE WHEN v01.saison_id = '' THEN '' WHEN v01.spr_id =  18 THEN v01.saison_bez END), saison_bez_en) AS saison_bez_bg
FROM dbp_view.v_saison_spr_zu_1 v01
GROUP BY
 v01.mandant_id
,v01.saison_id
;
