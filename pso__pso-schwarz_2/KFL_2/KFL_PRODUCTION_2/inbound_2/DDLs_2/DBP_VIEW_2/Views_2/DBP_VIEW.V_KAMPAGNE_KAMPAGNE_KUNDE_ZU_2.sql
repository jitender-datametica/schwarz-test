CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE_KAMPAGNE_KUNDE_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,kampagne_id                              COMMENT 'Eindeutige Kennung der Kampagnendefinition, der der Kunde zugeordnet ist. Ein Kunde kann mehreren Kampagnen und eine_2 Kampagne_2 mehreren Kunden zugeordnet sein (Many-to-Many-Beziehung).'
  ,kampagne_kunde_id                        COMMENT 'Eindeutige Kennung des Kunden, welcher der Empfänger der von einer Kampagne_2 gesendeten Nachrichten ist.'
)
COMMENT = 'Zuordnungtabelle von Kunden zu bestimmten Kampagnendefinitionen. Sie dient dazu, die Zielgruppe einer Kampagne_2 zu definieren und die Interaktionen einzelner Kunden mit der Journey zu verfolgen.'
 AS 
    SELECT 
        mandant_id,
        kampagne_id,
        kampagne_kunde_id

FROM DBP_DATA.KAMPAGNE_KAMPAGNE_KUNDE_ZU_2 ;