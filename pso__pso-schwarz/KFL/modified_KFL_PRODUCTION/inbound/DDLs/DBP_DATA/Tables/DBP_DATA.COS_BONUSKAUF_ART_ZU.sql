--==============================================================
-- Table: cos_bonuskauf_art_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuskauf_art_zu
   generated from Powerdesigner on Freitag, 21. Januar 2022 10:40:06
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COS_BONUSKAUF_ART_ZU (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   bonuskauf_id                        VARCHAR(20)     NOT NULL COMMENT 'Eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr',
   kl_art_id                           INTEGER    NOT NULL COMMENT 'Artikel für die der Coupon gültig ist',
   gratis_artikel_fg                   INTEGER    COMMENT 'BonusBuy Artikel den es umsonst gibt',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Customer Coupon Assignments- Redemption Status';