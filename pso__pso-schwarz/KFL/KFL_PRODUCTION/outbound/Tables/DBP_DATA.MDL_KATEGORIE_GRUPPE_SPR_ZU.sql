CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_kategorie_gruppe_spr_zu (
kategorie_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierung derselben Kategorien unter einer ID, wird zur Anzeige der gedrehten Hierarchie im VIS Cockpit genutzt (aus / identisch zu mdl_kategorie_gruppe_zu) - manuell gepflegt'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
kategorie_gruppe_bez STRING(80)
OPTIONS(description='Kategorie DESC aus Medallia übertragen auf DWH-generierte kategorie_gruppe_id - manuell gepflegt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='VIS - Medallia - Sprachtabelle zur Gruppierung der Kategorien zur Anzeige der gedrehten Hierarchhie im VIS Cockpit - manuell gepflegt');