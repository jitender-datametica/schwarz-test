CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TOURART_SUBTYP_SPR_ZU_1(
	TOURART_SUBTYP_ID,
	TOURART_SUBTYP_BEZ,
	TOURART_SUBTYP_BEZ_DE,
	TOURART_SUBTYP_BEZ_CZ,
	TOURART_SUBTYP_BEZ_SK,
	TOURART_SUBTYP_BEZ_HR,
	TOURART_SUBTYP_BEZ_PL,
	TOURART_SUBTYP_BEZ_RO,
	TOURART_SUBTYP_BEZ_B)
--01.03.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_1
--10-05-2022, AP0125093, dknop,removing mandant_id
AS
SELECT
 --v01.mandant_id
 v01.tourart_subtyp_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.tourart_subtyp_bez END) AS tourart_subtyp_bez                        -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.tourart_subtyp_bez END) AS tourart_subtyp_bez_de                                 -- DE
,MAX(CASE WHEN v01.spr_id = 124 THEN v01.tourart_subtyp_bez END) AS tourart_subtyp_bez_cz    -- CZ
,MAX(CASE WHEN v01.spr_id = 108 THEN v01.tourart_subtyp_bez END) AS tourart_subtyp_bez_sk    -- SK
,MAX(CASE WHEN v01.spr_id =  65 THEN v01.tourart_subtyp_bez END) AS tourart_subtyp_bez_hr    -- HR
,MAX(CASE WHEN v01.spr_id =  90 THEN v01.tourart_subtyp_bez END) AS tourart_subtyp_bez_pl    -- PL
,MAX(CASE WHEN v01.spr_id =  95 THEN v01.tourart_subtyp_bez END) AS tourart_subtyp_bez_ro    -- RO
,MAX(CASE WHEN v01.spr_id =  18 THEN v01.tourart_subtyp_bez END) AS tourart_subtyp_bez_b
FROM dbp_view.v_tourart_subtyp_spr_zu_1 v01

GROUP BY 
 v01.tourart_subtyp_id
--,v01.mandant_id
;