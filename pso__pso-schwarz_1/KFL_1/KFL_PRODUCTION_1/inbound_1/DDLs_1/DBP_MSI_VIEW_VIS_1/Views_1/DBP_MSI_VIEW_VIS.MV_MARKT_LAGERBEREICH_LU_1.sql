CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MARKT_LAGERBEREICH_LU_1 (
	MANDANT_ID,
	MARKT_LAGERBEREICH_ID,
	MARKT_LAGERBEREICH_BEZ_DE,
	MARKT_LAGERBEREICH_BEZ_CZ,
	MARKT_LAGERBEREICH_BEZ_SK,
	MARKT_LAGERBEREICH_BEZ_HR,
	MARKT_LAGERBEREICH_BEZ_PL,
	MARKT_LAGERBEREICH_BEZ_RO,
	MARKT_LAGERBEREICH_BEZ_BG,
	MARKT_LAGERBEREICH_BEZ
) AS

/*
	LOOKUP/SPRACHE : Lagerbereich in Filiale 
	Einträge sind landesspezifisch (aktuell nur in Landessprache vorhanden)
	2025-09-01 ssch0611 : Initial [AP0263148]
*/

WITH sprache AS (
	/* Landesspezifisch = Transformation Sprachen in Spalten pro Land_1 ohne Gruppierung  */
	SELECT mandant_id
		, markt_lagerbereich_id                           AS id
		, IFF(spr_id =  22, markt_lagerbereich_bez, NULL) AS de
		, IFF(spr_id = 124, markt_lagerbereich_bez, NULL) AS cz
		, IFF(spr_id = 108, markt_lagerbereich_bez, NULL) AS sk
		, IFF(spr_id =  65, markt_lagerbereich_bez, NULL) AS hr
		, IFF(spr_id =  90, markt_lagerbereich_bez, NULL) AS pl
		, IFF(spr_id =  95, markt_lagerbereich_bez, NULL) AS ro
		, IFF(spr_id =  18, markt_lagerbereich_bez, NULL) AS bg
	FROM DBP_VIEW.V_MARKT_LAGERBEREICH_SPR_ZU_1 
)
, lookup AS (
	/* Landesspezifisch = ohne Gruppierung */
	SELECT mandant_id
		, markt_lagerbereich_id AS id
	FROM DBP_VIEW.V_L_MARKT_LAGERBEREICH_1 
)


SELECT lookup.mandant_id
	, lookup.id                                                                                         AS markt_lagerbereich_id
	, COALESCE(sprache.de, sprache.cz, sprache.sk, sprache.hr, sprache.pl, sprache.ro, sprache.bg, '-') AS markt_lagerbereich_bez_de
	, COALESCE(sprache.cz, sprache.de, sprache.sk, sprache.hr, sprache.pl, sprache.ro, sprache.bg, '-') AS markt_lagerbereich_bez_cz
	, COALESCE(sprache.sk, sprache.de, sprache.cz, sprache.hr, sprache.pl, sprache.ro, sprache.bg, '-') AS markt_lagerbereich_bez_sk
	, COALESCE(sprache.hr, sprache.de, sprache.cz, sprache.sk, sprache.pl, sprache.ro, sprache.bg, '-') AS markt_lagerbereich_bez_hr
	, COALESCE(sprache.pl, sprache.de, sprache.cz, sprache.sk, sprache.hr, sprache.ro, sprache.bg, '-') AS markt_lagerbereich_bez_pl
	, COALESCE(sprache.ro, sprache.de, sprache.cz, sprache.sk, sprache.hr, sprache.pl, sprache.bg, '-') AS markt_lagerbereich_bez_ro
	, COALESCE(sprache.bg, sprache.de, sprache.cz, sprache.sk, sprache.hr, sprache.pl, sprache.ro, '-') AS markt_lagerbereich_bez_bg
	, markt_lagerbereich_bez_de                                                                         AS markt_lagerbereich_bez -- default
FROM lookup

LEFT JOIN sprache 
ON sprache.mandant_id = lookup.mandant_id AND sprache.id = lookup.id
;