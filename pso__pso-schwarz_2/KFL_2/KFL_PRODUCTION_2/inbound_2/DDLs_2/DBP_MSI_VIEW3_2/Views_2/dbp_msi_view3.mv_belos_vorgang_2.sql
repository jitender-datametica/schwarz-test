CREATE OR REPLACE VIEW dbp_msi_view3.mv_belos_vorgang_2(
	MANDANT_ID,
	BELOS_VORGANG_ID,
	KOMPLETTLIEFERUNG_FG,
	LOESCH_FG,
	IN_TIME_FG,
	AV_FG,
	SAMMEL_LADUNG_FG,
	NB_ID,
	SENDUNG_GEW_EINH_ID,
	SENDUNG_VOL_EINH_ID,
	DAT_LIEF_SOLL,
	DAT_ZUSTELLUNG,
	SENDUNG_ID,
	WUP_ID,
	LAGERORT_ID,
	HGP_ID,
	GEWICHT_SENDUNG,
	ZUSTELLART_ID,
	BELOS_VORGANGART_ID,
	TRANSPORTAUFTRAG_ID,
	SONDERABWICKLUNG_ID,
	BELOS_ADRESSE_ABSENDER_NUM_ID,
	BELOS_ADRESSE_ABHOLUNG_ID,
	BELOS_ADRESSE_EMPFAENGER_ID,
	BELOS_ADRESSE_SPEDITION_ID,
	VOL_STAURAUM,
	DEBITOR_ID,
	ANZ_UNTERVERPACKUNG,
	UNTERVERPACKUNG_MENGE_EINH_ID,
	ANLIEFERART_ID,
	BELOS_SENDUNGSSTATUS_ID,
	K_NA_FG,
	BELOS_AUFTRAG_ID_EXTERN,
	BELOS_LIEFERSCHEIN_ID,
	BELOS_SENDUNG_ID_EXTERN,
	BELOS_BESTELL_BELEG_ID_EXTERN,
	MANDANT_ID_DEBITOR,
	REFERENZNR
) AS
--  30.11.2009   AL Neue Spalten  aufgenommen: anz_unterverpackung ,   unterverpackung_menge_einh_id
--  27.01.2010  AL Neue Spalte anlieferart_id
--  13.04.2010  AL  Eingeschränkt auf die Daten der Beschaffungslogistik
--  29.04.2013 KKaiser Feld gewicht_sendung Format (18,3), damit FE einheitlich ist
--  13.05.2013 srom, 589416, belos_adresse_id durch belos_adresse_num_id ersetzen
--  02.02.2016 srom, AP0004654 Dachser Umstellung
--  18.10.2016 srom, AP0001986 Erweiterung mandant_id_debitor
-- 27.11.2018 mkub1811, AP0026182, SPEC0040905, Erweiterung referenznr
--2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-17,AP0204035, SPEC0254614,dknop, reverting aktuell_wup_id logic


SELECT

v01.mandant_id
,v01.belos_vorgang_id
,v01.komplettlieferung_fg
,v01.loesch_fg
,v01.in_time_fg
,v01.av_fg
,v01.sammel_ladung_fg
,v01.nb_id
,v01.sendung_gew_einh_id
,v01.sendung_vol_einh_id
,v01.dat_leistung AS dat_lief_soll
,v01.dat_zustellung
,v01.sendung_id
,v01.wup_id
,v01.lagerort_id
,v01.gp_id AS hgp_id
--,gewicht_sendung
,CAST(v01.gewicht_sendung AS DECIMAL(18,3)) AS gewicht_sendung
,v01.zustellart_id
,v01.belos_vorgangart_id
,v01.transportauftrag_id
,v01.sonderabwicklung_id
,v01.belos_adresse_absender_num_id
-- Falls Abholadresse nicht befüllt ist, ist die mit der Absenderadresse identisch.
,COALESCE(v01.belos_adresse_abholung_id, v02.belos_adresse_id) AS belos_adresse_abholung_id
,v01.belos_adresse_empfaenger_id
--,CASE WHEN TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) = 0 THEN NULL ELSE v05.aktuell_wup_id END belos_adresse_empfaenger_id
,v01.belos_adresse_spedition_id
,v01.vol_stauraum
,v01.debitor_id
,v01.anz_unterverpackung
,v01.unterverpackung_menge_einh_id
,CASE WHEN v01.sammel_ladung_fg = 0 THEN -1 ELSE v01.belos_adresse_spedition_id END anlieferart_id
,v01.belos_sendungsstatus_id

--  02.02.2016 srom, AP0004654 Dachser Umstellung
,v01.k_na_fg
,v01.belos_auftrag_id_extern
,v01.belos_lieferschein_id
,v01.belos_sendung_id_extern
,v01.belos_bestell_beleg_id_extern
,v01.mandant_id_debitor
,v01.referenz

FROM dbp_view.v_belos_vorgang_2 v01

/*INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v01.mandant_id 
   AND v05.wup_id = CASE WHEN TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(belos_adresse_empfaenger_id AS INTEGER) END
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))
*/
LEFT JOIN dbp_view.v_belos_adresse_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.belos_adresse_absender_num_id = v02.belos_adresse_num_id

WHERE

-- Transportaufträge, welche bereits in Kostenmanagementsystem erfasst sind.
-- 16.04.2014 srom Anforderung 599534, Erweiterung um 'K-LT'
-- 02.02.2016 srom, AP0004654 Dachser, Erweiterung um 'K-NA'
to_varchar(v01.dat_leistung,'MMDDYYYY') > 01011900 AND 
v01.belos_vorgangart_id IN ('K-BESCH','K-RET','K-AV','K-LT','K-NA') AND

-- Transportauftrag_2  (TM System) wurde  in DWH verbucht
-- belos_adresse_absender_id <> ''  AND
v01.belos_adresse_absender_num_id IS NOT NULL AND

-- Eingeschränkt auf die Daten der Beschaffungslogistik
v01.belosart_fg = 0;