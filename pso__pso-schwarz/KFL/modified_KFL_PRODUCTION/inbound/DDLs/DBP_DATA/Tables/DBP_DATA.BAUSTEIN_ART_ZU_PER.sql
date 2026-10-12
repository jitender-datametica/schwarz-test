--==============================================================
-- Table: baustein_art_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: baustein_art_zu_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BAUSTEIN_ART_ZU_PER (
   baustein_id                         INTEGER     NOT NULL COMMENT 'ID eines Sortimentsbausteins',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM-TT
            ',
   stueckliste_id                      INTEGER     NOT NULL COMMENT 'ID einer Stückliste, in der der Einzelartikel zusammen mit mehreren anderen Artikel zugeordnet werden kann. Die Stammdaten der Stücklisten befinden sich derzeit noch nicht im DWH',
   dat_von                             DATE             COMMENT 'Beginn der Gültigkeitsperiode
            ',
   akz_id                              VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Artikelkennzeichen in der Form
            ''A'' = Artikel über sich selbst gelistet
            ''D'' = Artikel über Display (Stückliste Display) gelistet
            ''K'' = Artikel als Komponente über Display gelistet',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BAUSTEIN_ART_ZU_PER PRIMARY KEY (baustein_id, mandant_id, art_id, dat_bis, stueckliste_id) NOT ENFORCED
)  COMMENT = 'TP2/7 AIS - Zuordnung Baustein zu Artikel - MULTISET - SAP RET Tabelle WSOP';

