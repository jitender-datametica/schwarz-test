--==============================================================
-- Table: art_pm_vw_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_pm_vw_zu_per
   generated from Powerdesigner on Mittwoch, 10. August 2022 17:28:26
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_PM_VW_ZU_PER (
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   pm_id                               INTEGER    NOT NULL COMMENT 'Preismodul, Wert von 1 bis 10',
   vw_id                               INTEGER    NOT NULL COMMENT 'ID des Vertriebsweges',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   preistyp_id                         INTEGER    NOT NULL COMMENT 'ID des Preistyps',
   dat_bis                             DATE            NOT NULL COMMENT 'Ende des Gueltigkeitszeitraums',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   dat_von                             DATE            COMMENT 'Beginn des Gueltigkeitszeitraums',
   vk_brutto                           NUMBER(29,3)     COMMENT 'Verkaufspreis Brutto des Artikels im jeweiligen Markt je Preiskategorie',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_PM_VW_ZU_PER PRIMARY KEY (art_id, pm_id, vw_id, mandant_id, preistyp_id, dat_bis) NOT ENFORCED
)  COMMENT = 'TP2 AIS - Zuordnung der Artikel zu Preismodul, Vertriebsweg und Preistyp - MULTISET
             Enthaelt Informationen, wie Verkaufspreise je Preiskategorie zum Artikel und Vertriebsweg zugeordnet sind.';
