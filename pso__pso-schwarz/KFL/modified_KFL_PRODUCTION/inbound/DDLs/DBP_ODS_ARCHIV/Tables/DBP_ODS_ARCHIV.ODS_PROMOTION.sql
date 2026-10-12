CREATE TABLE DBP_ODS_ARCHIV.ODS_PROMOTION  CLUSTER BY (
      mandant_id,
      bon_dat,
      wup_id
 )(
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land',
   bon_id                              VARCHAR(25)     NOT NULL COMMENT 'eindeutige ID eines Bons, generierter Hashwert',
   wup_id                              INTEGER    NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft',
   bon_zeile                           INTEGER    NOT NULL,
   bonuskauf_id                        VARCHAR(20)     NOT NULL COMMENT 'ID der Promotion',
   konditionsart_id                    VARCHAR(4)      NOT NULL COMMENT 'ID der Konditions- bzw. Rabattart',
   promotion_lfd_nr                    INTEGER    NOT NULL COMMENT 'Zusätzlicher Zähler beginnt nicht bei 1!',
   betrag_promo_brutto                 NUMBER(29,4)    COMMENT 'Promotionsbetrag',
   kl_art_id                           INTEGER    COMMENT 'In der Promotion verkaufte Menge',
   start_bon_zeile                     TIMESTAMP_LTZ   COMMENT 'Zeitstempel bei Beginn der Bewegung',
   menge_promo                         NUMBER(29,3)    COMMENT 'Promotionsmenge: TAG - ReferenceQuantity',
   umsatz_promo_brutto                 NUMBER(29,4)    COMMENT 'Promotionsumsatz brutto - Berechnung: menge_promo x Stück VK - betrag_promo_brutto',
   bon_dat                             DATE            NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey',
   customer_promotion_fg               INTEGER   DEFAULT 0  NOT NULL COMMENT 'Zeigt an ob es sich um eine K Card Promotion handelt (1=wahr, 0=falsch)',
   promotion_art                       VARCHAR(100)    COMMENT 'Zeigt an um welche Art der Promotion es sich handelt (CUSTOMER = K Card, PERSONAL = K Card personalisiert, COMMON = nicht K Card gebunden) '
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'ODS - Bon- Promotionsdaten aus den Kassensystemen. Dient als Quelle der Tabelle artbew_promotion_zu';
