--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--CREATE MULTISET TABLE ${DWH_COMMON_DBX_LOAD}.zekp ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--matnr          STRING( 7) CHARACTER SET LATIN CASESPECIFIC,  -- Artikelnummer
--lifnr          STRING( 7) CHARACTER SET LATIN CASESPECIFIC,  -- Lieferant
--werks          STRING( 4) CHARACTER SET LATIN CASESPECIFIC,  -- Wup
--datab          STRING( 8) CHARACTER SET LATIN CASESPECIFIC,  -- Datum ab
--abrut          STRING(20),                                -- EK Brutto
--abrna          STRING(20),                                -- Artikelrabatte Brutto abz. NRFB abz. Art. Rabatte
--abonba         STRING(20),                                -- Bonusbasis
--aknet          STRING(20),                                -- AK Netto Preis
--aknb           STRING(20),                                -- GLD Effektivpreis(EKN + BNK)
--aknbs          STRING(20),                                -- EKN + BNK + Sachkosten
--aknne          STRING(20),                                -- AK Netto Netto
--ekkba          STRING(20),                                -- Kalkulationsbasis
--mepre          STRING(20),                                -- Markt Einstandspreis
--lsein          STRING(20),                                -- Kaufland Einstandspreis
--lokau          STRING(12) CHARACTER SET LATIN CASESPECIFIC,  -- Logistikkostenaufschlag
--bnk            STRING(20),                                -- Summe BNK
--zollba         STRING(12) CHARACTER SET LATIN CASESPECIFIC,  -- Zollwert
--konwa          STRING( 3) CHARACTER SET LATIN CASESPECIFIC,  -- Waehrung
--kompmeng       STRING(12) CHARACTER SET LATIN CASESPECIFIC   -- Komponentenmenge
--)
--PRIMARY INDEX (matnr, lifnr, werks )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


-- Artikelrabatte Brutto abz. NRFB abz. Art. Rabatte
-- AK Netto Preis
-- EK Brutto
-- Komponentenmenge

-- Kalkulationsbasis
-- Artikelnummer
-- Waehrung
-- AK Netto Netto
-- Bonusbasis
-- Kaufland Einstandspreis

-- Logistikkostenaufschlag
-- GLD Effektivpreis(EKN + BNK)
-- EKN + BNK + Sachkosten
-- Summe BNK

-- Markt Einstandspreis
-- Zollwert
-- Lieferant
-- Wup
-- Datum ab
CREATE TABLE IF NOT EXISTS
dbp_etl.zekp (
    matnr STRING(7),
    lifnr STRING(7),
    werks STRING(4),
    datab STRING(8),
    abrut STRING(20),
    abrna STRING(20),
    abonba STRING(20),
    aknet STRING(20),
    aknb STRING(20),
    aknbs STRING(20),
    aknne STRING(20),
    ekkba STRING(20),
    mepre STRING(20),
    lsein STRING(20),
    lokau STRING(12),
    bnk STRING(20),
    zollba STRING(12),
    konwa STRING(3),
    kompmeng STRING(12),
    td_insert TIMESTAMP
);
