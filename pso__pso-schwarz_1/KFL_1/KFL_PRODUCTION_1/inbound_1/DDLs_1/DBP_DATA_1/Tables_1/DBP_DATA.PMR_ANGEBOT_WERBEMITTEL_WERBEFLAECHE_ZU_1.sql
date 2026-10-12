--==============================================================
-- Table: pmr_angebot_werbemittel_werbeflaeche_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: pmr_angebot_werbemittel_werbeflaeche_zu_1
   generated from Powerdesigner on Dienstag, 4. Juli 2023 12:58:45
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PMR_ANGEBOT_WERBEMITTEL_WERBEFLAECHE_ZU_1 (
   angebot_id                          NUMBER(38,0)     NOT NULL COMMENT 'aus TableName wbs_werbeaenderungen_1 Offer/Angebot_1',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1           ',
   werbemittel_art_id                  VARCHAR(4)       NOT NULL COMMENT 'Werbemittel Art_1 ID - medium through which the advertisement is shown (paper, digital)',
   werbemittel_id                      NUMBER(38,0)     NOT NULL COMMENT 'Werbemittel - on what item_1 the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)',
   werbeflaeche_abschnitt_name         VARCHAR(50)      NOT NULL COMMENT 'Gibt an, in welchem Abschnitt eines Bereichs das Angebot_1 abgebildet ist (z.B. TOPLEFT1) - Section (of leaflet page) where the advertisement is put',
   werbeflaeche_thema_id               VARCHAR(10)      NOT NULL COMMENT 'Gibt an, in welchem Bereich das Angebot_1 abgebildet ist (z.B. PANO01) - Code of the promotion theme (back to school, christmas)',
   werbeflaeche_thema_bez              VARCHAR(30)      COMMENT 'Bezeichnung für die FLAECHEN_ID (z.B. PANO01 = Schulanfang) - Name of the promotion theme',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PMR_ANGEBOT_WERBEMITTEL_WERBEFLAECHE_ZU PRIMARY KEY (angebot_id, mandant_id, werbemittel_art_id, werbemittel_id, werbeflaeche_abschnitt_name, werbeflaeche_thema_id) NOT ENFORCED
)  COMMENT = 'A relationship table that shows promotion offers, how they are advertised (radio, leafled, online) and part of which promotion theme they are (back-to-school, christmas ..) and in which section/area they are shown in case of leaflets';
