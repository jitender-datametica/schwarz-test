CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_ARTBEW
(dat
,art_id
,mandant_id
,gp_id
,nb_id
,wup_id
,bewart_id
,aktion_id
,posten_id
,wrg_id
,herst_id
,mwst_id
,umsatz_mwst_betrag
,umsatz_netto
,umsatz_brutto
,vk_menge
,umsatz_mwst_betrag_af
,umsatz_netto_af
,umsatz_brutto_af
,umsatz_mwst_betrag_sa
,umsatz_netto_sa
,umsatz_brutto_sa
,umsatz_netto_loyalty
)
AS
--INC6025581 /ssch1303 27.01.2023
--INC6044649 /ssch1303 31.01.2023
SELECT 
 v01.dat
,v01.art_id
,v01.mandant_id
,v01.gp_id
,v01.nb_id
,v01.wup_id
,v01.bewart_id
,v01.aktion_id
,CAST(CASE WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('PN', 'PF') THEN '  ' ELSE 'PN' END AS CHAR(8)) AS posten_id
,wrg
,herst_id
,mwst_id
-- AP0202325/SPEC0292700 Umstellung auf akt. Berichtskurs (vorher Tageskurs) / sschuecke 04.02.2025
,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN Cast(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN Cast(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag
,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto
 
,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5)) + CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) + CAST(v01.umsatz_netto AS NUMBER(38,5)) * v01.umrechnungskurs_hist
	  ELSE CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) + CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_brutto
,CAST(v01.menge AS NUMBER(38,5)) AS vk_menge
-- AF
,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN Cast(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN Cast(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN Cast(v01.umsatz_mwst_betrag AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag_af

,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto_af

,umsatz_mwst_betrag_af + umsatz_netto_af AS umsatz_brutto_af
-- SA
,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_mwst_betrag AS NUMBER(38,5)) END umsatz_mwst_betrag_sa

,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END umsatz_netto_sa

,umsatz_mwst_betrag_sa + umsatz_netto_sa AS umsatz_brutto_sa

/* AP0230051/SPEC0260231 Erweiterung um UMSATZ_NETTO_LOYALTY / sschuecke 10.07.2024 */
,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231, 100241) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER (38,5))
      WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231, 100241) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER (38,5))
	  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231, 100241) THEN CAST(v01.umsatz_netto AS NUMBER (38,5))
	  WHEN v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231, 100241) THEN CAST(v01.umsatz_netto AS NUMBER (38,5)) END umsatz_netto_loyalty

FROM DBP_DATA.ARTBEW v01

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v02

-- AP0202325/SPEC0292700 Umstellung auf akt. Berichtskurs (vorher Tageskurs) / sschuecke 04.02.2025
-- JOIN auf Kurs entfällt, da Tabelle um umrechnungskurs_hist erweitert wurde, Umsetzung analog AIS
/*JOIN dbp_view.v_kurs v05
ON v01.DAT BETWEEN v05.dat_von AND v05.dat_bis
AND v01.wrg = v05.von_wrg_id
AND v05.kurstyp_id = 9 -- (9= Tageskurs, 3= Berichtskurs)
AND v05.nach_wrg_id ='EUR'*/

--AP0190987/SPEC0225041 Filter E-Loading Artikel / sschuecke 17.11.2023
WHERE NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
--AP0227085/SPEC0284781 Filter E-Loading Artikel / sschuecke 25.02.2025
AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640);