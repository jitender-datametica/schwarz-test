create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WARENBEWEGUNGSTYP_SPR_ZU(
	MANDANT_ID,
	WARENBEWEGUNGSTYP_ID,
	WARENBEWEGUNGSTYP_BEZ,
	WARENBEWEGUNGSTYP_BEZ_DE,
	WARENBEWEGUNGSTYP_BEZ_CZ,
	WARENBEWEGUNGSTYP_BEZ_SK,
	WARENBEWEGUNGSTYP_BEZ_HR,
	WARENBEWEGUNGSTYP_BEZ_PL,
	WARENBEWEGUNGSTYP_BEZ_RO,
	WARENBEWEGUNGSTYP_BEZ_B
) as 
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

FROM DBP_VIEW.V_WARENBEWEGUNGSTYP_SPR_ZU v01
group by 
v01.mandant_id,
v01.warenbewegungstyp_id;