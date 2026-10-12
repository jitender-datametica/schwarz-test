--==============================================================
-- Table: ts_l_stellplatzkategorie_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_l_stellplatzkategorie_2
   generated from Powerdesigner on Friday, August 5, 2022 5:14:14 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_l_stellplatzkategorie_2 (
sammel_ladung_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag: Sammelladung. Die sammel_ladung_fg sagt aus, ob ein belos_vorgang_2 mehrere Stopps um Ladung aufzunehmen, beinhaltet, oder ob es eine_2 Direktfahrt ist.'),
anz_stellplatz_von BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gueltigkeit der Kategorie ab Mindestanzahl an Stellplaetzen. Es darf keine Ueberschneidung in den Kategorien geben.'),
anz_stellplatz_bis BIGNUMERIC(38,0)
OPTIONS(description='Gueltigkeit der Kategorie bis Maximalanzahl an Stellplaetzen. Es darf keine Ueberschneidung in den Kategorien geben.'),
stellplatzkategorie STRING(100)
OPTIONS(description='Stellplatzkategorie. Wird einem BELOS-Vorgang zugewiesen. Sagt aus, wie viele freie Stellplaetze benoetigt werden und ob es eine_2 Sammel- oder Direktfahrt ist. Stellplatzkategorien duerfen sich nicht ueberschneiden.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (sammel_ladung_fg, anz_stellplatz_von) NOT ENFORCED
)
OPTIONS(description='LOG - Stellplatzkategorien (SCM, organisatorisch). A storing position (ein Stellplatz) is an area within a transporter where one position equals one handling unit_2 (eine_2 Palette), and one category (eine_2 Stellplatzkategorie) is a minimum number of free spots together with the accumulated load flag (eine_2 Sammelladung, sammel_ladung_fg). The sammel_ladung_fg says whether a belos_vorgang_2 includes several pickup stops to be completed or whether it is a direct tour. A BELOS-process (belos_vorgang_2) has one stellplatzkategorie assigned.');