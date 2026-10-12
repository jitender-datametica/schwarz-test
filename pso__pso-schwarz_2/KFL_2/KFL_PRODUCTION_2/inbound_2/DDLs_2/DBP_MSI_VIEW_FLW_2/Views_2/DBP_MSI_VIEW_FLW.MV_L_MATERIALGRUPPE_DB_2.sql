CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_MATERIALGRUPPE_DB_2
-- AL 22.11.2011
-- Lookup Materialgruppierung fuer DB Rechnung basierend auf Beeschaffungskennzeichen und der Produkthierarchie

(
materialgruppe_db_id,
materialgruppe_db_bez
)
AS

  SELECT   CASE dat
   WHEN current_date -4  THEN 1
   WHEN current_date -3 THEN 2
   WHEN current_date -2 THEN 3
   WHEN current_date -1 THEN 4
   ELSE 5
   END,

   CASE dat
   WHEN current_date -4  THEN 'Fleisch'
   WHEN current_date -3 THEN 'Wurst'
   WHEN current_date -2 THEN 'HAWA'
   WHEN current_date -1 THEN 'Produktion'
   ELSE 'nicht zugeordnet'
   END

   FROM dbp_view.v_tag_2
   WHERE dat BETWEEN current_date -4 AND current_date;