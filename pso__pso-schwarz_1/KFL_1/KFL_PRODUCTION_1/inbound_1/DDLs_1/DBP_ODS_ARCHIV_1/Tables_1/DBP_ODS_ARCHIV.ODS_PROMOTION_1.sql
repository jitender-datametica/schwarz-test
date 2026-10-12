create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_ODS_ARCHIV.ODS_PROMOTION_1 cluster by (
      mandant_id,
      bon_dat,
      wup_id
 )(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land_1',
	BON_ID VARCHAR(25) NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft',
	BON_ZEILE NUMBER(38,0) NOT NULL,
	BONUSKAUF_ID VARCHAR(20) NOT NULL COMMENT 'ID der Promotion',
	KONDITIONSART_ID VARCHAR(4) NOT NULL COMMENT 'ID der Konditions- bzw. Rabattart',
	PROMOTION_LFD_NR NUMBER(38,0) NOT NULL COMMENT 'Zusätzlicher Zähler beginnt nicht bei 1!',
	BETRAG_PROMO_BRUTTO NUMBER(18,4) COMMENT 'Promotionsbetrag',
	KL_ART_ID NUMBER(38,0) COMMENT 'In der Promotion verkaufte Menge',
	START_BON_ZEILE TIMESTAMP_LTZ(9) COMMENT 'Zeitstempel bei Beginn der Bewegung',
	MENGE_PROMO NUMBER(18,3) COMMENT 'Promotionsmenge: TAG_1 - ReferenceQuantity',
	UMSATZ_PROMO_BRUTTO NUMBER(18,4) COMMENT 'Promotionsumsatz brutto - Berechnung: menge_promo x Stück VK_1 - betrag_promo_brutto',
	BON_DAT DATE NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
	CUSTOMER_PROMOTION_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Zeigt an ob es sich um eine_1 K Card Promotion handelt (1=wahr, 0=falsch)',
	PROMOTION_ART VARCHAR(100) COMMENT 'Zeigt an um welche Art_1 der Promotion es sich handelt (CUSTOMER = K Card, PERSONAL = K Card personalisiert, COMMON = nicht K Card gebunden) ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='ODS - Bon- Promotionsdaten aus den Kassensystemen. Dient als Quelle der Tabelle artbew_promotion_zu_1'
;
