CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_lief_belos_vorgang_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lief_beleg_id NUMERIC(18,3) NOT NULL OPTIONS(description='DNetto-Ladungsgvolumen der HU'),
kj_lief_beleg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr Lieferbeleg'),
dat_lief_soll DATE
OPTIONS(description='Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen. Das Feld wird aus der Kopftabelle "vererbt", um einen PPI darüber bilden zu können (Performance'),
belos_vorgang_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='BELOS Vorgang ID'),
transportation_unit_id BIGNUMERIC(38,0) OPTIONS(description='Transporteinheit (intern)'),
dat_leistung DATE OPTIONS(description='Leistungsdatum (BELOS)'),
versandstelle_id STRING(4)
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_2 Gruppe_2 von Laderampen) oder um eine_2 logische Gruppierung (z.B. eine_2 Gruppe_2 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
lief_prefix STRING(1) DEFAULT ' ' OPTIONS(description='Präfix [aktuell nur "C" oder leer] (new and need default value)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Warenausgangs-Positionen auf Ebene Warengruppe');