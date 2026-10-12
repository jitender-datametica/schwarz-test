CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_PRICE_LABEL_REPAIR_ORIGIN (
   price_label_repair_origin_name           COMMENT 'Declaration if the price label damage is customer fault or producer fault.'
  ,price_label_producer_name                COMMENT 'The name of the company that manufactures price labels.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The timestamp when the row was inserted.'
  ,dwh_updated                              COMMENT 'The timestamp when the row was updated the last time.'
)
COMMENT = 'This reference table contains data about who was declared as responsable for the price label damage.
Sources: manually filled (ESL)'
AS SELECT
   price_label_repair_origin_name
  ,price_label_producer_name
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_PRICE_LABEL_REPAIR_ORIGIN
;