CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TRANSPORT_GV_SPR_ZU(
	TRANSPORT_GV_ID,
	TRANSPORT_GV_BEZ,
	TRANSPORT_GV_BEZ_DE,
	TRANSPORT_GV_BEZ_CZ,
	TRANSPORT_GV_BEZ_SK,
	TRANSPORT_GV_BEZ_HR,
	TRANSPORT_GV_BEZ_PL,
	TRANSPORT_GV_BEZ_RO,
	TRANSPORT_GV_BEZ_BG,
	EWM_FG
)  AS
-- 2022-10-07, AP0145540, SPEC0169641, initial, dknop
 --2023-07-07, adding ewm_fg

SELECT 
 CAST(v01.transport_gv_id AS VARCHAR(18)) AS transport_gv_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.transport_gv_bez END) AS transport_gv_bez                  -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.transport_gv_bez END) AS transport_gv_bez_de                           -- DE
,MAX(CASE WHEN v01.spr_id = 124 THEN v01.transport_gv_bez END) AS transport_gv_bezz_cz    -- CZ
,MAX(CASE WHEN v01.spr_id = 108 THEN v01.transport_gv_bez END) AS transport_gv_bez_sk    -- SK
,MAX(CASE WHEN v01.spr_id = 65 THEN v01.transport_gv_bez END) AS transport_gv_bez_hr    -- HR
,MAX(CASE WHEN v01.spr_id = 90 THEN v01.transport_gv_bez END) AS transport_gv_bez_pl    -- PL
,MAX(CASE WHEN v01.spr_id = 95 THEN v01.transport_gv_bez END) AS transport_gv_bez_ro    -- RO
,MAX(CASE WHEN v01.spr_id = 18 THEN v01.transport_gv_bez END) AS transport_gv_bez_bg    -- BG
,0 AS ewm_fg
FROM dbp_view.v_transport_gv_spr_zu v01
GROUP BY v01.transport_gv_id

UNION

SELECT 
 CAST(v01.ewm_gv_id AS VARCHAR(18)) AS ewm_gv_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.ewm_gv_bez END) AS ewm_gv_bez                  -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.ewm_gv_bez END) AS ewm_gv_bez_de                           -- DE
,MAX(CASE WHEN v01.spr_id = 124 THEN v01.ewm_gv_bez END) AS ewm_gv_bez_cz    -- CZ
,MAX(CASE WHEN v01.spr_id = 108 THEN v01.ewm_gv_bez END) AS ewm_gv_bez_sk    -- SK
,MAX(CASE WHEN v01.spr_id = 65 THEN v01.ewm_gv_bez END) AS ewm_gv_bez_hr    -- HR
,MAX(CASE WHEN v01.spr_id = 90 THEN v01.ewm_gv_bez END) AS ewm_gv_bez_pl    -- PL
,MAX(CASE WHEN v01.spr_id = 95 THEN v01.ewm_gv_bez END) AS ewm_gv_bez_ro    -- RO
,MAX(CASE WHEN v01.spr_id = 18 THEN v01.ewm_gv_bez END) AS ewm_gv_bez_bg    -- BG
,1 AS ewm_fg
FROM dbp_view.v_ewm_geschaeftsvorfall_spr_zu v01
GROUP BY v01.ewm_gv_id



;