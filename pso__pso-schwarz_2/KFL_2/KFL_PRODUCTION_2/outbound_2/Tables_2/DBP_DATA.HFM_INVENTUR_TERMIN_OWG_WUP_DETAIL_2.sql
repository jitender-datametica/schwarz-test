--==============================================================
-- Table: hfm_inventur_termin_owg_wup_detail_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hfm_inventur_termin_owg_wup_detail_2
   generated from Powerdesigner on Donnerstag, 21. Oktober 2021 15:54:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hfm_inventur_termin_owg_wup_detail_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Land_2'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Markt'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetrieb'),
dat_plan_zaehlung DATE NOT NULL OPTIONS(description='Zaehldatum Inventurzeitraum bis'),
inventurart_int_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Inventurart, z.Bsp.: 7 = Frische Inventur_2'),
owg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='OWG'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelhierarchier'),
dat_vorletzte_zaehlung DATE OPTIONS(description='Letztes Zaehldatum Inventurzeitraum von'),
wrg_id STRING(3) OPTIONS(description='Waehrung'),
anfangsbestand NUMERIC(18,4) OPTIONS(description='Anfangsbestand'),
warenzugang NUMERIC(18,4) OPTIONS(description='Warenzugang'),
warenzugang_dzl NUMERIC(18,4) OPTIONS(description='Warenzugang DZL'),
warenzugang_dzl_korr NUMERIC(18,4) OPTIONS(description='Warenzugang DZL korrigiert'),
warenzugang_zl NUMERIC(18,4) OPTIONS(description='Warenzugang ZL'),
warenzugang_zl_korr NUMERIC(18,4) OPTIONS(description='Warenzugang ZL korrigiert'),
warenzugang_retoure NUMERIC(18,4) OPTIONS(description='Warenzugang Retoure'),
abschriften_ohne_diebstahl NUMERIC(18,4) OPTIONS(description='Abschriften_2 ohne Diebstahl'),
werbegutschriften NUMERIC(18,4) OPTIONS(description='Werbegutschriften'),
abschriften_operativ NUMERIC(18,4) OPTIONS(description='Abschriften_2 operativ'),
abschriften_ta_vt_sonstige NUMERIC(18,4) OPTIONS(description='Abschriften_2 TA VT Sonstige'),
endbestand_rechnerisch NUMERIC(18,4) OPTIONS(description='Rechnerischer Endbestand'),
endbestand_gezaehlt NUMERIC(18,4) OPTIONS(description='Gezaehlter Endbestand'),
umsatz_soll NUMERIC(18,4) OPTIONS(description='Soll Umsatz'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Detaildaten zu Inventurergebnissen. Daten kommen über Upload');