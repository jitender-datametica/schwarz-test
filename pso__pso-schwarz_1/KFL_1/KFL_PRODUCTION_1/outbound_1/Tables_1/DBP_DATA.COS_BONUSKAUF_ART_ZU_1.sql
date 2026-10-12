--==============================================================
-- Table: cos_bonuskauf_art_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuskauf_art_zu_1
   generated from Powerdesigner on Freitag, 21. Januar 2022 10:40:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cos_bonuskauf_art_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='Eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr'),
kl_art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_1 für die der Coupon gültig ist'),
gratis_artikel_fg BIGNUMERIC(38,0) OPTIONS(description='BonusBuy Artikel_1 den es umsonst gibt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Customer Coupon Assignments- Redemption Status_1');