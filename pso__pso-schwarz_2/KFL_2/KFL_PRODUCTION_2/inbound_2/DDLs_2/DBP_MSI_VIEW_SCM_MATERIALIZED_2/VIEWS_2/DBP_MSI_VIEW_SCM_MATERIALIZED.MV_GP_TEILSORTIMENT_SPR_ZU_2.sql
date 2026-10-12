create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_GP_TEILSORTIMENT_SPR_ZU_2(
	MANDANT_ID,
	GP_ID,
	GP_TEILSORTIMENT_ID,
	EINKAUFSORGANISATION_ID,
	GP_TEILSORTIMENT_BEZ,
	GP_TEILSORTIMENT_BEZ_DE,
	GP_TEILSORTIMENT_BEZ_CZ,
	GP_TEILSORTIMENT_BEZ_SK,
	GP_TEILSORTIMENT_BEZ_HR,
	GP_TEILSORTIMENT_BEZ_PL,
	GP_TEILSORTIMENT_BEZ_RO,
	GP_TEILSORTIMENT_BEZ_BG
) as
SELECT
v01.mandant_id
,v01.gp_id
,v01.gp_teilsortiment_id
,v01.einkaufsorganisation_id
,MAX(CASE WHEN v01.spr_id =  22 THEN gp_teilsortiment_bez END) AS gp_teilsortiment_bez                              -- standard == DE
,MAX(CASE WHEN v01.spr_id =  22 THEN gp_teilsortiment_bez END) AS gp_teilsortiment_bez_de                                       -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_bg    -- BG
FROM dbp_view.v_gp_teilsortiment_spr_zu_2 v01
WHERE v01.gp_teilsortiment_id != ''
GROUP BY v01.mandant_id
        ,v01.gp_id
        ,v01.gp_teilsortiment_id
        ,v01.einkaufsorganisation_id
UNION ALL
SELECT
v02.mandant_id
,v02.gp_id
,'' AS gp_teilsortiment_id
,v02.einkaufsorganisation_id
,'leer/empty' AS gp_teilsortiment_bez                              -- standard == DE
,'leer/empty' AS gp_teilsortiment_bez_de                                       -- DE
,'leer/empty' AS gp_teilsortiment_bez_cz    -- CZ
,'leer/empty' AS gp_teilsortiment_bez_sk    -- SK
,'leer/empty' AS gp_teilsortiment_bez_hr    -- HR
,'leer/empty' AS gp_teilsortiment_bez_pl    -- PL
,'leer/empty' AS gp_teilsortiment_bez_ro    -- RO
,'leer/empty' AS gp_teilsortiment_bez_bg    -- BG
FROM dbp_view.v_gp_2 v02;