--==============================================================
-- Table: pmr_angebot_werbemittel_werbeflaeche_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: pmr_angebot_werbemittel_werbeflaeche_zu_1
   generated from Powerdesigner on Dienstag, 4. Juli 2023 12:58:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pmr_angebot_werbemittel_werbeflaeche_zu_1 (
angebot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='aus TableName wbs_werbeaenderungen_1 Offer/Angebot_1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1           '),
werbemittel_art_id STRING(4) NOT NULL
OPTIONS(description='Werbemittel Art_1 ID - medium through which the advertisement is shown (paper, digital)'),
werbemittel_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Werbemittel - on what item_1 the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)'),
werbeflaeche_abschnitt_name STRING(50) NOT NULL
OPTIONS(description='Gibt an, in welchem Abschnitt eines Bereichs das Angebot_1 abgebildet ist (z.B. TOPLEFT1) - Section (of leaflet page) where the advertisement is put'),
werbeflaeche_thema_id STRING(10) NOT NULL
OPTIONS(description='Gibt an, in welchem Bereich das Angebot_1 abgebildet ist (z.B. PANO01) - Code of the promotion theme (back to school, christmas)'),
werbeflaeche_thema_bez STRING(30)
OPTIONS(description='Bezeichnung für die FLAECHEN_ID (z.B. PANO01 = Schulanfang) - Name of the promotion theme'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (angebot_id, mandant_id, werbemittel_art_id, werbemittel_id, werbeflaeche_abschnitt_name,
 werbeflaeche_thema_id) NOT ENFORCED
)
OPTIONS(description='A relationship table that shows promotion offers, how they are advertised (radio, leafled, online) and part of which promotion theme they are (back-to-school, christmas ..) and in which section/area they are shown in case of leaflets');