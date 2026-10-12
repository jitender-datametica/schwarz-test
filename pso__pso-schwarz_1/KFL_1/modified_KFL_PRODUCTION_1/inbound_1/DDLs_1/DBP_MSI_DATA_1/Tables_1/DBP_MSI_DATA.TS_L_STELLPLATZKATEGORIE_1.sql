--==============================================================
-- Table: ts_l_stellplatzkategorie_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_l_stellplatzkategorie_1
   generated from Powerdesigner on Friday, August 5, 2022 5:14:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_L_STELLPLATZKATEGORIE_1 (
   sammel_ladung_fg                    INTEGER    NOT NULL COMMENT 'Flag: Sammelladung. Die sammel_ladung_fg sagt aus, ob ein belos_vorgang_1 mehrere Stopps um Ladung aufzunehmen, beinhaltet, oder ob es eine_1 Direktfahrt ist.',
   anz_stellplatz_von                  INTEGER    NOT NULL COMMENT 'Gueltigkeit der Kategorie ab Mindestanzahl an Stellplaetzen. Es darf keine Ueberschneidung in den Kategorien geben.',
   anz_stellplatz_bis                  INTEGER    COMMENT 'Gueltigkeit der Kategorie bis Maximalanzahl an Stellplaetzen. Es darf keine Ueberschneidung in den Kategorien geben.',
   stellplatzkategorie                 VARCHAR(100)    COMMENT 'Stellplatzkategorie. Wird einem BELOS-Vorgang zugewiesen. Sagt aus, wie viele freie Stellplaetze benoetigt werden und ob es eine_1 Sammel- oder Direktfahrt ist. Stellplatzkategorien duerfen sich nicht ueberschneiden.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_L_STELLPLATZKATEGORIE PRIMARY KEY (sammel_ladung_fg, anz_stellplatz_von) NOT ENFORCED
)  COMMENT = 'LOG - Stellplatzkategorien (SCM, organisatorisch). A storing position (ein Stellplatz) is an area within a transporter where one position equals one handling unit_1 (eine_1 Palette), and one category (eine_1 Stellplatzkategorie) is a minimum number of free spots together with the accumulated load flag (eine_1 Sammelladung, sammel_ladung_fg). The sammel_ladung_fg says whether a belos_vorgang_1 includes several pickup stops to be completed or whether it is a direct tour. A BELOS-process (belos_vorgang_1) has one stellplatzkategorie assigned.';
