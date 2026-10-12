create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_LAGER_BEWART_SPR_ZU_2(
	MANDANT_ID,
	LAGER_BEWART_ID,
	LAGER_BEWART_BEZ,
	LAGER_BEWART_BEZ_DE,
	LAGER_BEWART_BEZ_CZ,
	LAGER_BEWART_BEZ_SK,
	LAGER_BEWART_BEZ_HR,
	LAGER_BEWART_BEZ_PL,
	LAGER_BEWART_BEZ_RO,
	LAGER_BEWART_BEZ_BG
) as
SELECT
 v01.mandant_id
,v01.lager_bewart_id
,MAX(CASE WHEN v01.spr_id =  22 THEN lager_bewart_bez END) AS lager_bewart_bez                          -- standard == DE
,MAX(CASE WHEN v01.spr_id =  22 THEN lager_bewart_bez END) AS lager_bewart_bez_de                                   -- DE
,COALESCE(MAX(CASE WHEN v01.spr_id = 124 THEN lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v01.spr_id = 108 THEN lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v01.spr_id =  65 THEN lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v01.spr_id =  90 THEN lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v01.spr_id =  95 THEN lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v01.spr_id =  18 THEN lager_bewart_bez END), lager_bewart_bez_de) AS lager_bewart_bez_bg    -- BG
FROM DBP_VIEW.v_lager_bewart_spr_zu_2 v01
--keine Beruecksichtigung der SAP-Industriesysteme fuer DE + CZ
WHERE v01.system_id NOT IN (2,17,28,32,48,53)
GROUP BY v01.mandant_id
        ,v01.lager_bewart_id;