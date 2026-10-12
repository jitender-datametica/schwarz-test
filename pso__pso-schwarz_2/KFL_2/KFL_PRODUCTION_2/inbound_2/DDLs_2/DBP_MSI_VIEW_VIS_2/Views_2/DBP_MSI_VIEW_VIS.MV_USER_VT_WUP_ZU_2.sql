CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_USER_VT_WUP_ZU_2(
	ROLLE,
	USER_VT_ID,
	USER_VT_NAME,
	USER_VT_VORNAME,
	MANDANT_ID,
	WUP_ID
) AS

/*
	SECURITY : USER_VT_WUP_ZU
	Sicht auf Vertriebshierarchie (SAP SRS/MA/WUP_2) HL_2, VKL_2, GF_2, GL, GLV (ohne WBL_2 User)
	Ausgewählte Zentraluser mit Standard Security (user_wup_zu_2)
	2025-07-15 ssch0611 : Initial. Security für SBK/Schädlingbekämpfung [AP0283329]
	2025-08-21 ssch0611 : Userliste Zentraluser ergänzt
	2025-09-08 ssch0611 : Zentraluser hinzugefügt. Zentraluser müssen in mSTR Gruppe_2 "VIS 92 Sonderberichte - SBK" aufgenommen werden!
	2025-10-09 ssch0611 : Review CTE zentral_user + weitere Zentraluser ergänzt
	
*/


/* CTE : Basisabfragen */

WITH ma_basis AS (
	/* Basisabfrage : Mitarbeiterdaten */
	SELECT mas.mandant_id, mas.ma_id, lma.ma_funktion_id
	, LOWER(mas.ma_ldap) AS ma_ldap, mas.ma_vorname, mas.ma_name, mas.email
	FROM DBP_DATA.MA_SPR_ZU_2 mas
	JOIN DBP_DATA.L_MA_2 lma
	ON lma.ma_id = mas.ma_id AND lma.mandant_id = mas.mandant_id
	WHERE mas.spr_id = 22
)

, wup_basis AS (
	/* Basisabfrage : Marktstammdaten */
	SELECT wd.mandant_id, wd.wup_id, wp.land_id, wp.wup_standort
	, wp.dat_von, wp.dat_eroeffnung, wp.dat_bis
	, wd.vkl_id             AS vkl_id
	, wd.gf_gbl_vertrieb_id AS gf_id
	, wd.gl_vertrieb_id     AS gl_id
	, wd.glv_land_id        AS glv_id
	FROM dbp_msi_data.wup_denorm_2 wd
	INNER JOIN dbp_data.wup_2 wp
	ON wp.mandant_id = wd.mandant_id AND wp.wup_id = wd.wup_id
	WHERE wp.nb_id IN (-1, 0) AND wd.glv_land_id > 0 
)

, user_wup AS (
	/* Basisabfrage : Zuordnung der Security aus user_wup_zu_2 */
	SELECT LOWER(user_id) AS user_vt_id , mandant_id, wup_id
	FROM dbp_msi_data.user_wup_zu_2
)

, zentral_user AS (
	/* Zentraluser (Userliste) mit Standard Security (user_wup_zu_2) */
	SELECT $1 AS rolle 
		, $2 AS user_vt_id
		, $3 AS user_vt_vorname
		, $4 AS user_vt_name
	FROM (
		/* User SIT */
		SELECT           '900 SIT', 'adminkis',     'Funktionsuser', 'SIT'
		UNION ALL SELECT '900 SIT', 'ssch0611',     'Stefan', 'Schmidt'
		UNION ALL SELECT '900 SIT', 'tekin',        'Fikri', 'Tekin'
		UNION ALL SELECT '900 SIT', 'moreno_copad', 'Florian', 'Moreno Copado'
		UNION ALL SELECT '900 SIT', 'zemanns' ,     'Simon', 'Zemann'
		/* User Vertrieb INT + DE */
		UNION ALL SELECT '100 VT', 'mste1112',  'Marco', 'Steppe'
		UNION ALL SELECT '100 VT', 'aber1906',  'Andre', 'Bertelmann'
		UNION ALL SELECT '100 VT', 'rhaa0505',  'Ramon', 'Haase'
		UNION ALL SELECT '100 VT', 'hkoc01101', 'Heiko', 'Koch'
		UNION ALL SELECT '100 VT', 'gwei2601',  'Gregor', 'Weigel'
		UNION ALL SELECT '100 VT', 'cmet1702',  'Christine', 'Metzger'
		UNION ALL SELECT '100 VT', 'ssch06114', 'Stefan', 'Schmalzhaf'
		UNION ALL SELECT '100 VT', 'ddor2012',  'Dennis', 'Dorn'
		UNION ALL SELECT '100 VT', 'djan1111',  'Daniela', 'Janak'
		UNION ALL SELECT '100 VT', 'jcre0604',  'Jill', 'Cremer'
		UNION ALL SELECT '100 VT', 'tdie0803',  'Tom', 'Dienewald'
		UNION ALL SELECT '100 VT', 'teve2004',  'Torsten', 'Evers'
		UNION ALL SELECT '100 VT', 'akal23051', 'Andrea', 'Kalinowsky'
		/* User Controlling + Verwaltung */
		UNION ALL SELECT '200 CO/VW ', 'jlei3005',  'Jessica', 'Leibel'
		UNION ALL SELECT '200 CO/VW ', 'msch29125', 'Maren', 'Schoettke'
		UNION ALL SELECT '200 CO/VW ', 'jwal0602',  'Johann', 'Walger'
		UNION ALL SELECT '200 CO/VW ', 'nsch11101', 'Nico', 'Scheuber'
		UNION ALL SELECT '200 CO/VW ', 'nroc1904',  'Nicole', 'Rockstroh'
	)
)


/* MAIN */

/* 1 - Vertriebsuser (HL_2, VKL_2, GF_2, GL, GLV) mit Sicht auf Vertriebshierarchie aus SAP Retailstore. Ohne SV/WBL_2 */ 
SELECT '010 HL_2' AS Rolle
	, LOWER(wup.land_id || wup.wup_id || 'hl_2') AS user_vt_id
	, 'Filiale HL_2 '                            AS user_vt_name
	, UPPER(wup.land_id || ' ' || wup.wup_id) || ' ' || wup.wup_standort AS user_vt_vorname 
	, wup.mandant_id, wup.wup_id
FROM wup_basis wup_2

UNION
SELECT '020 VKL_2'
	, vkl.ma_ldap    AS user_vt_id
	, vkl.ma_name    AS user_vt_name
	, vkl.ma_vorname AS user_vt_vorname
	, wup.mandant_id, wup.wup_id
FROM wup_basis wup_2
LEFT JOIN ma_basis vkl_2
	ON vkl.mandant_id = wup.mandant_id AND vkl.ma_id = wup.vkl_id 

UNION
SELECT '030 GF_2'
	, gf.ma_ldap    AS user_vt_id
	, gf.ma_name    AS user_vt_name
	, gf.ma_vorname AS user_vt_vorname
	, wup.mandant_id, wup.wup_id
FROM wup_basis wup_2
LEFT JOIN ma_basis gf_2
	ON gf.mandant_id = wup.mandant_id AND gf.ma_id = wup.gf_id 

UNION
SELECT '040 GL'
	, gl.ma_ldap    AS user_vt_id
	, gl.ma_name    AS user_vt_name
	, gl.ma_vorname AS user_vt_vorname
	, wup.mandant_id, wup.wup_id
FROM wup_basis wup_2
LEFT JOIN ma_basis gl
	ON gl.mandant_id = wup.mandant_id AND gl.ma_id = wup.gl_id 

UNION
SELECT '050 GLV'
	, glv.ma_ldap    AS user_vt_id
	, glv.ma_name    AS user_vt_name
	, glv.ma_vorname AS user_vt_vorname
	, wup.mandant_id, wup.wup_id
FROM wup_basis wup_2
LEFT JOIN ma_basis glv
	ON glv.mandant_id = wup.mandant_id AND glv.ma_id = wup.glv_id 

/* 2 - Zentraluser aus Userliste mit Sicht aus user_wup_zu_2 */
UNION
SELECT zen.rolle
	, zen.user_vt_id
	, zen.user_vt_name
	, zen.user_vt_vorname
	, uwz.mandant_id, uwz.wup_id
FROM zentral_user zen
INNER JOIN user_wup uwz
ON uwz.user_vt_id = zen.user_vt_id
;