CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WARENBEWEGUNGSTYP_SPR_ZU_1 
-- 14.05.2021, AP0070892, SPEC0086902, dknop, initial
AS 
SELECT
 v01.mandant_id
,v01.warenbewegungstyp_id
,Max(CASE     WHEN v01.spr_id = 22 THEN v01.warenbewegungstyp_bez END) AS warenbewegungstyp_bez                        -- standard == DE
,Max(CASE WHEN v01.spr_id = 22 THEN v01.warenbewegungstyp_bez END) AS warenbewegungstyp_bez_de                                  -- DE
,Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.warenbewegungstyp_bez END),warenbewegungstyp_bez_de) AS warenbewegungstyp_bez_cz    -- CZ
,Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.warenbewegungstyp_bez END),warenbewegungstyp_bez_de) AS warenbewegungstyp_bez_sk    -- SK
,Coalesce(Max(CASE WHEN v01.spr_id =  65 THEN v01.warenbewegungstyp_bez END),warenbewegungstyp_bez_de) AS warenbewegungstyp_bez_hr    -- HR
,Coalesce(Max(CASE WHEN v01.spr_id =  90 THEN v01.warenbewegungstyp_bez END),warenbewegungstyp_bez_de) AS warenbewegungstyp_bez_pl    -- PL
,Coalesce(Max(CASE WHEN v01.spr_id =  95 THEN v01.warenbewegungstyp_bez END),warenbewegungstyp_bez_de) AS warenbewegungstyp_bez_ro    -- RO
,Coalesce(Max(CASE WHEN v01.spr_id =  18 THEN v01.warenbewegungstyp_bez END),warenbewegungstyp_bez_de) AS warenbewegungstyp_bez_b

FROM DBP_VIEW.V_WARENBEWEGUNGSTYP_SPR_ZU_1 v01
group by 
v01.mandant_id,
v01.warenbewegungstyp_id
;