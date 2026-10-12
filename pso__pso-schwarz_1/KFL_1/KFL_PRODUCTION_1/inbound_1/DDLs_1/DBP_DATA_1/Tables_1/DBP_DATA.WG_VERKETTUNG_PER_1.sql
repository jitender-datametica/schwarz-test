--==============================================================
-- Table: wg_verkettung_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_verkettung_per_1
   generated from Powerdesigner on Dienstag, 28. September 2021 14:44:57
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WG_VERKETTUNG_PER_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wg_verkett_id                       NUMBER(38,0)    NOT NULL COMMENT 'Warengruppenverkettungskennzeichen',
   palettenlaenge                      NUMBER(13,3)    COMMENT 'LVS: Palettenlänge',
   palettenbreite                      NUMBER(13,3)    COMMENT 'LVS: Palettenbreite',
   palettenhoehe                       NUMBER(13,3)    COMMENT 'LVS: Palettenhöhe',
   palettengroesse_einh_id             VARCHAR(3)      COMMENT 'Einheit für Palettenlänge/breite/höhe',
   palettenvolumen                     NUMBER(13,3)    COMMENT 'LVS: Palettenvolumen',
   palettenvolumen_einh_id             VARCHAR(3)      COMMENT 'LVS: Einheit Palettenvolumen',
   volumenabw_max                      NUMBER(5,2)     COMMENT 'LVS: Max. Volumenabweichung in Prozent',
   volumen_max                         NUMBER(13,3)    COMMENT 'LVS: Maximales Palettenvolumen',
   volumenabw_min                      NUMBER(5,2)     COMMENT 'LVS: Min. Volumenabweichung in Prozent',
   pal_min_volumen                     NUMBER(13,3)    COMMENT 'LVS: Palettenmindestvolumen',
   kollilaenge                         NUMBER(13,3)    COMMENT 'LVS: Kollilänge',
   kollibreite                         NUMBER(13,3)    COMMENT 'LVS: Kollibreite',
   kollihoehe                          NUMBER(13,3)    COMMENT 'LVS: Kollihöhe',
   kolligroesse_einh_id                VARCHAR(3)      COMMENT 'Einheit für Kollilänge/breite/höhe',
   kollivolumen                        NUMBER(13,3)    COMMENT 'LVS: Kollivolumen',
   kollivolumen_einh_id                VARCHAR(3)      COMMENT 'LVS: Einheit Kollivolumen',
   akl_komm_fg                         NUMBER(38,0)    COMMENT 'LVS: Kennzeichen  für Kommissionierung im AKL',
   aka_komm_fg                         NUMBER(38,0)    COMMENT 'Auto: KZ für Kommissionierung in autom. O&G Kommianlage',
   max_volumen_aufpackpal              NUMBER(13,3)    COMMENT 'LVS: Max. Volumen der Aufpackpalette (Mixed on GP_1)',
   max_anz_pal                         NUMBER(38,0)    COMMENT 'Maximale Anzahl Paletten in einer Auslieferung',
   max_volumen_palytp_a                NUMBER(13,3)    COMMENT 'Max. Volumen GPonGP',
   max_volumen_paltyp_b                NUMBER(13,3)    COMMENT 'Max. Volumen BigboxonGP',
   klapp_pal_fg                        NUMBER(38,0)    COMMENT 'Klapp-Paletten Kennzeichen',
   volumengrenze_kkp                   NUMBER(13,3)    COMMENT 'Volumengrenze für 2 KKP',
   dat_von                             DATE            NOT NULL COMMENT 'Beginn der Gültigkeitsperiode. Format JJJJ-MM_1-TT ',
   dat_bis                             DATE            COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Paletten/Kollivolumen je Warengruppenverkettung';
