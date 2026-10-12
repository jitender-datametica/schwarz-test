--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE ${DWH_COMMON_DBX_LOAD}.zekp ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--matnr          CHAR( 7) CHARACTER SET LATIN CASESPECIFIC,  -- Artikelnummer
--lifnr          CHAR( 7) CHARACTER SET LATIN CASESPECIFIC,  -- Lieferant
--werks          CHAR( 4) CHARACTER SET LATIN CASESPECIFIC,  -- Wup
--datab          CHAR( 8) CHARACTER SET LATIN CASESPECIFIC,  -- Datum ab
--abrut          VARCHAR(20),                                -- EK Brutto
--abrna          VARCHAR(20),                                -- Artikelrabatte Brutto abz. NRFB abz. Art. Rabatte
--abonba         VARCHAR(20),                                -- Bonusbasis
--aknet          VARCHAR(20),                                -- AK Netto Preis
--aknb           VARCHAR(20),                                -- GLD Effektivpreis(EKN + BNK)
--aknbs          VARCHAR(20),                                -- EKN + BNK + Sachkosten
--aknne          VARCHAR(20),                                -- AK Netto Netto
--ekkba          VARCHAR(20),                                -- Kalkulationsbasis
--mepre          VARCHAR(20),                                -- Markt Einstandspreis
--lsein          VARCHAR(20),                                -- Kaufland Einstandspreis
--lokau          CHAR(12) CHARACTER SET LATIN CASESPECIFIC,  -- Logistikkostenaufschlag
--bnk            VARCHAR(20),                                -- Summe BNK
--zollba         CHAR(12) CHARACTER SET LATIN CASESPECIFIC,  -- Zollwert
--konwa          CHAR( 3) CHARACTER SET LATIN CASESPECIFIC,  -- Waehrung
--kompmeng       CHAR(12) CHARACTER SET LATIN CASESPECIFIC   -- Komponentenmenge
--)
--PRIMARY INDEX (matnr, lifnr, werks )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.zekp  (
matnr          CHAR( 7) COLLATE 'de-cs',  -- Artikelnummer
lifnr          CHAR( 7) COLLATE 'de-cs',  -- Lieferant
werks          CHAR( 4) COLLATE 'de-cs',  -- Wup
datab          CHAR( 8) COLLATE 'de-cs',  -- Datum ab
abrut          VARCHAR(20),                                -- EK Brutto
abrna          VARCHAR(20),                                -- Artikelrabatte Brutto abz. NRFB abz. Art. Rabatte
abonba         VARCHAR(20),                                -- Bonusbasis
aknet          VARCHAR(20),                                -- AK Netto Preis
aknb           VARCHAR(20),                                -- GLD Effektivpreis(EKN + BNK)
aknbs          VARCHAR(20),                                -- EKN + BNK + Sachkosten
aknne          VARCHAR(20),                                -- AK Netto Netto
ekkba          VARCHAR(20),                                -- Kalkulationsbasis
mepre          VARCHAR(20),                                -- Markt Einstandspreis
lsein          VARCHAR(20),                                -- Kaufland Einstandspreis
lokau          CHAR(12) COLLATE 'de-cs',  -- Logistikkostenaufschlag
bnk            VARCHAR(20),                                -- Summe BNK
zollba         CHAR(12) COLLATE 'de-cs',  -- Zollwert
konwa          CHAR( 3) COLLATE 'de-cs',  -- Waehrung
kompmeng       CHAR(12) COLLATE 'de-cs',   -- Komponentenmenge
td_insert     TIMESTAMP_LTZ(9)
)
;

