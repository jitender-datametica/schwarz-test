--==============================================================
-- Table: wg_verkettung_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_verkettung_per
   generated from Powerdesigner on Dienstag, 28. September 2021 14:44:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_verkettung_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wg_verkett_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warengruppenverkettungskennzeichen'),
palettenlaenge NUMERIC(13,3) OPTIONS(description='LVS: Palettenlänge'),
palettenbreite NUMERIC(13,3) OPTIONS(description='LVS: Palettenbreite'),
palettenhoehe NUMERIC(13,3) OPTIONS(description='LVS: Palettenhöhe'),
palettengroesse_einh_id STRING(3) OPTIONS(description='Einheit für Palettenlänge/breite/höhe'),
palettenvolumen NUMERIC(13,3) OPTIONS(description='LVS: Palettenvolumen'),
palettenvolumen_einh_id STRING(3) OPTIONS(description='LVS: Einheit Palettenvolumen'),
volumenabw_max NUMERIC(5,2) OPTIONS(description='LVS: Max. Volumenabweichung in Prozent'),
volumen_max NUMERIC(13,3) OPTIONS(description='LVS: Maximales Palettenvolumen'),
volumenabw_min NUMERIC(5,2) OPTIONS(description='LVS: Min. Volumenabweichung in Prozent'),
pal_min_volumen NUMERIC(13,3) OPTIONS(description='LVS: Palettenmindestvolumen'),
kollilaenge NUMERIC(13,3) OPTIONS(description='LVS: Kollilänge'),
kollibreite NUMERIC(13,3) OPTIONS(description='LVS: Kollibreite'),
kollihoehe NUMERIC(13,3) OPTIONS(description='LVS: Kollihöhe'),
kolligroesse_einh_id STRING(3) OPTIONS(description='Einheit für Kollilänge/breite/höhe'),
kollivolumen NUMERIC(13,3) OPTIONS(description='LVS: Kollivolumen'),
kollivolumen_einh_id STRING(3) OPTIONS(description='LVS: Einheit Kollivolumen'),
akl_komm_fg BIGNUMERIC(38,0) OPTIONS(description='LVS: Kennzeichen  für Kommissionierung im AKL'),
aka_komm_fg BIGNUMERIC(38,0) OPTIONS(description='Auto: KZ für Kommissionierung in autom. O&G Kommianlage'),
max_volumen_aufpackpal NUMERIC(13,3) OPTIONS(description='LVS: Max. Volumen der Aufpackpalette (Mixed on GP)'),
max_anz_pal BIGNUMERIC(38,0) OPTIONS(description='Maximale Anzahl Paletten in einer Auslieferung'),
max_volumen_palytp_a NUMERIC(13,3) OPTIONS(description='Max. Volumen GPonGP'),
max_volumen_paltyp_b NUMERIC(13,3) OPTIONS(description='Max. Volumen BigboxonGP'),
klapp_pal_fg BIGNUMERIC(38,0) OPTIONS(description='Klapp-Paletten Kennzeichen'),
volumengrenze_kkp NUMERIC(13,3) OPTIONS(description='Volumengrenze für 2 KKP'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode. Format JJJJ-MM-TT '),
dat_bis DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Paletten/Kollivolumen je Warengruppenverkettung');