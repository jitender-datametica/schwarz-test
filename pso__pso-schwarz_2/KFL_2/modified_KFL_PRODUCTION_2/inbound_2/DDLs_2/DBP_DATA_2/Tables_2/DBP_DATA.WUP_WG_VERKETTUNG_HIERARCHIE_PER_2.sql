--==============================================================
-- Table: wup_wg_verkett_hierarchie_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_wg_verkett_hierarchie_per
   generated from Powerdesigner on Dienstag, 28. September 2021 15:17:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_WG_VERKETTUNG_HIERARCHIE_PER_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wg_verkett_hier_id                  INTEGER    NOT NULL COMMENT 'LVS:Warengruppenverkettungshierarchie',
   palettenlaenge                      NUMBER(29,3)    COMMENT 'LVS: Palettenlänge',
   palettenbreite                      NUMBER(29,3)    COMMENT 'LVS: Palettenbreite',
   palettenhoehe                       NUMBER(29,3)    COMMENT 'LVS: Palettenhöhe',
   palettengroesse_einh_id             VARCHAR(3)      COMMENT 'Einheit für Palettenlänge/breite/höhe',
   palettenvolumen                     NUMBER(29,3)    COMMENT 'LVS: Palettenvolumen',
   palettenvolumen_einh_id             VARCHAR(3)      COMMENT 'LVS: Einheit Palettenvolumen',
   volumenabw_max                      NUMBER(29,2)     COMMENT 'LVS: Max. Volumenabweichung in Prozent',
   volumen_max                         NUMBER(29,3)    COMMENT 'LVS: Maximales Palettenvolumen',
   akl_komm_fg                         INTEGER    COMMENT 'LVS: Kennzeichen  für Kommissionierung im AKL',
   klapp_pal_fg                        INTEGER    COMMENT 'Klapp-Paletten Kennzeichen',
   volumengrenze_kkp                   NUMBER(29,3)    COMMENT 'Volumengrenze für 2 KKP',
   dat_von                             DATE            NOT NULL COMMENT 'Beginn der Gültigkeitsperiode. Format JJJJ-MM_2-TT',
   dat_bis                             DATE            COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = '''LVS: Paletten/Kollivolumen je Warengruppenverkettung'' : SAP ZLVE_PAL_WGHIER  ';
