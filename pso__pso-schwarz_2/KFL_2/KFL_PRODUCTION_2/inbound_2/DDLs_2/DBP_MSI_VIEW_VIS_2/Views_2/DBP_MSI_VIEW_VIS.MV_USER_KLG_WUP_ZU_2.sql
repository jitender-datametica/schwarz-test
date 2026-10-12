CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_USER_KLG_WUP_ZU_2(
	ROLLE,
	USER_KLG_ID,
	MEIN_BEREICH_FG,
	MANDANT_ID,
	WUP_ID
) AS

/*
	SECURITY : USER_KLG_WUP_ZU
	Sicht auf Kollegen auf Basis user_vis_benchmark_zu_2: 
	HL_2 + SV > VKL_2, VKL_2 > GF_2, GF_2 > GL (Region_2) , GL > GLV (Land_2)
	WBL_2 (cvd, ka, kawbl, kaek, fl, flwbl, fo, fowbl, nf) unverändert mit Security Filiale
	nationalen und internationalen User (land_2) unverändert mit Eintrag aus user_wup_zu_2
	2025-07-15 ssch0611 : Initial Security Kollegen > SBK [AP0283329]
	2025-08-18 ssch0611 : Erweiterung Kollegen auf SV
*/


/* CTE : Basisabfragen */

WITH
  wup_basis AS (
	/* Basisabfrage : Marktstammdaten */
	SELECT wd.mandant_id
		, wd.wup_id
		, wp.vs_id
		, wp.land_id
		, wp.wup_standort
		, wp.dat_von
		, wp.dat_eroeffnung
		, wp.dat_bis
		, wd.vkl_id             AS vkl_id
		, wd.gf_gbl_vertrieb_id AS gf_id
		, wd.gl_vertrieb_id     AS gl_id
		, wd.glv_land_id        AS glv_id
	FROM dbp_msi_data.wup_denorm_2 wd
	INNER JOIN dbp_data.wup_2 wp
		ON wp.mandant_id = wd.mandant_id AND wp.wup_id = wd.wup_id
	WHERE wp.nb_id IN (-1, 0) AND wd.glv_land_id > 0 
)

, user_bm AS (
	/* Basisabfrage > Zuordnung der Security aus user_vis_benchmark_zu_2 */
	SELECT LOWER(user_id) AS user_klg_id
		, mandant_id
		, hierarchie_element_id
		, LOWER(hierarchie_ebene_id) hierarchie_ebene_id
		, RIGHT(user_klg_id, 2) AS fil_user
		, CASE fil_user 
			WHEN 'hl_2' THEN 1
			WHEN 'sv' THEN 2
			ELSE 0 
		  END AS klg_fg -- Kollegen Sicht für HL_2 + SV (DE)
	FROM dbp_msi_data.user_vis_benchmark_zu_2
)

, user_wup AS (
	/* Basisabfrage > Zuordnung der Security aus user_wup_zu_2 */
	SELECT LOWER(user_id) AS user_klg_id
		, mandant_id
		, wup_id
	FROM dbp_msi_data.user_wup_zu_2
)


/* MAIN */

/* 1 Vertriebsuser (cvd, ka, kawbl, kaek, fl, flwbl, fo, fowbl, nf) mit Standardsicht Filiale */
SELECT '010 HL_2 (WBL_2)' AS rolle
	, ubm.user_klg_id
	, 1 ::INTEGER AS mein_bereich_fg
	, ubm.mandant_id
	, wup.wup_id
FROM user_bm ubm 
INNER JOIN wup_basis wup_2 
	ON wup.mandant_id = ubm.mandant_id AND wup.wup_id = ubm.hierarchie_element_id
WHERE ubm.hierarchie_ebene_id = 'hl_2' AND klg_fg = 0

/* 2 - Vertriebsuser (HL_2, SV, VKL_2, GF_2, GL) mit Kollegensicht */
UNION 
SELECT '020 VKL_2 (HL_2)' AS rolle
	, ubm.user_klg_id
	, IFF(ubm.hierarchie_element_id = wup.wup_id, 1, 0) ::INTEGER AS mein_bereich_fg -- eigene Filiale 
	, ubm.mandant_id
	, wup.wup_id
FROM user_bm ubm 
INNER JOIN wup_basis klg -- eigene Filiale
	ON klg.mandant_id = ubm.mandant_id AND klg.wup_id = ubm.hierarchie_element_id 
LEFT JOIN wup_basis wup_2 -- Alle Filialen des VKL_2
	ON wup.mandant_id = klg.mandant_id AND wup.vkl_id = klg.vkl_id
WHERE ubm.hierarchie_ebene_id = 'hl_2' AND klg_fg = 1

UNION 
SELECT '020 VKL_2 (SV)' AS rolle
	, ubm.user_klg_id
	, IFF(ubm.hierarchie_element_id = wup.wup_id, 1, 0) ::INTEGER AS mein_bereich_fg -- eigene Filiale 
	, ubm.mandant_id
	, wup.wup_id
FROM user_bm ubm 
INNER JOIN wup_basis klg -- eigene Filiale
	ON klg.mandant_id = ubm.mandant_id AND klg.wup_id = ubm.hierarchie_element_id 
LEFT JOIN wup_basis wup_2 -- Alle Filialen des VKL_2
	ON wup.mandant_id = klg.mandant_id AND wup.vkl_id = klg.vkl_id
WHERE ubm.hierarchie_ebene_id = 'hl_2' AND klg_fg = 2

UNION
SELECT '030 GF_2 (VKL_2)' AS rolle
	, ubm.user_klg_id
	, IFF(ubm.hierarchie_element_id = wup.vkl_id, 1, 0) ::INTEGER AS mein_bereich_fg -- eigener VKL_2 Bereich
	, ubm.mandant_id
	, wup.wup_id
FROM user_bm ubm 
INNER JOIN wup_basis klg -- eigener VKL_2 Bereich
	ON klg.mandant_id = ubm.mandant_id AND klg.vkl_id = ubm.hierarchie_element_id
LEFT JOIN wup_basis wup_2 -- Alles Filialen des GF_2
	ON wup.mandant_id = klg.mandant_id AND wup.gf_id = klg.gf_id
WHERE ubm.hierarchie_ebene_id = 'vkl_2'

UNION
SELECT '040 GL (GF_2)' AS rolle
	, ubm.user_klg_id
	, IFF(ubm.hierarchie_element_id = wup.gf_id, 1, 0) ::INTEGER AS mein_bereich_fg -- eigener GF_2 Bereich
	, ubm.mandant_id
	, wup.wup_id
FROM user_bm ubm 
INNER JOIN wup_basis klg -- eigener GF_2 Bereich
	ON klg.mandant_id = ubm.mandant_id AND klg.gf_id = ubm.hierarchie_element_id
LEFT JOIN wup_basis wup_2 -- Alle Filialen de Region_2 (GL Bereich)
	ON wup.mandant_id = klg.mandant_id AND wup.vs_id = klg.vs_id
WHERE ubm.hierarchie_ebene_id = 'gf_2'

UNION
SELECT '050 GLV (GL)' AS rolle
	, ubm.user_klg_id
	, IFF(ubm.hierarchie_element_id = wup.vs_id, 1, 0) ::INTEGER AS mein_bereich_fg -- Eigene Region_2 (GL Bereich)
	, ubm.mandant_id
	, wup.wup_id
FROM user_bm ubm 
LEFT JOIN wup_basis wup_2 -- Alle Filialen des Landes (GLV Bereich)
	ON wup.mandant_id = ubm.mandant_id 
WHERE ubm.hierarchie_ebene_id = 'vs_2'

/* 3 - Alle nationalen und internationale User aus user_wup_zu_2 */
UNION
SELECT IFF(anz_land < 8, '050 NAT', '060 INT') AS rolle
	, uwz.user_klg_id
	, 1 ::INTEGER AS mein_bereich_fg
	, uwz.mandant_id
	, uwz.wup_id
FROM user_wup uwz 
INNER JOIN (
	SELECT user_klg_id
		, COUNT(DISTINCT mandant_id) AS anz_land 
	FROM user_bm
	WHERE hierarchie_ebene_id = 'land_2'
	GROUP BY user_klg_id
) ubm
ON ubm.user_klg_id = uwz.user_klg_id
;