CREATE TABLE DBP_DATA.BESCH_LIEF_BELOS_VORGANG_ZU (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   lief_beleg_id                       NUMBER(18,3)    NOT NULL COMMENT 'DNetto-Ladungsgvolumen der HU',
   kj_lief_beleg                       NUMBER(38,0)    NOT NULL COMMENT 'Kalenderjahr Lieferbeleg',
   dat_lief_soll                       DATE            COMMENT 'Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschätzungen errechnen. Das Feld wird aus der Kopftabelle "vererbt", um einen PPI darüber bilden zu können (Performance',
   belos_vorgang_id                    NUMBER(38,0)    NOT NULL COMMENT 'BELOS Vorgang ID',
   transportation_unit_id              NUMBER(38,0)    COMMENT 'Transporteinheit (intern)',
   dat_leistung                        DATE            COMMENT 'Leistungsdatum (BELOS)',
   versandstelle_id                    VARCHAR(4)      COMMENT 'Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine Gruppe von Laderampen) oder um eine logische Gruppierung (z.B. eine Gruppe von Personen, die für die Versandaktivitäten zuständig ist) handeln.',
   lief_prefix                         VARCHAR(1)      DEFAULT ' ' COMMENT 'Präfix [aktuell nur "C" oder leer] (new and need default value)'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Warenausgangs-Positionen auf Ebene Warengruppe';
