--==============================================================
-- Table: art_kompensation_gruppe_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_kompensation_gruppe_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_kompensation_gruppe_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
komp_gruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Kompensationsgruppe aus zcgnr'),
komp_kriterium_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kompensationskriterium aus zcgadv. wenn = 0, dann Verpackungsinhalt gleich, wenn = 1,dann unterschiedlicher Verpackungsinhalt'),
komp_faktor NUMERIC(9,2) NOT NULL
OPTIONS(description='Faktor (Gewichtung) des Artikels) aus factor. Ein Artikel_1 mit Faktor 2 wird z.Bsp. gegen zwei mit Faktor 1 aufgerechnet'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, komp_gruppe_id, komp_kriterium_fg) NOT ENFORCED
) OPTIONS(description='WWC - Zuordnungstabelle Kompensationsartikel zu Kompensationsgruppe');