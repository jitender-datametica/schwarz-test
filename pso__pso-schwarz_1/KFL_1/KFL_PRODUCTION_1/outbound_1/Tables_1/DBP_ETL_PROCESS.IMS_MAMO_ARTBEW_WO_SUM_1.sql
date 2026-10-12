CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ims_mamo_artbew_wo_sum_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelnummer im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetriebs ID, bei Märkten immer = 0'),
bewart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
kjwo_kl BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kaufland - Kalenderjahreswoche. Beginnt am 01.01. eines Jahres und endet am 31.12. unabhängig vom Wochentag. Die erste und die letzte Kalenderjahreswoche enthält so in der Regel weniger als sieben Tage. Format JJJJWW'),
menge NUMERIC(18,3) NOT NULL
OPTIONS(description='Menge der Artikelbewegung (kann in Stück oder bei Gewichtsartikeln in KG sein)'),
umsatz_netto NUMERIC(18,4) NOT NULL OPTIONS(description='Umsatz vermindert um den Mehrwertsteuerbetrag'),
ek_mep NUMERIC(18,4) NOT NULL OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='WWC - Redundanz zu artbew_wo_sum_1 aufgrund Performance');