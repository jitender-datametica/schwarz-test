CREATE OR REPLACE VIEW DBP_VIEW.V_L_CRM_GENDER_1 (
   gender_id                                COMMENT 'ID für das Geschlecht des Kunden'
  ,gender_bez                               COMMENT 'Bezeichnugn für das Geschlecht des Kunden'
)
COMMENT = 'CRM - Lookup Tabelle für SalutationCode aus Cosmos DB.'
 AS 
    SELECT 
        gender_id,
        gender_bez

FROM DBP_DATA.L_CRM_GENDER_1 ;