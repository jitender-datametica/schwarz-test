CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MARKT_VERRAEUMUNG_PRIO_GRUND_LU (
	VERRAEUMUNG_PRIO_GRUND_ID,
	VERRAEUMUNG_PRIO_GRUND_BEZ_DE,
	VERRAEUMUNG_PRIO_GRUND_BEZ_CZ,
	VERRAEUMUNG_PRIO_GRUND_BEZ_SK,
	VERRAEUMUNG_PRIO_GRUND_BEZ_HR,
	VERRAEUMUNG_PRIO_GRUND_BEZ_PL,
	VERRAEUMUNG_PRIO_GRUND_BEZ_RO,
	VERRAEUMUNG_PRIO_GRUND_BEZ_BG,
	VERRAEUMUNG_PRIO_GRUND_BEZ
) AS

/*
	LOOKUP/SPRACHE : Prio Gründe Veräumung im Markt
	Einträge sind länderübergreifend (aktuell nur in deutsch vorhanden)
	2025-09-01 ssch0611 : Initial [AP0263148]
*/

WITH sprache AS (
	/* länderübergreifend = Transformation Sprachen in Spalten und Gruppierung */
	SELECT verraeumung_prio_grund_id                          AS id
		, IFF(spr_id =  22, verraeumung_prio_grund_bez, NULL) AS de
		, IFF(spr_id = 124, verraeumung_prio_grund_bez, NULL) AS cz
		, IFF(spr_id = 108, verraeumung_prio_grund_bez, NULL) AS sk
		, IFF(spr_id =  65, verraeumung_prio_grund_bez, NULL) AS hr
		, IFF(spr_id =  90, verraeumung_prio_grund_bez, NULL) AS pl
		, IFF(spr_id =  95, verraeumung_prio_grund_bez, NULL) AS ro
		, IFF(spr_id =  18, verraeumung_prio_grund_bez, NULL) AS bg
	FROM DBP_VIEW.V_MARKT_VERRAEUMUNG_PRIO_GRUND_SPR_ZU 
	GROUP BY ALL
)
, lookup AS (
	/* länderübergreifend = Grupppierung */
	SELECT verraeumung_prio_grund_id AS id
	FROM DBP_VIEW.V_L_MARKT_VERRAEUMUNG_PRIO_GRUND
	GROUP BY ALL
)


SELECT lookup.id                                                                                        AS verraeumung_prio_grund_id
	, COALESCE(sprache.de, sprache.cz, sprache.sk, sprache.hr, sprache.pl, sprache.ro, sprache.bg, '-') AS verraeumung_prio_grund_bez_de
	, COALESCE(sprache.cz, sprache.de, sprache.sk, sprache.hr, sprache.pl, sprache.ro, sprache.bg, '-') AS verraeumung_prio_grund_bez_cz
	, COALESCE(sprache.sk, sprache.de, sprache.cz, sprache.hr, sprache.pl, sprache.ro, sprache.bg, '-') AS verraeumung_prio_grund_bez_sk
	, COALESCE(sprache.hr, sprache.de, sprache.cz, sprache.sk, sprache.pl, sprache.ro, sprache.bg, '-') AS verraeumung_prio_grund_bez_hr
	, COALESCE(sprache.pl, sprache.de, sprache.cz, sprache.sk, sprache.hr, sprache.ro, sprache.bg, '-') AS verraeumung_prio_grund_bez_pl
	, COALESCE(sprache.ro, sprache.de, sprache.cz, sprache.sk, sprache.hr, sprache.pl, sprache.bg, '-') AS verraeumung_prio_grund_bez_ro
	, COALESCE(sprache.bg, sprache.de, sprache.cz, sprache.sk, sprache.hr, sprache.pl, sprache.ro, '-') AS verraeumung_prio_grund_bez_bg
	, verraeumung_prio_grund_bez_de                                                                     AS verraeumung_prio_grund_bez -- default
FROM lookup

LEFT JOIN sprache 
ON sprache.id = lookup.id
;