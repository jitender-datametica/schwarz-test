CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_L_MIETVERTRAG_2(
	MANDANT_ID,
	MV_INTRENO,
	MV_BRANCHE_ID,
	MAN_VERMIETUNGSAUFTRAG_ID,
	ANLASS_ZWVERMIETUNG_ID,
	VERTRAGSART_ID,
	MIETVERTRAG_NR,
	MV_OBJEKT_NR,
	ANSCHLUSS_MIETVERTRAG,
	MV_OPTION,
	DAT_KUEND_EINGANG_BIS,
	DAT_KUEND_BERECHNET_ZUM,
	KUEND_PARTEI,
	KUEND_FRIST,
	DAT_MIET_BEGINN,
	DAT_MIET_ENDE,
	RESTLAUFZEIT_MONATE,
	MV_AKT_GUELTIG_FG,
	UNBEFRISTET_FG,
	MIETVERTRAG_NR_ALT,
	DAT_AKTIVIERUNG
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.mv_intreno, v1.branche_id AS mv_branche_id, v1.man_vermietungsauftrag_id, v1.anlass_zwvermietung_id, v1.vertragsart_id, v1.mietvertrag_nr, v1.mv_objekt_nr, v1.anschluss_mietvertrag, CASE WHEN v1.mv_option<>''THEN v1.mv_option || '/' || CASE WHEN v1.mv_option_bez = 'T' THEN 'A' ELSE v1.mv_option_bez END ELSE v1.mv_option END AS mv_option, v1.dat_kuend_eingang_bis, v1.dat_kuend_berechnet_zum, v1.kuend_partei, v1.kuend_frist, v1.dat_miet_beginn, v1.dat_miet_ende, (CASE WHEN CURRENT_DATE BETWEEN dat_miet_beginn AND dat_miet_ende THEN ((TRUNC((dat_miet_ende- "CURRENT_DATE")/30))+0.5) ELSE 0 END) AS restlaufzeit_monate, (CASE WHEN CURRENT_DATE BETWEEN dat_miet_beginn AND dat_miet_ende THEN 1 ELSE 0 END) AS mv_akt_gueltig_fg, 
   (CASE WHEN (dat_miet_ende IS NULL OR dat_miet_ende = '9999-12-31') THEN 1 ELSE 0 END) AS unbefristet_fg, v1.mietvertrag_nr_alt, v1.dat_aktivierung
   FROM dbp_view.v_immo_mietvertrag_per_2 v1
   

   UNION ALL
   

   SELECT
   mandant_id, '' AS mv_intreno, 0 AS mv_branche_id, 0 AS man_vermietungsauftrag_id, 0 AS anlass_zwvermietung_id, 0 AS vertragsart_id, '' AS mietvertrag_nr, '' AS mv_objekt_nr, '' AS anschluss_mietvertrag, '' AS mv_option, CAST ('9999-12-31' AS VARCHAR) AS dat_kuend_eingang_bis, CAST ('9999-12-31' AS VARCHAR) AS dat_kuend_berechnet_zum, '' AS kuend_partei, '' AS kuend_frist, CAST ('1900-01-01' AS VARCHAR) AS dat_miet_beginn, CAST ('9999-12-31' AS VARCHAR) AS dat_miet_ende, 0 AS restlaufzeit_monate, 1 AS mv_akt_gueltig_fg, 0 AS unbefristet_fg, '' AS mietvertrag_nr_alt, CAST ('9999-12-31' AS VARCHAR) AS dat_aktivierung
   FROM dbp_view.v_mandant_2;