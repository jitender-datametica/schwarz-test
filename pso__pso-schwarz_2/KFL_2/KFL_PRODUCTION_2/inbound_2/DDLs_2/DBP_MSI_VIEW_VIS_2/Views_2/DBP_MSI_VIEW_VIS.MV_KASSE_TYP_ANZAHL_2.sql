CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KASSE_TYP_ANZAHL_2 (
	MANDANT_ID COMMENT 'Mandant_2 im DWH',
	WUP_ID COMMENT 'Der "WUP_2" beinhaltet Märkte und Lager. WUP_2 = WarenUmschlagsPlatz. Mutter WUP_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	ANZ_KASSE_GES COMMENT 'Gesamtzahl von Kassen',
	ANZ_KASSE_00 COMMENT 'Anzahl an Kassen mit Kassentyp -1 oder 0 (default DWH, unbekannt)',
	ANZ_KASSE_01 COMMENT 'Anzahl an Kassen mit Kassentyp 1 (normal)',
	ANZ_KASSE_02 COMMENT 'Anzahl an Kassen mit Kassentyp 2 (Info)',
	ANZ_KASSE_03 COMMENT 'Anzahl an Kassen mit Kassentyp 3 (Leergut)',
	ANZ_KASSE_04 COMMENT 'Anzahl an Kassen mit Kassentyp 4 (Server)',
	ANZ_KASSE_05 COMMENT 'Anzahl an Kassen mit Kassentyp 5 (Imbiss)',
	ANZ_KASSE_06 COMMENT 'Anzahl an Kassen mit Kassentyp 6 (Mobile)',
	ANZ_KASSE_07 COMMENT 'Anzahl an Kassen mit Kassentyp 7 (Notfall)',
	ANZ_KASSE_08 COMMENT 'Anzahl an Kassen mit Kassentyp 8 (SCO)',
	ANZ_KASSE_09 COMMENT 'Anzahl an Kassen mit Kassentyp 9 (SCO cashless)',
	ANZ_KASSE_10 COMMENT 'Anzahl an Kassen mit Kassentyp 10 (Paystation)',
	ANZ_KASSE_11 COMMENT 'Anzahl an Kassen mit Kassentyp 11 (Paystation cashless)',
	ANZ_KASSE_KONVENTIONELL COMMENT 'Anzahl an konventionellen Kassen (Kassentyp 1, 3, 4, 5, 6, 7)',
	ANZ_KASSE_SCO COMMENT 'Anzahl an SCO Kassen (Kassentyp 8, 9, 10, 11)',
	ANZ_KASSE_SCO_CASH COMMENT 'Anzahl an SCO Kassen mit Cash-Modul (Kassentyp 8, 10)',
	DAT_VON COMMENT 'Beginn des Gültigkeitzeitraums',
	DAT_BIS COMMENT 'Ende des Gültigkeitzeitraums',
	VALID_FG COMMENT 'Flag für aktuelle Gültigkeit'
) COMMENT = 'Alle Kassentypen mit der zugehörigen Anzahl an Kassen pro Filiale und Zeitraum' 
AS 
/*
Fakten für Anzahl Kassen eines Kassentyps pro Filiale und Tag_2 bzw. Zeitraum
2024-11-20 tekin: Initial
*/
WITH 
facts AS (
	SELECT k.mandant_id
		, w.aktuell_wup_id AS wup_id -- Filialumgliederung 
		, k.kasse_nr
		, k.dat_von
		, k.dat_bis
		, k.kasse_typ_id
		, t.dat
--		, b.kasse_typ_bez
--		, b.kasse_name_bez
	FROM dbp_view.v_kasse_typ_per_2 k -- PK (mandant_id, wup_id, kasse_nr, dat_bis) 
	INNER JOIN dbp_view.v_tag_2 t
		ON t.dat BETWEEN k.dat_von AND k.dat_bis
			AND t.dat <= CURRENT_DATE
--	INNER JOIN dbp_ods.kasse_typ_spr_zu_2 b -- Bezeichnungen fuer den Kassentyp (-1 default DWH, 0 unbekannt, 1 normal, 2 Info, 3 Leergut, 4 Server, 5 Imbiss, 6 Mobile, 7 Notfall, 8 SCO, 9 SCO cashless, 10 Paystation, 11 Paystation cashless)
--		ON k.kasse_typ_id = b.kasse_typ_id
	INNER JOIN dbp_view.v_wup_2 w 
		ON k.mandant_id = w.mandant_id
			AND k.wup_id = w.wup_id
	),
/* count all tills per till type */ 
number_of_till_types AS (
	SELECT mandant_id
		, wup_id
		, dat
		, COUNT(kasse_nr) AS anz_kasse_ges
		, COUNT_IF(kasse_typ_id <= 0) AS anz_kasse_00 
		, COUNT_IF(kasse_typ_id = 1) AS anz_kasse_01 
		, COUNT_IF(kasse_typ_id = 2) AS anz_kasse_02 
		, COUNT_IF(kasse_typ_id = 3) AS anz_kasse_03 
		, COUNT_IF(kasse_typ_id = 4) AS anz_kasse_04 
		, COUNT_IF(kasse_typ_id = 5) AS anz_kasse_05
		, COUNT_IF(kasse_typ_id = 6) AS anz_kasse_06 
		, COUNT_IF(kasse_typ_id = 7) AS anz_kasse_07 
		, COUNT_IF(kasse_typ_id = 8) AS anz_kasse_08 
		, COUNT_IF(kasse_typ_id = 9) AS anz_kasse_09 
		, COUNT_IF(kasse_typ_id = 10) AS anz_kasse_10
		, COUNT_IF(kasse_typ_id = 11) AS anz_kasse_11 
	FROM facts
	GROUP BY mandant_id
		, wup_id
		, dat
	),
/* identify changes of any till type to reduce the number of rows and cluster in change periods in the next step */  
till_type_changes AS (
	SELECT mandant_id
		, wup_id
		, dat
		, anz_kasse_ges
		, anz_kasse_00
		, anz_kasse_01
		, anz_kasse_02
		, anz_kasse_03
		, anz_kasse_04
		, anz_kasse_05
		, anz_kasse_06
		, anz_kasse_07
		, anz_kasse_08
		, anz_kasse_09
		, anz_kasse_10
		, anz_kasse_11
		, CONDITIONAL_CHANGE_EVENT(anz_kasse_00 || anz_kasse_01 || anz_kasse_02 || anz_kasse_03 || anz_kasse_04 || anz_kasse_05 || anz_kasse_06 || anz_kasse_07 || anz_kasse_08 || anz_kasse_09 || anz_kasse_10 || anz_kasse_11) OVER (
			PARTITION BY mandant_id, wup_id 
			ORDER BY dat
			) AS aenderungen -- Anzahl an Aenderungen in einer der Anzahlen von Kassen oder Kassentypen pro Tag_2 
	FROM number_of_till_types
	)
/* aggregate rows by change and group them in validity_2 periods */ 
SELECT mandant_id
	, wup_id
	--, aenderungen
	, anz_kasse_ges
	, anz_kasse_00
	, anz_kasse_01
	, anz_kasse_02
	, anz_kasse_03
	, anz_kasse_04
	, anz_kasse_05
	, anz_kasse_06
	, anz_kasse_07
	, anz_kasse_08
	, anz_kasse_09
	, anz_kasse_10
	, anz_kasse_11
	, anz_kasse_01 + anz_kasse_03 + anz_kasse_04 + anz_kasse_05 + anz_kasse_06 + anz_kasse_07 AS anz_kasse_konventionell -- Kassen konventionell (Kassentyp 1, 3, 4, 5, 6, 7)
	, anz_kasse_08 + anz_kasse_09 + anz_kasse_10 + anz_kasse_11 AS anz_kasse_sco -- SCO Kassen (Kassentyp 8, 9, 10, 11)
	, anz_kasse_08 + anz_kasse_10 AS anz_kasse_sco_cash -- SCO Kassen mit Cash-Modul (Kassentyp 8, 10)
	, MIN(dat) AS dat_von
	, MAX(dat) AS dat_bis 
	, IFF(ROW_NUMBER() OVER (
		PARTITION BY mandant_id, wup_id 
		ORDER BY dat_bis DESC
		) = 1, 1, 0) AS valid_fg -- shows the latest row for a store 
FROM till_type_changes
GROUP BY mandant_id
	, wup_id
	, aenderungen
	, anz_kasse_ges
	, anz_kasse_00
	, anz_kasse_01
	, anz_kasse_02
	, anz_kasse_03
	, anz_kasse_04
	, anz_kasse_05
	, anz_kasse_06
	, anz_kasse_07
	, anz_kasse_08
	, anz_kasse_09
	, anz_kasse_10
	, anz_kasse_11
--ORDER BY mandant_id, wup_id, dat_von, dat_bis
;
