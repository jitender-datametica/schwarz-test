--==============================================================
-- Table: cos_bonuskauf_art_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cos_bonuskauf_art_zu
   generated from Powerdesigner on Freitag, 21. Januar 2022 10:40:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cos_bonuskauf_art_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
bonuskauf_id STRING(20) NOT NULL OPTIONS(description='Eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr'),
kl_art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel für die der Coupon gültig ist'),
gratis_artikel_fg BIGNUMERIC(38,0) OPTIONS(description='BonusBuy Artikel den es umsonst gibt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Customer Coupon Assignments- Redemption Status');