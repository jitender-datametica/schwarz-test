--==============================================================
-- Table: baustein_art_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: baustein_art_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BAUSTEIN_ART_ZU_PER_1 (
   baustein_id                         NUMBER(18,0)     NOT NULL COMMENT 'ID eines Sortimentsbausteins',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT
            ',
   stueckliste_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID einer Stückliste, in der der Einzelartikel zusammen mit mehreren anderen Artikel_1 zugeordnet werden kann. Die Stammdaten der Stücklisten befinden sich derzeit noch nicht im DWH',
   dat_von                             DATE             COMMENT 'Beginn der Gültigkeitsperiode
            ',
   akz_id                              VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Artikelkennzeichen in der Form
            ''A'' = Artikel_1 über sich selbst gelistet
            ''D'' = Artikel_1 über Display (Stückliste Display) gelistet
            ''K'' = Artikel_1 als Komponente über Display gelistet',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BAUSTEIN_ART_ZU_PER PRIMARY KEY (baustein_id, mandant_id, art_id, dat_bis, stueckliste_id) NOT ENFORCED
)  COMMENT = 'TP2/7 AIS - Zuordnung Baustein zu Artikel_1 - MULTISET - SAP RET Tabelle WSOP_1';

