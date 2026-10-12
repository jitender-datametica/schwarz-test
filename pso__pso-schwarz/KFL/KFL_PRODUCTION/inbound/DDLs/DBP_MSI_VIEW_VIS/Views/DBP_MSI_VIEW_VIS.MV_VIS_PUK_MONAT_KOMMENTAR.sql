CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_PUK_MONAT_KOMMENTAR (
	MANDANT_ID,
	VS_ID,
	GF_ID,
	VKL_ID,
	WUP_ID,
	KJMO,
	KENNZAHL_ID,
	PUK_TYP_ID,
	PUK_ID,
	PUK_PARENT_ID,
	URSACHE_KJMO,
	MASSNAHME_KJMO,
	ZEIT_AKTUALISIERUNG
) AS
   -- TRANSACTION - PUK Kommentare pro Kennzahl und Monat
   -- PUK puk_typ_id = (puk_id/puk_parent_id) : 1=Filiale (wup_id/vkl_id) 2=VKL (vkl_id/gf_id) 3=GF (gf_id/vl_id) 4=Region (vl_id/mandant_id) 5=Land (mandant_id/0)
   -- THEMA (kennzahl_id) : 10=Umsatz 20=Kunden 30=Nettoleistung 40=Nettostueckleistung 50=Kassierleistung 60=Scans/Min 70=Abschriften 80=Personalkosten
   -- 2019.0730 INITIAL : Denormalisierte Version (5 rows per wup/kjmo/kennzahl)
   -- 2019.1202 ssch0611 : REVIEW. New Table structure (in FED on ENTW)
   -- 2019.1209 ssch0611 : GL/Region, GLV/Land added
   -- 2020.0124 ssch0611 : dat_termin_kjmo removed
   -- 2024-08-22 ssch0611 : Review. Da nur Ausland, noch keine Anpassung Filialumgliederung [P1760-DWH]
 
SELECT
  wp.mandant_id
, wp.vs_id
, wp.gf_id
, wp.vkl_id
, wp.wup_id
--, wp.aktuell_wup_id AS wup_id
, mo.kjmo
, pkk.kennzahl_id
, pkt.puk_typ_id
, COALESCE(PUK1, PUK2, PUK3, PUK4, PUK5, CASE 
		WHEN pkt.puk_typ_id = 1 THEN wp.wup_id 
		WHEN pkt.puk_typ_id = 2 THEN wp.vkl_id 
		WHEN pkt.puk_typ_id = 3 THEN wp.gf_id 
		WHEN pkt.puk_typ_id = 4 THEN wp.vs_id 
		WHEN pkt.puk_typ_id = 5 THEN wp.mandant_id 
		END
  ) AS puk_id
, COALESCE(PRN1, PRN2, PRN3, PRN4, PRN5, CASE 
		WHEN pkt.puk_typ_id = 1 THEN wp.vkl_id 
		WHEN pkt.puk_typ_id = 2 THEN wp.gf_id 
		WHEN pkt.puk_typ_id = 3 THEN wp.vs_id 
		WHEN pkt.puk_typ_id = 4 THEN wp.mandant_id 
		WHEN pkt.puk_typ_id = 5 THEN 0 
		END
  ) AS puk_parent_id
, COALESCE(URS1, URS2, URS3, URS4, URS5) AS ursache_kjmo
, COALESCE(MSN1, MSN2, MSN3, MSN4, MSN5) AS massnahme_kjmo
, COALESCE(AKT1, AKT2, AKT3, AKT4, AKT5) AS zeit_aktualisierung
FROM dbp_data.wup wp
 
/* Denormalisierung */ 
CROSS JOIN dbp_data.monat mo
CROSS JOIN dbp_data.vis_l_puk_kennzahl pkk
CROSS JOIN dbp_data.vis_l_puk_typ pkt
 
/*PUK Daten pro Ebene/PUK-Typ */ 
LEFT JOIN ( -- PuK1 FIL/VKL
	SELECT mandant_id, kjmo, kennzahl_id, puk_typ_id
	, puk_id              AS PUK1
	, puk_parent_id       AS PRN1
	, ursache_kjmo        AS URS1
	, massnahme_kjmo      AS MSN1
	, zeit_aktualisierung AS AKT1
	FROM dbp_data.vis_puk_monat_kommentar puk
	WHERE puk_typ_id = 1
) puk1
ON  wp.aktuell_wup_id = PUK1
AND wp.mandant_id = puk1.mandant_id AND mo.kjmo = puk1.kjmo
AND pkk.kennzahl_id = puk1.kennzahl_id  AND pkt.puk_typ_id = puk1.puk_typ_id
 
LEFT JOIN ( -- PuK2 VKL/GF
	SELECT mandant_id, kjmo, kennzahl_id, puk_typ_id
	, puk_id              AS PUK2
	, puk_parent_id       AS PRN2
	, ursache_kjmo        AS URS2
	, massnahme_kjmo      AS MSN2
	, zeit_aktualisierung AS AKT2
	FROM dbp_data.vis_puk_monat_kommentar puk
	WHERE puk_typ_id = 2
) puk2
ON  wp.vkl_id = PUK2
AND wp.mandant_id = puk2.mandant_id AND mo.kjmo = puk2.kjmo
AND pkk.kennzahl_id = puk2.kennzahl_id  AND pkt.puk_typ_id = puk2.puk_typ_id
 
LEFT JOIN ( -- PuK3 GF/REG
	SELECT mandant_id, kjmo, kennzahl_id, puk_typ_id
	, puk_id              AS PUK3
	, puk_parent_id       AS PRN3
	, ursache_kjmo        AS URS3
	, massnahme_kjmo      AS MSN3
	, zeit_aktualisierung AS AKT3
	FROM dbp_data.vis_puk_monat_kommentar puk
	WHERE puk_typ_id = 3
) puk3
ON  wp.gf_id = PUK3
AND wp.mandant_id = puk3.mandant_id AND mo.kjmo = puk3.kjmo
AND pkk.kennzahl_id = puk3.kennzahl_id  AND pkt.puk_typ_id = puk3.puk_typ_id
 
LEFT JOIN ( -- PuK4 REG/LAND
	SELECT mandant_id, kjmo, kennzahl_id, puk_typ_id
	, puk_id              AS PUK4
	, puk_parent_id       AS PRN4
	, ursache_kjmo        AS URS4
	, massnahme_kjmo      AS MSN4
	, zeit_aktualisierung AS AKT4
	FROM dbp_data.vis_puk_monat_kommentar puk
	WHERE puk_typ_id = 4
) puk4
ON  wp.vs_id = PUK4
AND wp.mandant_id = puk4.mandant_id AND mo.kjmo = puk4.kjmo
AND pkk.kennzahl_id = puk4.kennzahl_id  AND pkt.puk_typ_id = puk4.puk_typ_id
 
LEFT JOIN ( -- PuK5 LAND
	SELECT mandant_id, kjmo, kennzahl_id, puk_typ_id
	, puk_id              AS PUK5
	, puk_parent_id       AS PRN5
	, ursache_kjmo        AS URS5
	, massnahme_kjmo      AS MSN5
	, zeit_aktualisierung AS AKT5
	FROM dbp_data.vis_puk_monat_kommentar puk
	WHERE puk_typ_id = 5
) puk5
ON  wp.mandant_id = PUK5
AND wp.mandant_id = puk5.mandant_id AND mo.kjmo = puk5.kjmo
AND pkk.kennzahl_id = puk5.kennzahl_id  AND pkt.puk_typ_id = puk5.puk_typ_id
 
WHERE wp.nb_id = 0 AND wp.dat_von > '1900-01-01' AND wp.dat_eroeffnung > '1900-01-01'
AND mo.akt_mo BETWEEN -4 AND -1
;