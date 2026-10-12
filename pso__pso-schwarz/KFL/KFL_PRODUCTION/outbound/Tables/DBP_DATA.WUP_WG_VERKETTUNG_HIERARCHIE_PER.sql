--==============================================================
-- Table: wup_wg_verkett_hierarchie_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_wg_verkett_hierarchie_per
   generated from Powerdesigner on Dienstag, 28. September 2021 15:17:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_wg_verkettung_hierarchie_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wg_verkett_hier_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='LVS:Warengruppenverkettungshierarchie'),
palettenlaenge NUMERIC(13,3) OPTIONS(description='LVS: Palettenlänge'),
palettenbreite NUMERIC(13,3) OPTIONS(description='LVS: Palettenbreite'),
palettenhoehe NUMERIC(13,3) OPTIONS(description='LVS: Palettenhöhe'),
palettengroesse_einh_id STRING(3) OPTIONS(description='Einheit für Palettenlänge/breite/höhe'),
palettenvolumen NUMERIC(13,3) OPTIONS(description='LVS: Palettenvolumen'),
palettenvolumen_einh_id STRING(3) OPTIONS(description='LVS: Einheit Palettenvolumen'),
volumenabw_max NUMERIC(5,2) OPTIONS(description='LVS: Max. Volumenabweichung in Prozent'),
volumen_max NUMERIC(13,3) OPTIONS(description='LVS: Maximales Palettenvolumen'),
akl_komm_fg BIGNUMERIC(38,0) OPTIONS(description='LVS: Kennzeichen  für Kommissionierung im AKL'),
klapp_pal_fg BIGNUMERIC(38,0) OPTIONS(description='Klapp-Paletten Kennzeichen'),
volumengrenze_kkp NUMERIC(13,3) OPTIONS(description='Volumengrenze für 2 KKP'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode. Format JJJJ-MM-TT'),
dat_bis DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='\'LVS: Paletten/Kollivolumen je Warengruppenverkettung\' : SAP ZLVE_PAL_WGHIER  ');