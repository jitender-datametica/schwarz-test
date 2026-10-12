CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_ABSCHOEPFUNG_WUP(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT,
	OFFEN,
	WRG_ID,
	BETRAG_MARKT_VOR_GELDABHLG,
	BETRAG_GELDABHLG,
	BETRAG_MARKT_NACH_GELDABHLG,
	BETRAG_TRESOR_NACH_GELDABHLG,
	BETRAG_SCHIEB_NACH_GELDABHLG,
	QUOTE_GELDABHLG,
	BETRAG_GELDABHOLG_90_PROZENT,
	BETRAG_DIFF_90_PROZENT
) AS

   -- FAKT Abschoefung Tresor pro Tag - Waehrung - Filiale
   -- Datenumfang: 2 GJ - nur DE
   -- Wupcal zur Ermittlung von nicht gelieferten
   -- 20120325 INITIAL
   -- 2012KW19 Aktualiserung/Final
   -- 2012KW24 Coalesce raus
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]


SELECT
 v01.mandant_id 
 , v01.nb_id
 , wup.aktuell_wup_id 															AS wup_id
 , v01.dat
 , v01.offen
 , COALESCE(v03.wrg_id, 'EUR')  												AS wrg_id
 , v03.betrag_markt_vor_geldabhlg
 , v03.betrag_geldabhlg
 , v03.betrag_markt_nach_geldabhlg
 , v03.betrag_tresor_nach_geldabhlg
 , v03.betrag_schieb_nach_geldabhlg
 , v03.quote_geldabhlg
 , v03.betrag_geldabholg_90_prozent
 , v03.betrag_diff_90_prozent
FROM dbp_view.v_wupcal v01

JOIN dbp_view.v_tag v02
ON v01.dat = v02.dat
LEFT JOIN dbp_view.v_wup_abschoepfung v03
ON v01.mandant_id = v03.mandant_id
AND v01.wup_id = v03.wup_id
AND v01.dat = v03.dat

JOIN dbp_view.v_wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id

WHERE v01.mandant_id = 1
AND v01.nb_id=0
AND v02.akt_gj BETWEEN -1 AND 0
AND v02.akt_tag <= 0
;