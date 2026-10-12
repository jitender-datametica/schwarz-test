--==============================================================
-- Table: ods_bon_kassen_informationen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ods_bon_kassen_informationen
   generated from Powerdesigner on Donnerstag, 27. Januar 2022 14:47:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.ods_bon_kassen_informationen (
bon_id STRING(25) NOT NULL OPTIONS(description='DWH eindeutige ID. Genereirt aus Quellfelder und Hash Wert'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
bon_dat DATE NOT NULL OPTIONS(description='Das Datum an dem der Bon erstellt wurde'),
kasse_name STRING(20) NOT NULL
OPTIONS(description='Kassennamen. Z.B. DE5190POS14. Land DE, Markt 5190, Typ POS, Kassennr. 14'),
kassen_untertyp STRING(30) DEFAULT 'default' NOT NULL
OPTIONS(description='deviceSubtype (ITAB und NCR sind die beiden verschiedenen SCO Hersteller)'),
bargeld_abwicklung STRING(30) DEFAULT 'none' NOT NULL
OPTIONS(description='Cashrecycler = Glory Münz- und Scheinautomat, Cashdrawer = normale Geldschublade an den Kassen, None = weder noch '),
umsatz_brutto NUMERIC(18,4) OPTIONS(description='Umsatz brutto. In Landeswaehrung'),
bonanzahl BIGNUMERIC(38,0) OPTIONS(description='Anzahl Bons'),
waage_aktiv_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Scale Active. True oder False. Feld sagt aus, ob eine Waage aktiv (1) ist oder nicht (0)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Informationen, welche Kassen es im Markt gibt');