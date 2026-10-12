CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_ALTVERTRAEGE_MAP_1(
	MANDANT_ID,
	MV_INTRENO,
	MIETVERTRAG_NR,
	MELDEREGEL,
	VERSION,
	KJMO,
	RHYTHMUS_ART,
	DAT_MELDUNGSINTERVALL_VON,
	DAT_MELDUNGSINTERVALL_BIS,
	WRG_ID,
	UMSATZKENNUNG,
	NULLUMSATZ,
	UMSATZ_NETTO,
	UMSATZ_BRUTTO,
	ERFASSER,
	DAT_ERSTERFASSUNG,
	DAT_LETZTE_BEARBEITUNG
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.mv_intreno, v2.mietvertrag_nr, v1.melderegel, v1.VERSION, v1.kjmo, v1.rhythmus_art, v1.dat_meldungsintervall_von, v1.dat_meldungsintervall_bis, v1.wrg_id, v1.umsatzkennung, v1.nullumsatz, v1.umsatz_netto, v1.umsatz_brutto, v1.erfasser, v1.dat_ersterfassung, v1.dat_letzte_bearbeitung
   FROM dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_1 v1
   INNER JOIN dbp_msi_view_immo.mv_l_mietvertrag_umsatz_konz_hilf_1 v2
   ON v1.mv_intreno=v2.mv_intreno AND v1.mandant_id=v2.mandant_id
   WHERE v1.rhythmus_art='0001' AND v1.nullumsatz<>'X'
   AND v1.VERSION=(SELECT MAX(VERSION) FROM dbp_view.v_immo_mietvertrag_umsatzvereinbarung_per_1  v3 WHERE v1.mv_intreno=v3.mv_intreno AND v1.kjmo=v3.kjmo AND v1.melderegel=v3.melderegel);