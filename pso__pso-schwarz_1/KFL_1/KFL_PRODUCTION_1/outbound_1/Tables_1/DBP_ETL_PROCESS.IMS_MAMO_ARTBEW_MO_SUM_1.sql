CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ims_mamo_artbew_mo_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
menge NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)'),
umsatz_netto NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
ek_mep NUMERIC(18,4) NOT NULL OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='WWC - Redundanz zu artbew_mo_sum_1 aufgrund Performance');