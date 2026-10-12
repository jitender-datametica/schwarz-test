--==============================================================
-- Table: wg_verkettung_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_verkettung_per_2
   generated from Powerdesigner on Dienstag, 28. September 2021 14:44:57
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WG_VERKETTUNG_PER_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wg_verkett_id                       INTEGER    NOT NULL COMMENT 'Warengruppenverkettungskennzeichen',
   palettenlaenge                      NUMBER(29,3)    COMMENT 'LVS: Palettenlänge',
   palettenbreite                      NUMBER(29,3)    COMMENT 'LVS: Palettenbreite',
   palettenhoehe                       NUMBER(29,3)    COMMENT 'LVS: Palettenhöhe',
   palettengroesse_einh_id             VARCHAR(3)      COMMENT 'Einheit für Palettenlänge/breite/höhe',
   palettenvolumen                     NUMBER(29,3)    COMMENT 'LVS: Palettenvolumen',
   palettenvolumen_einh_id             VARCHAR(3)      COMMENT 'LVS: Einheit Palettenvolumen',
   volumenabw_max                      NUMBER(29,2)     COMMENT 'LVS: Max. Volumenabweichung in Prozent',
   volumen_max                         NUMBER(29,3)    COMMENT 'LVS: Maximales Palettenvolumen',
   volumenabw_min                      NUMBER(29,2)     COMMENT 'LVS: Min. Volumenabweichung in Prozent',
   pal_min_volumen                     NUMBER(29,3)    COMMENT 'LVS: Palettenmindestvolumen',
   kollilaenge                         NUMBER(29,3)    COMMENT 'LVS: Kollilänge',
   kollibreite                         NUMBER(29,3)    COMMENT 'LVS: Kollibreite',
   kollihoehe                          NUMBER(29,3)    COMMENT 'LVS: Kollihöhe',
   kolligroesse_einh_id                VARCHAR(3)      COMMENT 'Einheit für Kollilänge/breite/höhe',
   kollivolumen                        NUMBER(29,3)    COMMENT 'LVS: Kollivolumen',
   kollivolumen_einh_id                VARCHAR(3)      COMMENT 'LVS: Einheit Kollivolumen',
   akl_komm_fg                         INTEGER    COMMENT 'LVS: Kennzeichen  für Kommissionierung im AKL',
   aka_komm_fg                         INTEGER    COMMENT 'Auto: KZ für Kommissionierung in autom. O&G Kommianlage',
   max_volumen_aufpackpal              NUMBER(29,3)    COMMENT 'LVS: Max. Volumen der Aufpackpalette (Mixed on GP_2)',
   max_anz_pal                         INTEGER    COMMENT 'Maximale Anzahl Paletten in einer Auslieferung',
   max_volumen_palytp_a                NUMBER(29,3)    COMMENT 'Max. Volumen GPonGP',
   max_volumen_paltyp_b                NUMBER(29,3)    COMMENT 'Max. Volumen BigboxonGP',
   klapp_pal_fg                        INTEGER    COMMENT 'Klapp-Paletten Kennzeichen',
   volumengrenze_kkp                   NUMBER(29,3)    COMMENT 'Volumengrenze für 2 KKP',
   dat_von                             DATE            NOT NULL COMMENT 'Beginn der Gültigkeitsperiode. Format JJJJ-MM_2-TT ',
   dat_bis                             DATE            COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Paletten/Kollivolumen je Warengruppenverkettung';
