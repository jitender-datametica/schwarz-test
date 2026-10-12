CREATE OR REPLACE TABLE kfl_production_dbp_data.l_aktion_typ (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
aktion_typ_id STRING(4) NOT NULL OPTIONS(description='ID des Typs die Art der Aktion.'),
aktion_typ_bez STRING(200) OPTIONS(description='Bezeichnung des Typs die Art der Aktion.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (aktion_typ_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für den Typ der Aktion. KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = Promotion die bei einem externen Partner erworben wurde (bspw.Partner Coupon, SMP Coupon, Gutschein von Partner); KPB = Promotion erhalbar über Payback Card, nur im Polen gültig,');