--==============================================================
-- Table: crm_kartebew_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_kartebew_1
   generated from Powerdesigner on Mittwoch, 26. Februar 2025 13:53:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_kartebew_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet fur Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
kundenkarte_id STRING(255) NOT NULL
OPTIONS(description='Nummer der Kundenkarte / Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id.'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT.'),
loyalty_berechtigt_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ab 01.03.2025 wird das Flag aus ods_bon_kopf_1 berechnet. (Logik für alte Daten folgt)'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
umsatz_netto_sa BIGNUMERIC(38,4) OPTIONS(description='SA Umsatz vermindert um den Mehrwertsteuerbetrag.'),
umsatz_netto_af BIGNUMERIC(38,4) OPTIONS(description='AF Umsatz vermindert um den Mehrwertsteuerbetrag.'),
umsatz_brutto_sa BIGNUMERIC(38,4) OPTIONS(description='SA Umsatz.'),
umsatz_brutto_af BIGNUMERIC(38,4) OPTIONS(description='AF Umsatz.'),
anz_bons BIGNUMERIC(38,0) OPTIONS(description='Bons, die eine_1 Kundenkarte generiert.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, kundenkarte_id, dat, loyalty_berechtigt_fg) NOT ENFORCED
)
OPTIONS(description='EK-KUN - MSDynamicsCRM - Aggregat auf Bondaten für CRM. Granularität Tag_1 - Markt und loyalty_berechtigt_fg. Inhalt: Kundenkarte mit der Anzahl ihrer generierten Bons und ihres Umsatzes (brutto u. netto).');