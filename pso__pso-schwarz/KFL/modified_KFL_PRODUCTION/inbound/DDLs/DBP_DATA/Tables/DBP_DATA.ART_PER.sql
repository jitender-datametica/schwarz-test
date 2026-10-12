--==============================================================
-- Table: art_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_per
   generated from Powerdesigner on Mittwoch, 27. September 2023 15:01:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_PER (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   dat_von                             DATE             NOT NULL COMMENT 'Datum, von dem an der Zustand gilt. Initial wird das dat_von aus der Tabelle art eingetragen',
   dat_bis                             DATE            DEFAULT  CAST('9999-12-31' AS DATE) NOT NULL COMMENT 'Datum, bis zu dem der Zustand gueltig war/ist. Bei aktuellen Eintraegen der 31.12.9999',
   mutter_wb_id                        INTEGER     COMMENT 'Bei einer Serie von Artikeln mit gleicher Werbung ist hier die Artikel_ID des fuehrenden Artikels (auch: Mutterartikel) hinterlegt',
   posten_id                           VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Eindeutige Kennzeichnung des Postenartikels, z.Bsp. PN',
   ipn_id                              INTEGER     COMMENT 'Internationale Produktnummer zum Artikel (MAW1.ZZEK_IPN)',
   mwst_id                             INTEGER     COMMENT 'Mehrwertsteuer-Kennzeichen historisiert',
   oug_id                              INTEGER     COMMENT 'Kennzeichen Obst und Gemuese',
   iwt_id                              VARCHAR(1)       DEFAULT '' COMMENT 'IWT Kennzeichen. IDs that show if a product is ordered by KFL in one country for its own use (''''/0) or to be exported to KFL in other company (E) or it is imported from KFL from another country (I)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_PER PRIMARY KEY (art_id, mandant_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Einzelne Attribute der Tabelle art werden im DWH historisiert';
