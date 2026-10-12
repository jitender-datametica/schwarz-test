CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_MIETVERTRAG_PER(
	MANDANT_ID,
	MIETVERTRAG_ID,
	DAT_VON,
	DAT_BIS,
	DAT_VERTRAG_BEGINN,
	DAT_VERTRAG_ENDE,
	VERTRAGART_ID,
	VERTRAG_STATUS_FG,
	KONZESSIONAER_ID,
	VERMIETER_ID,
	LAUFZEIT_ENDE,
	LAUFZEIT_BEGINN,
	DAT_KUENDBAR_ZUM,
	DAT_KUENDIGUNG,
	KUENDIGUNG_FRIST,
	KUEND_FRIST_BEZ,
	KAUTION,
	NEBENKOSTEN_BETRAG,
	NEBENKOSTEN_ABSCHLAG,
	SONDERREGELUNG_FG,
	MIETINDEX_PROZENT,
	DAT_MIETINDEX,
	MIETAUFTRAG_ID,
	MIETVERTRAG_OPTION,
	OPTION_BEZ,
	DEBITOR_MIETE_ID,
	DEBITOR_WERBUNG_ID,
	WRG_ID,
	WRG_TYP_ID,
	MIETVERTRAG_NR
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS


SELECT
mv.mandant_id
,mv.mietvertrag_id
,mv.dat_von
,mv.dat_bis
,mv.dat_vertrag_beginn
,COALESCE(mv.dat_vertrag_ende, CAST('9999-12-31' AS DATE )) dat_vertrag_ende
,mv.vertragart_id
,mv.vertrag_status_fg
,mv.konzessionaer_id
,mv.vermieter_id
,CAST(CASE WHEN mv.dat_vertrag_ende BETWEEN CURRENT_DATE AND '9999-12-31'
THEN (dat_vertrag_ende - CURRENT_DATE) / 30
ELSE 0
END AS INTEGER) laufzeit_ende
,CAST(CASE WHEN mv.dat_vertrag_beginn BETWEEN '1900-01-31' AND CURRENT_DATE
THEN (CURRENT_DATE - dat_vertrag_beginn) / 30
ELSE 0
END AS INTEGER) laufzeit_beginn
,COALESCE(mv.dat_kuendbar_zum, CAST('9999-12-31' AS DATE )) dat_kuendbar_zum
,dat_kuendigung
,COALESCE(mv.kuendigung_frist, CAST(0 AS INTEGER)) AS kuendigung_frist
,COALESCE(mv.kuend_frist_bez, CAST('' AS VARCHAR(20))) AS kuend_frist_bez
,mv.betrag_kaution       * kurs kaution
,mv.nebenkosten_betrag   * kurs nebenkosten_betrag
,mv.nebenkosten_abschlag * kurs nebenkosten_abschlag
,mv.sonderregelung_fg
,mv.mietindex_prozent
,mv.dat_mietindex
,mv.mietauftrag_id
,mv.mietvertrag_option
,mv.mietvertrag_option AS option_bez
,mv.debitor_miete_id    
,mv.debitor_werbung_id  
,kurs.wrg_id
,kurs.wrg_typ_id
,mv.mietvertrag_nr
FROM dbp_view.v_ivs_mietvertrag_per mv

INNER JOIN dbp_msi_view_immo.mv_mand_wrg_kurs_zu_per  kurs
ON kurs.mandant_id = mv.mandant_id
AND CURRENT_DATE BETWEEN kurs_dat_von AND kurs_dat_bis

WHERE mv.dat_bis = '9999-12-31'

UNION ALL  

SELECT
mwt.mandant_id
,'0' AS mietvertrag_id
,CAST('1900-01-01' AS DATE ) AS dat_von
,CAST('9999-12-31' AS DATE ) AS dat_bis
,CAST('1900-01-01' AS DATE ) AS dat_vertrag_beginn
,CAST('9999-12-31' AS DATE ) AS dat_vertrag_ende
,'000'::CHAR(3) AS vertragart_id
,'0' ::CHAR(1) AS vertrag_status_fg
,'0' ::VARCHAR(20) AS konzessionaer_id
,(mwt.mandant_id * -1) ::INTEGER AS vermieter_id
,CAST (0 AS INTEGER) AS laufzeit_ende
,CAST (0 AS INTEGER) AS laufzeit_beginn
,CAST('9999-12-31' AS DATE ) AS dat_kuendbar_zum
,CAST('9999-12-31' AS DATE ) AS dat_kuendigung
,0 ::INTEGER AS kuendigung_frist
,'' ::VARCHAR(20) AS kuend_frist_bez
,0 ::DECIMAL(18,4) AS betrag_kaution
,0 ::DECIMAL(18,4) AS nebenkosten_betrag
,0 ::DECIMAL(18,4) AS nebenkosten_abschlag
,0 ::BYTEINT AS sonderregelung_fg
,0 ::DECIMAL(9,4) AS mietindex_prozent
,CAST('1900-01-01' AS DATE )  AS dat_mietindex
,0 ::BYTEINT mietauftrag_id
,''::VARCHAR(10) mietvertrag_option
,''::VARCHAR(40) AS option_bez
,0 ::DECIMAL(18,0) AS debitor_miete_id
,0 ::DECIMAL(18,0) AS debitor_werbung_id
,mwt.wrg_id
,mwt.wrg_typ_id
,'0' AS mietvertrag_nr
FROM dbp_view.v_mandant_wrg_typ_zu mwt
;