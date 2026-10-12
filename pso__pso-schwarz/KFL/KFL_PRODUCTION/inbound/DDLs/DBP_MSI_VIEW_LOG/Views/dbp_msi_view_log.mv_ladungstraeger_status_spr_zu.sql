CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.mv_ladungstraeger_status_spr_zu
AS
--2022.02.16, AP0081637, SPEC0123461, dknop, initial

SELECT 
 ladungstraeger_status_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.ladungstraeger_status_bez END) AS ladungstraeger_status_bez                        -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.ladungstraeger_status_bez END) AS ladungstraeger_status_bez_de                                  -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.ladungstraeger_status_bez END),ladungstraeger_status_bez_de) AS ladungstraeger_status_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.ladungstraeger_status_bez END),ladungstraeger_status_bez_de) AS ladungstraeger_status_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.ladungstraeger_status_bez END),ladungstraeger_status_bez_de) AS ladungstraeger_status_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.ladungstraeger_status_bez END),ladungstraeger_status_bez_de) AS ladungstraeger_status_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.ladungstraeger_status_bez END),ladungstraeger_status_bez_de) AS ladungstraeger_status_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.ladungstraeger_status_bez END),ladungstraeger_status_bez_de) AS ladungstraeger_status_bez_bg    -- BG
FROM  dbp_view.v_ladungstraeger_status_spr_zu v01
GROUP BY v01.ladungstraeger_status_id;