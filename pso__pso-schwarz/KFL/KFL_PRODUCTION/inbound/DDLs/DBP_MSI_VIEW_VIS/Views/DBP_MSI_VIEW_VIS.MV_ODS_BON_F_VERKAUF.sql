CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_F_VERKAUF (
	BON_ID
	, BON_DAT
	, BON_BOOKING
	, DAT_BOOKING
	, WUP_ID
	, MANDANT_ID
	, KASSE_NR
	, KUNDE_FG
	, BON_BEGINN
	, BON_ENDE
	, TURNOVER_FG
	, WRG_ID
	, BON_ZEILE
	, KL_ART_ID
	, EAN_KASSE
	, WG_ID
	, MENGE
	, EINH_ID
	, UMSATZ_BRUTTO
	, KPOS_ERFASSUNG_ID
	, MWST
	, MWST_ID
	, START_BON_ZEILE COMMENT 'Zeitstempel der Erfassung dieser Bonzeile'
	, BARCODE_STRING COMMENT 'Barcode String des Artikels'
	, BARCODE_LEERGUT COMMENT 'Barcode des eingelösten Pfandbons'
	, ZEILENSTORNO_FG COMMENT '1 = diese Zeile ist eine Stornozeile. Beträge und Mengen sind negativ. Sie saldiert eine Vorgängerzeile damit auf 0. Die stornierte Zeile selbst hat kein Stornoflag.'
	) AS
-- Fakt-View
-- Gefiltert, d.h. nur nicht stornierte Bons enthalten
-- 2014KW05 : Anpassung MWSt (ID anstelle Satz)
-- 20140211 : Korrektur MWSt (Join auf LU)
-- 20190819 : Einfügen bon_dat in Join-Bedingung wegen Bondaten RDS
-- 20200527 : snik1809 -  uncommented wg_id
-- 20200603 : snik1809 - including v.mwst_id
-- 20200619 : join mwst auf dat between geändert
-- 31.08.2022 snik1809 : WRG updated with latest changes - PRJTASK0013908
-- 2023-05-22 snik1809 : turnover_fg = 1
-- 2023-08-14 staeblern: SPEC0189820 entfernen  Kassentyp
-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
-- 2024-10-16 muellerpatri : Filter auf wg_id <> 961 hinzugefügt [SPEC0276475]
-- 2025-06-25 tekin: vier neue Spalten zu Bonzeilen ergaenzt
SELECT k.bon_id
	, k.bon_dat
	, k.bon_booking
	, k.dat_booking
	, wup.aktuell_wup_id AS wup_id
	, k.mandant_id
	, k.kasse_nr
	, k.kunde_fg
	, k.bon_beginn
	, k.bon_ende
	, k.turnover_fg
	, krs.nach_wrg_id AS wrg_id
	, v.bon_zeile
	, v.kl_art_id
	, v.ean_kasse
	, v.wg_id
	, v.menge
	, v.einh_id
	, v.umsatz_brutto * krs.umrechnungskurs AS umsatz_brutto
	, v.kpos_erfassung_id
	, m.mwst
	, v.mwst_id
-- ,v.erfassung_id
-- ,v.aktion_id
	, v.start_bon_zeile
	, v.barcode_string
	, v.barcode_leergut
	, v.zeilenstorno_fg
FROM dbp_v_ods.v_ods_bon_kopf k
INNER JOIN dbp_v_ods.v_ods_bon_verkauf v
	ON k.bon_id = v.bon_id
		AND k.wup_id = v.wup_id
		AND k.mandant_id = v.mandant_id
		AND k.bon_dat = v.bon_dat
INNER JOIN dbp_view.v_mwst_per m
	ON v.mandant_id = m.mandant_id
		AND v.mwst_id = m.mwst_id
		AND k.bon_dat BETWEEN m.dat_von AND m.dat_bis
INNER JOIN (
	SELECT krs1.von_wrg_id
		, krs1.nach_wrg_id
		, krs1.umrechnungskurs
	FROM dbp_data.kurs krs1
	WHERE krs1.kurstyp_id = 3
		AND krs1.dat_bis = '9999-12-31'
		AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
	UNION ALL
	SELECT krs2.von_wrg_id
		, krs2.von_wrg_id
		, 1.0000
	FROM dbp_data.kurs krs2
	WHERE krs2.kurstyp_id = 3
		AND krs2.dat_bis = '9999-12-31'
		AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')
	) krs
	ON krs.von_wrg_id = k.WRG_ID
INNER JOIN dbp_view.v_wup wup
	ON k.mandant_id = wup.mandant_id
		AND k.wup_id = wup.wup_id
WHERE (k.bon_id, k.wup_id, k.mandant_id) NOT IN (
	SELECT bon_id
		, wup_id
		, mandant_id
	FROM dbp_v_ods.v_ods_bon_storno
	)
	AND k.turnover_fg = 1
	AND v.wg_id <> 961
;

