CREATE OR REPLACE VIEW dbp_msi_view_log.mv_belos_tourart_spr_zu(
	BELOS_TOURART_ID,
	BELOS_TOURART_BEZ,
	BELOS_TOURART_BEZ_DE,
	BELOS_TOURART_BEZ_CZ,
	BELOS_TOURART_BEZ_SK,
	BELOS_TOURART_BEZ_HR,
	BELOS_TOURART_BEZ_PL,
	BELOS_TOURART_BEZ_RO,
	BELOS_TOURART_BEZ_B
)
--01.03.2021, SPEC0091861, AP0073899, dknop, initiale Anlage
-- 10-05-2022, AP0125093, dknop,removing mandant_id 
--2025-09-19, INC11667931, nwag2310, typo corrected
AS
SELECT
 --v01.mandant_id
 v01.belos_tourart_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.belos_tourart_bez END) AS belos_tourart_bez                        -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.belos_tourart_bez END) AS belos_tourart_bez_de                                 -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.belos_tourart_bez END),belos_tourart_bez_de) AS belos_tourart_bez_bg    -- BG
FROM dbp_view.v_belos_tourart_spr_zu v01

GROUP BY v01.belos_tourart_id
--v01.mandant_id
;