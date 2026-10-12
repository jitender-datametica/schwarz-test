CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kampagne_kampagne_kunde_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH.'), kampagne_id
OPTIONS(description='Eindeutige Kennung der Kampagnendefinition, der der Kunde zugeordnet ist. Ein Kunde kann mehreren Kampagnen und eine_1 Kampagne_1 mehreren Kunden zugeordnet sein (Many-to-Many-Beziehung).'),
kampagne_kunde_id
OPTIONS(description='Eindeutige Kennung des Kunden, welcher der Empfänger der von einer Kampagne_1 gesendeten Nachrichten ist.'))
OPTIONS(DESCRIPTION = `ZUORDNUNGTABELLE VON KUNDEN ZU BESTIMMTEN KAMPAGNENDEFINITIONEN. SIE DIENT DAZU, DIE ZIELGRUPPE EINER KAMPAGNE_1 ZU DEFINIEREN UND DIE INTERAKTIONEN EINZELNER KUNDEN MIT DER JOURNEY ZU VERFOLGEN.`)
AS SELECT mandant_id,
 kampagne_id,
 kampagne_kunde_id
FROM kfl_production_dbp_data.kampagne_kampagne_kunde_zu_1;