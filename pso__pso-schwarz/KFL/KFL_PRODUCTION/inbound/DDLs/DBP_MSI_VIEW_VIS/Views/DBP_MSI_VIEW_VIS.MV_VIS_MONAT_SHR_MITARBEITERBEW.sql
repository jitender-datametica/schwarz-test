CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_SHR_MITARBEITERBEW(
	MANDANT_ID,
	MITARBEITER_ID,
	KOSTENSTELLE_ID,
	KOSTENSTELLE_EBENE4_ID,
	WUP_ID,
	HR_OBJEKT_ID,
	HR_OBJEKT_BEZ_KURZ,
	HR_OBJEKT_BEREICH_ID_ORG,
	HR_OBJEKT_BEREICH_ID,
	KJMO,
	AKT_MO,
	KJ,
	GJ,
	SHR_MA_FUNKTION_ID,
	SHR_MA_FUNKTION_ID_2,
	MITARBEITER_GRUPPE_ID,
	MITARBEITER_KREIS_ID,
	SHR_MA_FUNKTION_GRUPPE_ID,
	KOPF_INT,
	MA_STATUS_ID,
	LANGZEIT_ABWESEND_FG,
	EINTRITT_FG,
	WIEDEREINTRITT_MONATLICH,
	AUSTRITT_ALLES_FG,
	AUSTRITT_FLUKTUATION_FG,
	UNTERMONATLICH_FG,
	MA_STATUS_ID_VM,
	LANGZEIT_ABWESEND_FG_VM,
	KEIN_LZA,
	AKTIV,
	FLUKT,
	FLUKT_AUSTRITT,
	EINTRITTSDATUM,
	AUSTRITTSDATUM,
	VZK,
	KOPF,
	BETRIEBSZUGEHOERIGKEIT_BEREINIGT,
	BETRIEBSZUGEHOERIGKEIT_CLUSTER_SORT_ID,
	BZG_00,
	BZG_0003,
	BZG_0306,
	BZG_0612,
	BZG_1236,
	BZG_36,
	FILIAL,
	TZK,
	TZK2,
	AUSTRITT_AG_FG,
	AUSTRITT_AN_FG,
	AUSTRITT_TRW_FG,
	AUSTRITT_VTG_FG,
	AUSTRITT_ANA_FG,
	AUSTRITT_UGSI_FG,
	AUSTRITT_UGSW_FG,
	AUSTRITT_BU_FG,
	FLUKT_AUSTRITT_ALT,
	URLAUB_REST,
	URLAUB_REST_MIN,
	URLAUB_ANSPRUCH,
	URLAUB_GENOMMEN,
	URLAUB_GENOMMEN_KUM,
	STD_KRANK,
	STD_VERTRAG,
	STD_SOLL,
	URLAUB_ABGELT,
	FEIERTAG_ZUSCHLAG,
	MEHRSTD_ZUSCHLAG,
	NACHT_ZUSCHLAG,
	WOCHENEND_ZUSCHLAG,
	MEHRSTD_AUSBEZ,
	STD_ABR,
	STD_SOLL_MBEW
) AS 
 
/* 
	FAKT/HELPER : Ebene Mitarbeiter - nicht im VIS Schema! 
	Basis (Ausland) : SHR mitarbeiterbew (Ausschnitt) + Erweiterung/Anreicherung weitere SHR Inhalte 
	2018.0611 ssch0611 : Intitial. Daten gefiltert (ohne DE)
	2018.0626 ssch0611 : Finetuning + Mehrarbeit/Zuschlaege + Externe PL > Externe (Kostestelle) in shr_wup_funktion
	2018.0720 ssch0611 : Finetuning. Anpassung Zeit, FILIAL-Flag
	2018.0801 ssch0611 : Anpassung Lohnarten (Zuschlaege, Mehrarbeit) + Wiedereintritt (AKTIV, FLUKT)
	2018.0816 awol2209 : Korrektur anz_mehrstd_zuschlag
	2018.0904 ssch0611 : Zahlenformate, VZK, BZG + Mapping ZF
	2018.0904 ssch0611 : Finetuning/QS. Kein Mapping ZF. Gruende AN
	2018.1106 ssch0611 : Final/Release - Anpassung Funktionen, Ausnahmen (akt. sHR Definition)
	2018.1115 ssch0611 : Bugfix/Aktualisierung : Subselect kostenstellen_hierarchie
	2018.1116 ssch0611 : Filter auf VT entfernt (da sonst keine Historie)
	2018.1121 ssch0611 : Anpassung : externe Studenten HR
	2018.1206 ssch0611 : Anpassung : externe Studenten HR > VZK ueber Lohnart 
	2019.0201 ssch0611 : Anpassung : austritte_an > massnahme 90 (SK, HR, RO)
	2019.0204 ssch0611 : Korrektur Fluktuation! FLUKT_AUSTRITTE Austritte ohne Sonderfall (Azubi CZ, ext Studenten HR)
	2019.0220 ssch0611 : Anpassung Struktur : Mapping Trainees CZ auf 60
	2019.0325 ssch0611 : Erweiterung Moldau MD (mandant_id=4)
	2019.0405 ssch0611 : Sync mit SHR : Fluktuation (Austrittsggruende) 
	2019.0424 awol2209: austritt_an_fg: bei RO Grund 50 entfernt, da 50 schon in ag_fg enthalten
	2020-11-23 ssch0611 : changed Köpfe format 0.00 (SPEC0093688) + adjusted SHR Filter (SPEC0090284)
	2020-12-03 ssch0611 : adjusted Kopf Extern = VZK Extern per CASE (AP0078054_SPEC0093688)
	2021-04-30 ssch0611 : abwesenheit_stunden, adjusted filter (NSR2125368)
	2021-05-10 ssch0611 : Fluktuation: new base logic (only AN/AG), adjusted filter, new austritt_gruende (AP0082232_SPEC0109407)
	2021-06-10 ssch0611 : abwesenheit_stunden adjusted BG (INC3094687) regular change 
	2021-07-07 ssch0611 : abwesenheit_stunden adjusted RO (NSR2224998) regular change 
	2021-08-27 ssch0611 : abwesenheit_stunden adjusted HR (NSR2350163) + austritt_gruende adjusted (AP0082232_SPEC0109407
	2021-10-12 ssch0611 : additional austritt_grund PL (AP0082232_SPEC0109407)
	2021-10-13 ssch0611 : Update Struktur (shr_ma_funktion_gruppe) Azubi/Trainee (AP0086988_SPEC0104179)
	2022-05-04 ssch0611 : Update Abwesenheit/Stunden SK (NSR2838192) 
	2022-05-09 ssch0611 : Update Logic Fluktuation Koepfe (AP0082232) 
	2022-07-26 ssch0611 : Neue austrittgruende (CZ) NSR3062983
	2022-08-25 ssch0611 : Logik Fluktuation (dat_austritt, untermonatlich_fg, aktiv) + MA Status/LZA Vormonat (AP0082232)
	2022-11-10 ssch0611 : Anpassung Abwesenheit (MD) - NSR3261732
	2022-11-14 ssch0611 : Fluktuation pro Bereich (hr_objekt_bereich_id) per Org-Einheit (l_org_einheit.hr_objekt_id) + Mapping (AP0111895) 
	2023-04-14 ssch0611 : Update Filter Abwesenheit/Krankenstand - NSR3641731
	2023-07-17 ssch0611 : Update Filter Abwesenheit (PL) NSR3767733 
	2023-11-29 ssch0611 : Update Filter Abwesenheit (PL) + Formel Sollstunden (abrechnungstyp_fuer_periode) NSR3947679
	2024-09-25 ssch0611 : kostenstelle_id aus Join/Abfrage in Subselects (lohn_mvst, kost_lohn) entfernt, nur noch aus v103 (ma_kostenstelle_zu_per) [NSR4723847]
	2024-09-25 ssch0611 : Nur Kroatien. Stunden Abwesenheit auf Lohnarten umgestellt und in Abwesenheit ausgeblendet [NSR4675578] 
	2024-10-04 muellerpatri : Entfernung anzahl_lohnart > 0 bei Lohnarten pro Kostenstelle/MA (gruppiert)
	2024-11-07 ssch0611 : Anpassung Fluktuation Austritte AN + AG für CZ [NSR4914961] 
	2025-04-28 ssch0611 : Fix Zählung Köpfe (Wechsel Monatsmitte) [NSR5216730]
*/
 
SELECT
  ma_bew.mandant_id
, ma_bew.mitarbeiter_id
, ma_bew.kostenstelle_id
, ma_bew.kostenstelle_ebene4_id
, TO_NUMBER(SUBSTRING(ma_bew.kostenstelle_id, 1, 4)) :: INTEGER AS wup_id
/* Org-Einheit + Bereich */
, ma_bew.hr_objekt_id
, org_eh.hr_objekt_bez_kurz 
, org_eh.hr_objekt_bereich_id AS hr_objekt_bereich_id_org /* original ohne mapping */
, CASE 
	WHEN org_eh.hr_objekt_bereich_id = -1 THEN 60 /* Mapping Verwaltung */
	ELSE org_eh.hr_objekt_bereich_id 
  END AS hr_objekt_bereich_id
, ma_bew.kjmo
, ma_bew.akt_mo
, ma_bew.kj
, ma_bew.gj
, ma_bew.shr_ma_funktion_id
, ma_bew.shr_ma_funktion_id_2
, ma_bew.mitarbeiter_gruppe_id
, ma_bew.mitarbeiter_kreis_id
/* SHR Mitarbeiterstruktur : Basis Funktion, Kreis + Sonderfaelle */
, CASE
/* HL, WBL, Erstkraft, PSB, TL  */
   WHEN ma_bew.shr_ma_funktion_id_2 IN (22) THEN 10 
   WHEN ma_bew.shr_ma_funktion_id_2 IN (21) THEN 20 
   WHEN ma_bew.shr_ma_funktion_id_2 IN (14) THEN 30 
   WHEN ma_bew.shr_ma_funktion_id_2 IN (15) THEN 40 
   WHEN ma_bew.shr_ma_funktion_id_2 IN (16) THEN -1 
/* Sonderfaelle CZ Azubi, CT Aushilfen, SK Aushilfen, HR Externe Praktikanten/Studenten, PL Externe Zentrale */
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.azubi_cz_sk_stunden <> 0 THEN 60 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.aushilfe_cz_sk_stunden <> 0 THEN 90 
   WHEN ma_bew.mandant_id = 5 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.aushilfe_cz_sk_stunden <> 0 THEN 90 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('12') AND ma_bew.shr_ma_funktion_id IN ('11-030-1')  THEN 100 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('C0','C1','C3') THEN 100 
/* Azubi/Trainee (Kombi) 2021-10 */
   WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 60 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('00','B3') AND ma_bew.shr_ma_funktion_id IN ('14-013-1','14-017-1')  THEN 60
   WHEN ma_bew.mandant_id = 5 AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 60 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 60 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('92') AND ma_bew.shr_ma_funktion_id IN ('11-009-1','11-011-1') THEN 60 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 60 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('09','17','18') THEN 60 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 60 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 60 
   WHEN ma_bew.mandant_id = 4 AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 60 
/* Praktikant/Diplomand/Werkstudent (Reihenfolge vor Azubi) */
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('11','12','91','92') THEN 70 
   WHEN ma_bew.mandant_id = 5 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('11','12','91','92') THEN 70 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('11','12','91','92') THEN 70 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('11','12','91','92') THEN 70 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('11','12','91','92') THEN 70 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('11','12','91','92') THEN 70 
   WHEN ma_bew.mandant_id = 4 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('11','12','91','92') THEN 70 
/* Trainees (nicht in Kombi) 2021-10 */
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id   IN ('14-013-1','14-017-1')THEN 60 
   WHEN ma_bew.mandant_id = 5 AND ma_bew.shr_ma_funktion_id   IN ('14-017-1')           THEN 60 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id   IN ('14-017-1')           THEN 60 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id   IN ('14-017-1')           THEN 60 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.shr_ma_funktion_id   IN ('14-017-1')           THEN 60 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id   IN ('14-017-1')           THEN 60 
   WHEN ma_bew.mandant_id = 4 AND ma_bew.shr_ma_funktion_id   IN ('14-017-1')           THEN 60 
/* Azubis (ohne Praktikant, ohne Trainees, nicht in Kombi) 2021-10 */
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id   IN ('11-009-1') THEN 60
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id   IN ('11-000-1') AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 60
   WHEN ma_bew.mandant_id = 5 AND ma_bew.shr_ma_funktion_id   IN ('11-009-1') THEN 60 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id   IN ('11-009-1') THEN 60 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.shr_ma_funktion_id   IN ('11-009-1') THEN 60 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id   IN ('11-016-1') THEN 60 
/* MA-Ebene */
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','B3','B4') THEN 50 
   WHEN ma_bew.mandant_id = 5 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','23','24','25','29','30','31','32') THEN 50 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','1M','3R','4R','7M','5R') THEN 50 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','05','06','12','13','14','15','16','24','25') THEN 50 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','41','48','62','65','66','67','68','69') THEN 50 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02') THEN 50 
   WHEN ma_bew.mandant_id = 4 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','41','48','62','65','66','67','68','69') THEN 50 
/* Entsendet */
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 80
   WHEN ma_bew.mandant_id = 5 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 80 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 80 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 80 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 80 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 80 
   WHEN ma_bew.mandant_id = 4 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 80 
/* Aushilfen */
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('20','21','22')  THEN 90 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('20','21','22')  THEN 90 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('20','21','22')  THEN 90 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('20','21','22')  THEN 90 
   WHEN ma_bew.mandant_id = 4 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.mitarbeiter_kreis_id IN ('20','21','22')  THEN 90 
   ELSE -1
  END AS shr_ma_funktion_gruppe_id
/* Dummy for Rowcount */
, 1.00 AS KOPF_INT
/* Flags & Filter */
, ma_bew.ma_status_id
, ma_bew.langzeit_abwesend_fg
, ma_bew.eintritt_fg
, ma_bew.wiedereintritt_monatlich
, ma_bew.austritt_alles_fg
, COALESCE(massn_austritt.austritt_fluktuation_fg, 0) AS austritt_fluktuation_fg
, ma_bew.untermonatlich_fg  
/* Vormonat 2022-08 */
, ma_bew_vm.ma_status_id         AS ma_status_id_vm
, ma_bew_vm.langzeit_abwesend_fg AS langzeit_abwesend_fg_vm
/* OHNE LZA */
, CASE
	WHEN ma_bew.langzeit_abwesend_fg NOT IN (1) THEN 1 
	ELSE 0
  END AS KEIN_LZA
/* AKTIV :	Wiedereintritt (ohne LZA, ohne Status ruhend)
			kein Austritt (ohne LZA, ohne Status ruhend)
			kein Austritt untermonatlich (ohne gleichzeitigen Wiedereintritt) -- 2025-04 */
, CASE 
	WHEN ma_bew.wiedereintritt_monatlich = 0 AND ma_bew.untermonatlich_fg = 1 THEN 0 
	WHEN ma_bew.wiedereintritt_monatlich = 1 AND ma_bew.langzeit_abwesend_fg NOT IN (1) AND ma_bew.ma_status_id NOT IN ('1') THEN 1 
	WHEN ma_bew.austritt_alles_fg NOT IN (1) AND ma_bew.langzeit_abwesend_fg NOT IN (1) AND ma_bew.ma_status_id NOT IN ('1') THEN 1 
	ELSE 0
	END AS AKTIV
/* FLUKTUATION : ohne Sonderfall CZ/HR + Aktiv Logik mit anderer Reihenfolge -- 2022-08-19
                (ohne Austritt untermonatlich + LZA + LZA (VM) + Ruhend + Aktiv + Austritt ohne Eintritt) */
, CASE 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('11-000-1', '11-009-1') AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 0 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN ('12') THEN 0 
   WHEN massn_austritt.austritt_fluktuation_fg = 1 AND ma_bew.langzeit_abwesend_fg IN (1) THEN 1 
   WHEN massn_austritt.austritt_fluktuation_fg = 1 AND ma_bew.langzeit_abwesend_fg IN (0) AND ma_bew_vm.langzeit_abwesend_fg IN (1) THEN 1
   WHEN massn_austritt.austritt_fluktuation_fg = 1 AND ma_bew.ma_status_id IN ('1') THEN 1
   WHEN ma_bew.untermonatlich_fg = 1 THEN 0
   WHEN ma_bew.wiedereintritt_monatlich = 1 AND ma_bew.langzeit_abwesend_fg NOT IN (1) AND ma_bew.ma_status_id NOT IN ('1') THEN 1 
   WHEN ma_bew.austritt_alles_fg NOT IN (1) AND ma_bew.langzeit_abwesend_fg NOT IN (1) AND ma_bew.ma_status_id NOT IN ('1') THEN 1 
   WHEN massn_austritt.austritt_fluktuation_fg = 1 AND ma_bew.eintritt_fg <> 1 AND ma_bew.ma_status_id NOT IN ('0') THEN 1 
   ELSE 0
  END  AS FLUKT
/* AUSTRITT FLUKTUATION : ohne Sonderfall CZ/HR - NEW LOGIC AG/AN 2021-05 */
, CASE 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('11-000-1', '11-009-1') AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 0 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN ('12') THEN 0 
   WHEN massn_austritt.austritt_fluktuation_fg = 1 THEN 1 
   ELSE 0
  END  AS FLUKT_AUSTRITT
, ma_bew.eintrittsdatum
, ma_bew.austrittsdatum
/* VZK : Vollzeitkraefte (wichtig: 2 Nachkommastellen) inkl. Sonderfaelle! Mapping weitere Externe separat (per Lohnart) in wup_funktion */
, CASE 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.azubi_cz_sk_stunden <> 0   THEN ma_bew.azubi_cz_sk_stunden / 174.00 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.aushilfe_cz_sk_stunden <> 0THEN ma_bew.aushilfe_cz_sk_stunden / 174.00 
   WHEN ma_bew.mandant_id = 5 AND ma_bew.shr_ma_funktion_id_2 IN (11,12,13) AND ma_bew.aushilfe_cz_sk_stunden <> 0THEN ma_bew.aushilfe_cz_sk_stunden / 174.00 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN ('12') THEN ma_bew.ext_studi_hr_stunden / 173.00 
   WHEN ma_bew.mandant_id = 6 THEN arbeitszeit_anteil_hr / 100.00 
   ELSE ma_bew.arbeitszeit_anteil / 100.00
  END AS VZK
/* BASE KOEPFE (100 Externe : Kopf = VZK) 2020-12 */
, CASE 
   WHEN shr_ma_funktion_gruppe_id = 100 THEN VZK ELSE 1.00
  END AS KOPF    
, ma_bew.betriebszugehoerigkeit_bereinigt
, ma_bew.betriebszugehoerigkeit_cluster_sort_id
, ma_bew.bzg_00
, ma_bew.bzg_0003
, ma_bew.bzg_0306
, ma_bew.bzg_0612
, ma_bew.bzg_1236
, ma_bew.bzg_36
/* MA Filiale : Angestellte + Ensendet + Azubi  (ohne CZ) */
, CASE
   WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('00','B3') AND ma_bew.shr_ma_funktion_id IN ('14-017-1','14-013-1') THEN 1 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','B3','B4')   THEN 1 
   WHEN ma_bew.mandant_id = 5 AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','23','24','25','29','30','31','32')  THEN 1 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','1M','3R','4R','7M','5R')THEN 1 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','05','06','12','13','14','15','16','24','25')THEN 1 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','41','48','62','65','66','67','68','69') THEN 1 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02') THEN 1 
   WHEN ma_bew.mandant_id = 4 AND ma_bew.mitarbeiter_kreis_id IN ('00','01','02','41','48','62','65','66','67','68','69') THEN 1 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 1 
   WHEN ma_bew.mandant_id = 5 AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 1 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 1 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 1 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 1 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 1 
   WHEN ma_bew.mandant_id = 4 AND ma_bew.mitarbeiter_kreis_id IN ('90') AND ma_bew.mitarbeiter_gruppe_id IN ('7') THEN 1 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.mitarbeiter_kreis_id IN ('10') AND ma_bew.shr_ma_funktion_id IN ('11-000-1', '11-009-1') THEN 0 
   WHEN ma_bew.mandant_id = 5 AND ma_bew.mitarbeiter_kreis_id IN ('10')   THEN 1 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.mitarbeiter_kreis_id IN ('10','09','17','18')THEN 1 
   WHEN ma_bew.mandant_id = 3 AND ma_bew.mitarbeiter_kreis_id IN ('10')   THEN 1 
   WHEN ma_bew.mandant_id = 7 AND ma_bew.mitarbeiter_kreis_id IN ('10')   THEN 1 
   WHEN ma_bew.mandant_id = 8 AND ma_bew.mitarbeiter_kreis_id IN ('10')   THEN 1 
   WHEN ma_bew.mandant_id = 4 AND ma_bew.mitarbeiter_kreis_id IN ('10')   THEN 1 
   ELSE 0
  END AS FILIAL
/* Teilzeitkraefte : Ausnahme Arbeitszeitanteil (HR) */
, CASE 
   WHEN CASE
     WHEN ma_bew.mandant_id = 6 THEN ma_bew.arbeitszeit_anteil_hr 
     ELSE ma_bew.arbeitszeit_anteil
    END <= 80 THEN 1.00
   ELSE 0.00
 END  AS TZK
/* Teilzeitkraefte mit allen Ausnahmen! */
, CASE
   WHEN VZK <= 80 THEN 1 ELSE 0
  END AS TZK2
/* Addon VTC : Fluktuation (Massnahmen) 2021-05 */
, COALESCE(massn_austritt.austritt_ag_fg, 0)   AS austritt_ag_fg
, COALESCE(massn_austritt.austritt_an_fg, 0)   AS austritt_an_fg
/* Addon VTC : Austritte (Massnahmen) 2021-05 */
, COALESCE(massn_austritt.austritt_trw_fg, 0)  AS austritt_trw_fg
, COALESCE(massn_austritt.austritt_vtg_fg, 0)  AS austritt_vtg_fg
, COALESCE(massn_austritt.austritt_ana_fg, 0)  AS austritt_ana_fg
, COALESCE(massn_austritt.austritt_ugsi_fg, 0) AS austritt_ugsi_fg
, COALESCE(massn_austritt.austritt_ugsw_fg, 0) AS austritt_ugsw_fg
, COALESCE(massn_austritt.austritt_bu_fg, 0)   AS austritt_bu_fg
/* Fluktuation Austritte - old logic  before 2021-05 */
, CASE 
   WHEN ma_bew.mandant_id = 2 AND ma_bew.shr_ma_funktion_id IN ('11-000-1', '11-009-1') AND ma_bew.mitarbeiter_kreis_id IN ('10') THEN 0 
   WHEN ma_bew.mandant_id = 6 AND ma_bew.shr_ma_funktion_id IN ('11-030-1') AND ma_bew.mitarbeiter_kreis_id IN ('12') THEN 0 
   ELSE ma_bew.austritt_alles_fg
  END  AS FLUKT_AUSTRITT_ALT
/* Resturlaub (Mitarbeiterbew) */
, ma_bew.resturlaub_vj AS URLAUB_REST
, FIRST_VALUE(ma_bew.resturlaub_vj) OVER (
   PARTITION BY ma_bew.mandant_id, ma_bew.mitarbeiter_id, ma_bew.kj
   ORDER BY ma_bew.mandant_id, ma_bew.mitarbeiter_id, ma_bew.kj, ma_bew.kjmo ASC ROWS UNBOUNDED PRECEDING
  ) AS URLAUB_REST_MIN
, ma_bew.anspruch_urlaub_akt_kj AS URLAUB_ANSPRUCH
, ma_bew.genommen_urlaub AS URLAUB_GENOMMEN
, SUM(ma_bew.genommen_urlaub) OVER (
   PARTITION BY ma_bew.mandant_id, ma_bew.mitarbeiter_id, ma_bew.kj
   ORDER BY ma_bew.mandant_id, ma_bew.mitarbeiter_id, ma_bew.kj, ma_bew.kjmo ASC ROWS UNBOUNDED PRECEDING
  ) AS URLAUB_GENOMMEN_KUM 
/* Addon VTC : Abwesenheit Krank/Arbeitsunfaehig -- Umstellung Kroatien 2024-09 */
, CASE
	WHEN ma_bew.mandant_id = 6 THEN COALESCE(kost_lohn.std_abwesenheit_lohnart, 0) 
	ELSE                            COALESCE(abwesenh_krank.std_abwesenheit, 0) 
  END AS STD_KRANK
/* Addon VTC : Vertragstunden (MA Lohnart) -- Ohne Kostenstelle 2024-09 */
, lohn_mvst.std_lohnart                          AS STD_VERTRAG
/* Addon VTC : Stunden (MA Kostenstelle Lohnart)  -- Ohne Kostenstelle 2024-09 */
, COALESCE(kost_lohn.std_soll, 0)               AS STD_SOLL
, COALESCE(kost_lohn.std_urlaub_abgeltung, 0)   AS URLAUB_ABGELT
, COALESCE(kost_lohn.std_feiertag_zuschlag, 0)  AS FEIERTAG_ZUSCHLAG
, COALESCE(kost_lohn.std_mehr_zuschlag, 0)      AS MEHRSTD_ZUSCHLAG
, COALESCE(kost_lohn.std_nacht_zuschlag, 0)     AS NACHT_ZUSCHLAG
, COALESCE(kost_lohn.std_wochenend_zuschlag, 0) AS WOCHENEND_ZUSCHLAG
, COALESCE(kost_lohn.std_mehr_ausbezahlt, 0)    AS MEHRSTD_AUSBEZ
/* NOT used : Stunden Abrechnung, Sollstunden aus Mitarbeiterbew */
, ma_bew.abr_stunden_monat                      AS STD_ABR
, ma_bew.soll_stunden_monat                     AS STD_SOLL_MBEW
FROM ( /* Basis : relevanter Ausschnitt aus SHR mv_mitarbeiterbew */
	SELECT 
	  mabew.mandant_id
	, mabew.mitarbeiter_id
	, mabew.shr_ma_funktion_id
	, mabew.hr_objekt_id
/*	 Mapping Erstkraft to MA + VKL to HL - 2018-11-05 */
	, CASE
		WHEN mabew.shr_ma_funktion_id LIKE '14-009-1%' THEN '13' 
		WHEN mabew.shr_ma_funktion_id LIKE '14-017-1%' THEN '13' 
		WHEN mabew.shr_ma_funktion_id LIKE '14-013-1%' AND mabew.mandant_id = 2 THEN '13' 
		WHEN mabew.shr_ma_funktion_id LIKE '14-001-2%' AND mabew.mandant_id = 6 THEN '13' 
		WHEN mabew.shr_ma_funktion_id LIKE '14-016-1%' AND mabew.mandant_id = 6 THEN '13'  
		WHEN mabew.shr_ma_funktion_id LIKE '23-003-3%' THEN '22' 
		ELSE CASE
			WHEN SUBSTRING (mabew.shr_ma_funktion_id, 3, 1) = '-' THEN SUBSTRING (mabew.shr_ma_funktion_id, 1, 2) 
			ELSE '99'
		END 
	END AS shr_ma_funktion_id_2
	, v101.mitarbeiter_gruppe_id
	, v102.mitarbeiter_kreis_id
	, v103.kostenstelle_id
	, v200.kostenstelle_ebene4_id
	, mabew.kjmo
	, v100.akt_mo
	, v100.kj
	, v100.gj
	, mabew.ma_status_id
	, mabew.langzeit_abwesend_fg
/*	 Austritt Untermonatlich -- 2022-07 */
	, mabew.untermonatlich_fg
	, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von, CAST('1900-01-01' AS DATE))  AS eintrittsdatum
/*	 Addon VTC  */
	, CASE
		WHEN v033.mitarbeiter_id IS NOT NULL THEN 1
		WHEN v035.mitarbeiter_id IS NOT NULL THEN 1
		ELSE 0
	END AS eintritt_fg
/*	 Austrittdatum = dat_von - 1 -- 2022-07 */
	, COALESCE(v094.dat_von - 1, CAST('9999-12-31' AS DATE))  AS austrittsdatum
/*	 OLD LOGIC Austritt - before 2021-05 */
	, CASE WHEN v094.mitarbeiter_id IS NOT NULL THEN 1 ELSE 0 END  AS austritt_alles_fg
	, CASE
		WHEN v094.mitarbeiter_id IS NOT NULL AND v035.mitarbeiter_id IS NOT NULL 
		AND v094.dat_von_wiedereintritt - 1 < v035.dat_von_wiedereintritt
		AND CAST(EXTRACT(MONTH FROM v094.dat_von_wiedereintritt) AS INTEGER) = CAST(EXTRACT(MONTH FROM v035.dat_von_wiedereintritt) AS INTEGER) THEN 1
		ELSE 0
	END AS  wiedereintritt_monatlich
/*	 Sonderfall CZ/SK Stunden + HR Stunden */
	, CASE WHEN v096.mitarbeiter_id IS NOT NULL THEN v096.anzahl_lohnart ELSE 0 END AS aushilfe_cz_sk_stunden
	, CASE WHEN v097.mitarbeiter_id IS NOT NULL THEN v097.anzahl_lohnart ELSE 0 END AS azubi_cz_sk_stunden
	, CASE WHEN ext_studi.mitarbeiter_id IS NOT NULL THEN ext_studi.anzahl_lohnart ELSE 0 END  AS ext_studi_hr_stunden
	, mabew.arbeitszeit_anteil
	, COALESCE(v099.arbeitszeit_anteil_hr, 0.00)  AS arbeitszeit_anteil_hr
/* 	BZG Betriebszugehoerigkeit */
	, COALESCE(CASE
		WHEN v094.dat_von IS NULL THEN CAST(Months_Between (v100.stichtag, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von) + 1) AS DECIMAL(9,1))
		ELSE CAST(Months_Between(v094.dat_von, COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS DECIMAL(9,1))
	END, -1) AS betriebszugehoerigkeit_bereinigt
	, CASE
		WHEN betriebszugehoerigkeit_bereinigt < -1 THEN 0 
		WHEN betriebszugehoerigkeit_bereinigt = -1 THEN 1 
		WHEN betriebszugehoerigkeit_bereinigt <= 3 THEN 2 
		WHEN betriebszugehoerigkeit_bereinigt >  3 AND betriebszugehoerigkeit_bereinigt <=  6 THEN 3 
		WHEN betriebszugehoerigkeit_bereinigt >  6 AND betriebszugehoerigkeit_bereinigt <= 12 THEN 4 
		WHEN betriebszugehoerigkeit_bereinigt > 12 AND betriebszugehoerigkeit_bereinigt <= 36 THEN 5 
		ELSE 6 
	END  AS betriebszugehoerigkeit_cluster_sort_id
	, CASE WHEN betriebszugehoerigkeit_cluster_sort_id <= 1 THEN 1 ELSE 0 END  AS bzg_00
	, CASE WHEN betriebszugehoerigkeit_cluster_sort_id =  2 THEN 1 ELSE 0 END  AS bzg_0003
	, CASE WHEN betriebszugehoerigkeit_cluster_sort_id =  3 THEN 1 ELSE 0 END  AS bzg_0306
	, CASE WHEN betriebszugehoerigkeit_cluster_sort_id =  4 THEN 1 ELSE 0 END  AS bzg_0612
	, CASE WHEN betriebszugehoerigkeit_cluster_sort_id =  5 THEN 1 ELSE 0 END  AS bzg_1236
	, CASE WHEN betriebszugehoerigkeit_cluster_sort_id >= 6 THEN 1 ELSE 0 END  AS bzg_36
	, mabew.abr_stunden_monat
	, mabew.soll_stunden_monat
	, mabew.resturlaub_vj
	, mabew.anspruch_urlaub_akt_kj
	, mabew.genommen_urlaub
	FROM dbp_view.v_mitarbeiterbew mabew

/*	 v033 : 1. Eintritt Datum/Flag (HR Massnahme 01) */
	LEFT JOIN (
		SELECT mandant_id, mitarbeiter_id, kjmo
		, MIN(dat_von) AS dat_von
		, MAX(dat_von) AS dat_von_wiedereintritt
		FROM dbp_view.v_ma_hr_massnahme_zu_per
		WHERE hr_massnahme_id = '01'
		GROUP BY ALL
	) v033
	ON  v033.mitarbeiter_id = mabew.mitarbeiter_id AND v033.mandant_id = mabew.mandant_id
	AND v033.kjmo = mabew.kjmo

/*	 v035 : 2. Eintritt Datum/Flag (HR Massnahme 02) */
	LEFT JOIN (
		SELECT mandant_id, mitarbeiter_id, kjmo
		, MIN(dat_von) AS dat_von
		, MAX(dat_von) AS dat_von_wiedereintritt
		FROM dbp_view.v_ma_hr_massnahme_zu_per
		WHERE hr_massnahme_id = '02'
		GROUP BY ALL
	) v035
	ON  v035.mitarbeiter_id = mabew.mitarbeiter_id AND v035.mandant_id = mabew.mandant_id
	AND v035.kjmo = mabew.kjmo

/*	 v036 : 3. Eintritt Datum (MA Datumsart 02) */
	LEFT JOIN ( 
		SELECT DISTINCT v036.mandant_id, v036.datumsart_id, v036.mitarbeiter_id, v036.kjmo, v036.dat_von
		FROM dbp_view.v_ma_datumsart_zu_per  v036
		WHERE v036.datumsart_id = '02'
	) v036
	ON  v036.mitarbeiter_id = mabew.mitarbeiter_id AND v036.mandant_id = mabew.mandant_id
	AND v036.kjmo = mabew.kjmo

/*	 v094 : Austritt Datum/Flag (HR Massnahme 04) > v_view */
	LEFT JOIN ( 
		SELECT mandant_id, mitarbeiter_id, kjmo
		, MIN(dat_von) AS dat_von
		, MAX(dat_von) AS dat_von_wiedereintritt
		FROM dbp_view.v_ma_hr_massnahme_zu_per
		WHERE hr_massnahme_id = '04'
		GROUP BY ALL
	) v094
	ON  v094.mitarbeiter_id = mabew.mitarbeiter_id AND v094.mandant_id = mabew.mandant_id
	AND v094.kjmo = mabew.kjmo

/*	 v096 : Sonderfall Aushilfe CZ + SK (Lohnart 3001, 3004) */
	LEFT JOIN ( 
		SELECT mandant_id, mitarbeiter_id, kjmo
		, SUM(anzahl_lohnart) AS anzahl_lohnart
		FROM dbp_view.v_ma_kostenstelle_lohnart_zu_per
		WHERE (mandant_id = 2 AND lohnart_id IN ('3001', '3004'))
		OR    (mandant_id = 5 AND lohnart_id IN ('3001'))
		GROUP BY ALL
	) v096
	ON  v096.mitarbeiter_id = mabew.mitarbeiter_id AND v096.mandant_id = mabew.mandant_id
	AND v096.kjmo = mabew.kjmo

/*	 v097 : Sonderfall Azubi CZ (Lohnart 1072) */
	LEFT JOIN ( 
		SELECT mandant_id, mitarbeiter_id, kjmo
		, SUM(anzahl_lohnart) AS anzahl_lohnart
		FROM dbp_view.v_ma_kostenstelle_lohnart_zu_per
		WHERE mandant_id = 2 AND lohnart_id IN ('1072')
		GROUP BY ALL
	) v097
	ON  v097.mitarbeiter_id = mabew.mitarbeiter_id AND v097.mandant_id = mabew.mandant_id
	AND v097.kjmo = mabew.kjmo

/* 	ext_studi : Sonderfall externe Studenten/Praktikanten HR (Lohnart 1035) */
	LEFT JOIN ( 
		SELECT mandant_id, mitarbeiter_id, kjmo
		, SUM(anzahl_lohnart) AS anzahl_lohnart
		FROM dbp_view.v_ma_kostenstelle_lohnart_zu_per
		WHERE mandant_id = 6 AND  lohnart_id IN ('1035')
		GROUP BY ALL
	) ext_studi
	ON  ext_studi.mitarbeiter_id = mabew.mitarbeiter_id AND ext_studi.mandant_id = mabew.mandant_id
	AND ext_studi.kjmo = mabew.kjmo

/*	v099 : Arbeitszeitanteil HR  (Korrektur der SAP Werte) */
	LEFT JOIN ( 
		SELECT v099.mandant_id, v099.kjmo_von, v099.kjmo_bis
		, v099.anz_stunden_von, v099.anz_stunden_bis
		, SUM(v099.arbeitszeit_anteil) AS arbeitszeit_anteil_hr
		FROM dbp_view.v_shr_arbeitszeit_anteil_mapping  v099
		GROUP BY ALL
	) v099
	ON v099.mandant_id = mabew.mandant_id
	AND mabew.kjmo BETWEEN v099.kjmo_von AND v099.kjmo_bis
	AND mabew.soll_stunden_monat BETWEEN v099.anz_stunden_von AND v099.anz_stunden_bis

/*	v100 : Stichtag (Anpassungen + Erweiterung) */
	LEFT JOIN ( 
		SELECT kjmo, akt_mo, kj, gj, max_dat AS stichtag
		FROM dbp_view.v_monat
	) v100
	ON v100.kjmo = mabew.kjmo

/*	v101 : Mitarbeiter Gruppe */
	LEFT JOIN ( 
		SELECT DISTINCT mandant_id, mitarbeiter_id, kjmo, mitarbeiter_gruppe_id
		FROM dbp_view.v_ma_gruppe_zu_per
	) v101
	ON v101.mitarbeiter_id = mabew.mitarbeiter_id AND v101.mandant_id = mabew.mandant_id
	AND v101.kjmo = mabew.kjmo

/*	v102 : Mitarbeiter Kreis */
	LEFT JOIN ( 
		SELECT DISTINCT mandant_id, mitarbeiter_id, kjmo, mitarbeiter_kreis_id
		FROM dbp_view.v_ma_kreis_zu_per
	) v102
	ON  v102.mitarbeiter_id = mabew.mitarbeiter_id AND v102.mandant_id = mabew.mandant_id 
	AND v102.kjmo = mabew.kjmo

/*	 v103 : Mitarbeiter Kostenstelle */
	LEFT JOIN ( 
		SELECT DISTINCT mandant_id, mitarbeiter_id, kjmo, kostenstelle_id
		FROM dbp_view.v_ma_kostenstelle_zu_per
	) v103
	ON  v103.mitarbeiter_id = mabew.mitarbeiter_id AND v103.mandant_id = mabew.mandant_id
	AND v103.kjmo = mabew.kjmo

/*	 v2 > v200 : Kostenstelle Hierarchie */
	LEFT JOIN ( 
		SELECT DISTINCT mandant_id, kjmo, kostenstelle_ebene4_id, kostenstelle_ebene15_id
		FROM dbp_view.v_kostenstelle_hierarchie
		WHERE kostenstelle_ebene1_id IN ('KCZ01', 'KSK01', 'KHR01', 'KPL01', 'KRO01', 'KBG01', 'KMD01')
	) v200
	ON v200.kostenstelle_ebene15_id = v103.kostenstelle_id AND v200.mandant_id = mabew.mandant_id
	AND mabew.kjmo = v200.kjmo
) ma_bew
 
/* v0111 Vormonat : Status + Langzeitabwesend -- 2022-08-19 */
LEFT JOIN dbp_view.v_mitarbeiterbew ma_bew_vm
ON  ma_bew_vm.mitarbeiter_id = ma_bew.mitarbeiter_id
AND ma_bew_vm.mandant_id = ma_bew.mandant_id
AND ma_bew_vm.kjmo = TO_NUMBER(TO_VARCHAR(ADD_MONTHS(TO_DATE(TO_CHAR(ma_bew.kjmo),'YYYYMM'),-1),'YYYYMM'))
 
/* 
	Extensions VTC Personal : Topics added from SHR Filters 
*/
 
/*	Vertrag Stunden = Mitarbeiter Lohnart 'MVST'
	ohne kostenstelle_id -- 2024-09 */ 
LEFT JOIN ( 
	SELECT mandant_id, mitarbeiter_id, kjmo
	/*, kostenstelle_id */
	, SUM(stunden_lohnart) std_lohnart
	FROM dbp_view.v_ma_lohnart_zu_per
	WHERE lohnart_id = 'MVST'
	GROUP BY ALL
) lohn_mvst
ON lohn_mvst.mitarbeiter_id = ma_bew.mitarbeiter_id AND lohn_mvst.mandant_id = ma_bew.mandant_id 
AND lohn_mvst.kjmo = ma_bew.kjmo

/* 	Neue Logik ab 2021 : Fluktuation = Austritte AN + Austritte AG 
	Austritt Grund : Massnahme = 04 + Liste Gruende pro Land */
LEFT JOIN ( 
	SELECT DISTINCT mandant_id, mitarbeiter_id, kjmo
	, CASE /* Fluktuation : Austritte Arbeitnehmer bedingt 2021-05-04 */
		WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30','31','40','53','BC','BM','BR','BS','BY') THEN 1
		WHEN mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30','31','40','53','72') THEN 1
		WHEN mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30','31','40','53','D1') THEN 1 
		WHEN mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30','31','40','50','53','C2','C3','CH') THEN 1 
		WHEN mandant_id = 7 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('20','30','31','40','53','F0','F2','F9','FA','FC') THEN 1 
		WHEN mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('30','31','40','53') THEN 1
		WHEN mandant_id = 4 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('53','I3','I6','I8','IG','IR','IS','IT','IU','IX','IY') THEN 1 
		ELSE 0
	END AS austritt_an_fg
	, CASE /* Fluktuation : Austritte Arbeitgeber bedingt 2021-10 */
		WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10','11','12','13','20','21','50','51','52','54','B4','B5','B6','B7','B8','B9','BA','BB','BD','BE','BF','BG','BH','BI','BJ','BK','BL','BN','BO','BP','BQ') THEN 1 
		WHEN mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10','11','20','50','52','54','B1','B2','B4','B5','E3')THEN 1 
		WHEN mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10','11','12','13','20','21','50','51','52','54') THEN 1 
		WHEN mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10','12','54','C1','C5','C6','C9','CA','CB','CC','CD','CE')		THEN 1 
		WHEN mandant_id = 7 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10','11','50','54','F0','F1','F3','F4','F5','F7','F8','F9','FB','FC') THEN 1 
		WHEN mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('10','11','20','21','50','52','54','G3')		THEN 1 
		WHEN mandant_id = 4 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('54','I0','I1','I2','I5','I9','IA','IB','ID','IE','IF','IH','II','IJ','IK','IL','IM','IN','IO','IP','IQ','IV','IY','IZ') THEN 1 
		ELSE 0
	END AS austritt_ag_fg
	, austritt_an_fg + austritt_ag_fg AS austritt_fluktuation_fg /* Fluktuation (Austritte AN/AG) 2021-05 */
	, CASE /* Austritt Tod/Rente (NEU ohne Wechsel) 2021-08*/
		WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73','98','99') THEN 1  
		WHEN mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73','98','99') THEN 1 
		WHEN mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73','98','99') THEN 1 
		WHEN mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73','98','99','C0','C7','C8') THEN 1 
		WHEN mandant_id = 7 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73','98','99','F6','I4')  THEN 1 
		WHEN mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70','91','98','99')		THEN 1 
		WHEN mandant_id = 4 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('I4','I7','IZ') THEN 1 
		ELSE 0
	END AS austritt_trw_fg
	, CASE /* Austritt Vertragsablauf 2021-08 */ 
		WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70','71','73','B1','B2') THEN 1 
		WHEN mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70','71','E0','E1','E2') THEN 1 
		WHEN mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70','71','73') THEN 1 
		WHEN mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70','73','C4','CF','CI') THEN 1 
		WHEN mandant_id = 7 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70','73','FD') THEN 1 
		WHEN mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('70','G2') THEN 1 
		WHEN mandant_id = 4 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('73','I4','IC') THEN 1 
		ELSE 0
	END AS austritt_vtg_fg
, CASE /* Austritt Arbeit nicht aufgenommen 2021-08 */ 
		WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('90') THEN 1 
		WHEN mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('90') THEN 1 
		WHEN mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('90') THEN 1 
		WHEN mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('90') THEN 1 
		/* WHEN mandant_id = 7 -- ohne RO */
		WHEN mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('G1') THEN 1 
		/* WHEN mandant_id = 4 -- ohne MD */
		ELSE 0
	END AS austritt_ana_fg
, CASE /* Austritt Integration in UGS 2021-05 */ 
		WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92')  THEN 1
		WHEN mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92','B6') THEN 1
		WHEN mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92')  THEN 1
		WHEN mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92')  THEN 1
		WHEN mandant_id = 7 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92')  THEN 1
		WHEN mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92')  THEN 1
		WHEN mandant_id = 4 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('92')  THEN 1
		ELSE 0
	END AS austritt_ugsi_fg
, CASE /* Austritt Wechsel innerhalb UGS 2021-05*/ 
		WHEN mandant_id = 2 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91')  THEN 1
		WHEN mandant_id = 5 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91')  THEN 1
		WHEN mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91')  THEN 1
		WHEN mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91','CG') THEN 1
		WHEN mandant_id = 7 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91')  THEN 1
		WHEN mandant_id = 8 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91')  THEN 1
		WHEN mandant_id = 4 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('91')  THEN 1
		ELSE 0
	END AS austritt_ugsw_fg
, CASE /* Austritt Berufsunfaehigkeit 2021-05 */ 
		/* WHEN mandant_id = 2 -- ohne CZ */
		/* WHEN mandant_id = 5 -- ohne SK */
		WHEN mandant_id = 6 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('D0') THEN 1
		WHEN mandant_id = 3 AND hr_massnahme_id IN ('04') AND hr_massnahme_grund_id IN ('C0') THEN 1
		/* WHEN mandant_id = 7 -- ohne RO */
		/* WHEN mandant_id = 8 -- ohne BG */
		/* WHEN mandant_id = 4 -- ohne MD */
		ELSE 0
	END AS austritt_bu_fg
	FROM dbp_view.v_ma_hr_massnahme_zu_per v095
	WHERE v095.hr_massnahme_id = '04'
) massn_austritt
ON  massn_austritt.mitarbeiter_id = ma_bew.mitarbeiter_id AND massn_austritt.mandant_id = ma_bew.mandant_id AND massn_austritt.kjmo = ma_bew.kjmo

/*	Abwesenheit pro Mitarbeiter (Gruppiert)
	Krank + Berufsunfaehig -- 2023-04, 2023-07, 2023-11 
	Kroatien auskommentiert, da Umstellung auf Lohnarten -- 2024-09 */
LEFT JOIN ( 
	SELECT mandant_id, mitarbeiter_id, kjmo
	, SUM(CASE 
		WHEN mandant_id = 2 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0200','0201','0204','0205','0209','0210','0211','0215','0220','0221','0225','0260','0261','0265') THEN abwesenheit_stunden
		WHEN mandant_id = 5 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0112','0114','0400','0401','0403','0405','0406','0407','0410','0411','0415','0420','0421','0425')THEN abwesenheit_stunden
		/* WHEN mandant_id = 6 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0130','0140','0142','0160','0210','0300','0305','0306','0308','0309','0310','9015','9016','9017','9413','9414','9415','9419') THEN abwesenheit_stunden */
		WHEN mandant_id = 3 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0200','0210','0211','0212','0220','0290','0291','9019','9420','9450') THEN abwesenheit_stunden
		WHEN mandant_id = 7 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0200','0206','0218','0240','0241','0242','0251','0252','0253','0254','0260','0250','9001','9017','9251','9429','9432','9434') THEN abwesenheit_stunden
		WHEN mandant_id = 8 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0200','0201','0207','0210','0270','0271','0272','0273','0274','0276','0277','0296','0297')THEN abwesenheit_stunden
		WHEN mandant_id = 4 AND abwesenheit_stunden > 0 AND abwesenheit_id IN ('0200','0240','0241','0250','0254','0260','0296','0297','9001','9010','9017','9432','9610','9611') THEN abwesenheit_stunden
		ELSE 0.00
	END) AS std_abwesenheit 
	FROM dbp_view.v_ma_abwesenh_zu_per
	GROUP BY ALL
) abwesenh_krank
ON  abwesenh_krank.mitarbeiter_id = ma_bew.mitarbeiter_id AND abwesenh_krank.mandant_id = ma_bew.mandant_id AND abwesenh_krank.kjmo = ma_bew.kjmo

/*	Lohnarten pro Kostenstelle/MA (gruppiert)
	Stunden Soll = Lohnart ('9216') + abrechnungstyp_fuer_periode <> 'R' -- 2023-10
	Stunden Urlaub Abgeltung = Lohnarten (...)
	Stunden Zuschlaege : Feiertag, Mehrarbeit, Nacht, Wochenend = Lohnarten (...)
	Stunden Mehrarbeit ausbezahlt = Lohnarten (...)
	Stunden Abwesenheit = Lohnarten (...) nur für Kroatien -- 2024-09
	ohne kostenstelle_id -- 2024-09 */ 
LEFT JOIN (
	SELECT mandant_id, mitarbeiter_id, kjmo
	/*, kostenstelle_id */
	, SUM(CASE /* Umstellung Stunden Abwesenheit auf Lohnarten (nur Kroatien */
		WHEN mandant_id = 6 AND lohnart_id IN ('6866','6866R','6877','6877R','6878','6878R','6734','6734R','6735','6735R','6853','6853R','6854','6854R','6810','6810R') THEN anzahl_lohnart
		ELSE 0.00
	  END) AS std_abwesenheit_lohnart
	, SUM(CASE
		WHEN mandant_id = 2 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 5 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 6 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 3 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 7 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 8 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 4 AND lohnart_id IN ('9216') AND abrechnungstyp_fuer_periode <> 'R' AND anzahl_lohnart > 0 THEN anzahl_lohnart 
		ELSE 0.00
		END) AS std_soll
	, SUM(CASE
		WHEN mandant_id = 2 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 5 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 6 AND lohnart_id IN ('2173') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 3 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 7 AND lohnart_id IN ('1010') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 8 AND lohnart_id IN ('2170') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 4 AND lohnart_id IN ('1010','2170') AND anzahl_lohnart > 0 THEN anzahl_lohnart 
		ELSE 0.00
	  END) AS std_urlaub_abgeltung
	, SUM(CASE
		WHEN mandant_id = 2 AND lohnart_id IN ('3200') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 5 AND lohnart_id IN ('3200','3222') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 6 AND lohnart_id IN ('3200','3453') AND anzahl_lohnart > 0 THEN anzahl_lohnart 
		/* WHEN mandant_id = 3  -- ohne PL */
		WHEN mandant_id = 7 AND lohnart_id IN ('3200') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 8 AND lohnart_id IN ('3200') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 4 AND lohnart_id IN ('3200') AND anzahl_lohnart > 0 THEN anzahl_lohnart 
		ELSE 0.00
	  END) AS std_feiertag_zuschlag
	, SUM(CASE
		WHEN mandant_id = 2 AND lohnart_id IN ('3062','3100','3101','3103') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 5 AND lohnart_id IN ('3100','3105') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 6 AND lohnart_id IN ('3451') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 3 AND lohnart_id IN ('3108','3111','3112','3113','3114') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 7 AND lohnart_id IN ('3057','3111','3195','3196') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 8 AND lohnart_id IN ('3100','3101','3102','3118') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 4 AND lohnart_id IN ('3111','3193') AND anzahl_lohnart > 0 THEN anzahl_lohnart 
		ELSE 0.00
	  END) AS std_mehr_zuschlag
	, SUM(CASE
		WHEN mandant_id = 2 AND lohnart_id IN ('3251') AND anzahl_lohnart > 0 THEN anzahl_lohnart 
		WHEN mandant_id = 5 AND lohnart_id IN ('3251','3278') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 6 AND lohnart_id IN ('3250','3454') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 3 AND lohnart_id IN ('3250') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 7 AND lohnart_id IN ('3250') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 8 AND lohnart_id IN ('3250') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 4 AND lohnart_id IN ('3250') AND anzahl_lohnart > 0 THEN anzahl_lohnart 
		ELSE 0.00
	  END) AS std_nacht_zuschlag
	, SUM(CASE
		WHEN mandant_id = 2 AND lohnart_id IN ('3300') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 5 AND lohnart_id IN ('3151','3221') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 6 AND lohnart_id IN ('3150','3452') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 3 AND lohnart_id IN ('3150') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 7 AND lohnart_id IN ('3159','3303') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 8 AND lohnart_id IN ('3300') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 4 AND lohnart_id IN ('3159','3303') AND anzahl_lohnart > 0 THEN anzahl_lohnart 
		ELSE 0.00
	  END) AS std_wochenend_zuschlag
	, SUM(CASE
		WHEN mandant_id = 2 AND lohnart_id IN ('3050','3051','3054','3060','3070') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 5 AND lohnart_id IN ('3051') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 6 AND lohnart_id IN ('3450') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 3 AND lohnart_id IN ('3050','3051','3055') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 7 AND lohnart_id IN ('3110','3119','3051','3058') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 8 AND lohnart_id IN ('3050','3051') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		WHEN mandant_id = 4 AND lohnart_id IN ('3110','3192') AND anzahl_lohnart > 0 THEN anzahl_lohnart
		ELSE 0.00
	  END) AS std_mehr_ausbezahlt
	FROM dbp_view.v_ma_kostenstelle_lohnart_zu_per
	GROUP BY ALL
) kost_lohn
ON kost_lohn.mitarbeiter_id = ma_bew.mitarbeiter_id AND kost_lohn.mandant_id = ma_bew.mandant_id 
AND kost_lohn.kjmo = ma_bew.kjmo /* AND kost_lohn.kostenstelle_id = ma_bew.kostenstelle_id */

/*	Bereich (hr_objekt_bereich_id) + Org-Einheit (hr_objekt_id) */
LEFT JOIN dbp_view.v_l_org_einheit org_eh
ON org_eh.hr_objekt_id = ma_bew.hr_objekt_id AND org_eh.mandant_id = ma_bew.mandant_id

/*	nur Ausland ohne DE */ 
WHERE ma_bew.mandant_id > 1 
;