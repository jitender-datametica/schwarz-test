CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_SELBSTABHOLUNG_1
(
selbstabhol_fg,
mandant_id
)
AS
   SELECT 1 as x, 1 as mandant_id
   union all
   select 0 as x, 1 as mandant_id;