create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ARTKZ_LOESCH_PROMPT_1(
	LOESCH_ID,
	LOESCH_BEZ,
	LOESCH_BEZ_DE,
	LOESCH_BEZ_CZ,
	LOESCH_BEZ_SK,
	LOESCH_BEZ_HR,
	LOESCH_BEZ_PL,
	LOESCH_BEZ_RO,
	LOESCH_BEZ_BG
) as 
SELECT 
  v01.loesch_id
  , MAX(CASE WHEN (v01.spr_id = 22 AND NOT loesch_id = ' ') THEN loesch_bez WHEN (v01.spr_id = 22 AND loesch_id = ' ') THEN 'leer/empty' END) AS loesch_bez                 -- standard == DE
  , MAX(CASE WHEN (v01.spr_id = 22 AND NOT loesch_id = ' ') THEN loesch_bez WHEN (v01.spr_id = 22 AND loesch_id = ' ') THEN 'leer/empty' END) AS loesch_bez_de                          -- DE
  , COALESCE(MAX(CASE WHEN (v01.spr_id = 124 AND NOT loesch_id = ' ') THEN loesch_bez WHEN (v01.spr_id = 124 AND loesch_id=' ') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_cz   -- CZ
  , COALESCE(MAX(CASE WHEN (v01.spr_id = 108 AND NOT loesch_id = ' ') THEN loesch_bez WHEN (v01.spr_id =  108 AND loesch_id=' ') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_sk  -- SK
  , COALESCE(MAX(CASE WHEN (v01.spr_id =  65 AND NOT loesch_id = ' ') THEN loesch_bez WHEN (v01.spr_id =  65 AND loesch_id=' ') THEN 'leer/empty'  END), loesch_bez_de) AS loesch_bez_hr   -- HR
  , COALESCE(MAX(CASE WHEN (v01.spr_id =  90 AND NOT loesch_id = ' ') THEN loesch_bez WHEN (v01.spr_id =  90 AND loesch_id=' ') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_pl    -- PL
  , COALESCE(MAX(CASE WHEN (v01.spr_id =  95 AND NOT loesch_id = ' ') THEN loesch_bez WHEN (v01.spr_id =  95 AND loesch_id=' ') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_ro    -- RO
  , COALESCE(MAX(CASE WHEN (v01.spr_id =  18 AND NOT loesch_id = ' ') THEN loesch_bez WHEN (v01.spr_id =  18 AND loesch_id=' ') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_bg    -- BG
FROM DBP_VIEW.v_artkz_loesch_1 v01
JOIN DBP_VIEW.v_mandant_spr_zu_1 v02 
  ON v01.mandant_id = v02.mandant_id 
 AND v01.spr_id = v02.spr_id
GROUP BY v01.loesch_id
  
UNION ALL

SELECT 
  ' ' AS loesch_id
, 'leer/empty' AS loesch_bez       -- standard == DE
, 'leer/empty' AS loesch_bez_de  
, 'leer/empty' AS loesch_bez_cz    -- CZ
, 'leer/empty' AS loesch_bez_sk    -- SK
, 'leer/empty' AS loesch_bez_hr    -- HR
, 'leer/empty' AS loesch_bez_pl    -- PL
, 'leer/empty' AS loesch_bez_ro    -- RO
, 'leer/empty' AS loesch_bez_bg    -- BG
FROM DBP_VIEW.v_mandant_1 v02
GROUP BY ' ';