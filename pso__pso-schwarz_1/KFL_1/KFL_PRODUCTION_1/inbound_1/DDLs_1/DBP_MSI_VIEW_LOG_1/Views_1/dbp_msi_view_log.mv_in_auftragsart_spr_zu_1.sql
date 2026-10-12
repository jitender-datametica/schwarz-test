CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_AUFTRAGSART_SPR_ZU_1(
	AUFTRAGSART_ID,
	AUFTRAGSART_BEZ,
	AUFTRAGSART_BEZ_DE,
	AUFTRAGSART_BEZ_CZ,
	AUFTRAGSART_BEZ_SK,
	AUFTRAGSART_BEZ_HR,
	AUFTRAGSART_BEZ_PL,
	AUFTRAGSART_BEZ_RO,
	AUFTRAGSART_BEZ_B
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial
--2023-01-02, AP0153902_SPEC0181369,dknop, adding dummy_1 records
SELECT

 v01.auftragsart_id
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.auftragsart_bez END) AS auftragsart_bez                        -- standard == DE
,MAX(CASE WHEN v01.spr_id = 22 THEN v01.auftragsart_bez END) AS auftragsart_bez_de                                 -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN v01.auftragsart_bez END),auftragsart_bez_de) AS auftragsart_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN v01.auftragsart_bez END),auftragsart_bez_de) AS auftragsart_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN v01.auftragsart_bez END),auftragsart_bez_de) AS auftragsart_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN v01.auftragsart_bez END),auftragsart_bez_de) AS auftragsart_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN v01.auftragsart_bez END),auftragsart_bez_de) AS auftragsart_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN v01.auftragsart_bez END),auftragsart_bez_de) AS auftragsart_bez_b

FROM dbp_view.v_in_auftragsart_spr_zu_1 v01

GROUP BY v01.auftragsart_id

UNION
SELECT
 '-1'
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
,NULL
;