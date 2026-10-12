CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_SCM_BEREICH_SPR_ZU_1(
	MANDANT_ID,
	SCM_BEREICH_ID,
	SCM_BEREICH_BEZ,
	SCM_BEREICH_BEZ_DE,
	SCM_BEREICH_BEZ_CZ,
	SCM_BEREICH_BEZ_SK,
	SCM_BEREICH_BEZ_HR,
	SCM_BEREICH_BEZ_PL,
	SCM_BEREICH_BEZ_RO,
	SCM_BEREICH_BEZ_B
) AS
--AP0182383, SPEC0207712, knop, initial
SELECT
 MANDANT_ID
,WG_HIERARCHIE_ID AS scm_bereich_id
,MAX(CASE WHEN spr_id=22 THEN WG_HIERARCHIE_bez END) AS scm_bereich_bez -- standard == DE
,MAX(CASE WHEN spr_id=22 THEN WG_HIERARCHIE_bez END) AS scm_bereich_bez_de                                 -- DE
,COALESCE(MAX(CASE WHEN spr_id = 124 THEN WG_HIERARCHIE_bez END),scm_bereich_bez_de) AS scm_bereich_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN spr_id = 108 THEN WG_HIERARCHIE_bez END),scm_bereich_bez_de) AS scm_bereich_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN spr_id =  65 THEN WG_HIERARCHIE_bez END),scm_bereich_bez_de) AS scm_bereich_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN spr_id =  90 THEN WG_HIERARCHIE_bez END),scm_bereich_bez_de) AS scm_bereich_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN spr_id =  95 THEN WG_HIERARCHIE_bez END),scm_bereich_bez_de) AS scm_bereich_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN spr_id =  18 THEN WG_HIERARCHIE_bez END),scm_bereich_bez_de) AS scm_bereich_bez_b  --B

FROM dbp_view.v_WG_HIERARCHIE_SPR_ZU_1 WHERE ARTHIERTYP_ID=12 AND WG_HIERARCHIE_EBENE_ID=1
GROUP BY MANDANT_ID,WG_HIERARCHIE_ID/*, WG_HIERARCHIE_bez*/;