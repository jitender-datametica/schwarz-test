CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VERRECHNUNGSART_SPR_ZU_1
--21-06-2021, AP0091617, SPEC0113162, initial, dknop

AS
SELECT
 v01.mandant_id              
,v01.verrechnungsart_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.verrechnungsart_bez END) AS verrechnungsart_bez                        -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.verrechnungsart_bez END) AS verrechnungsart_bez_de                                  -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.verrechnungsart_bez END),verrechnungsart_bez_de) AS verrechnungsart_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.verrechnungsart_bez END),verrechnungsart_bez_de) AS verrechnungsart_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.verrechnungsart_bez END),verrechnungsart_bez_de) AS verrechnungsart_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.verrechnungsart_bez END),verrechnungsart_bez_de) AS verrechnungsart_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.verrechnungsart_bez END),verrechnungsart_bez_de) AS verrechnungsart_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.verrechnungsart_bez END),verrechnungsart_bez_de) AS verrechnungsart_bez_bez_b
					
FROM dbp_view.v_verrechnungsart_spr_zu_1 v01

GROUP BY v01.verrechnungsart_id,
v01.mandant_id;