CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ART_ZEK_ZU_2
(
  art_id
, mandant_id
, zek_id
)
AS
SELECT
-- AP0239494/SPEC0286865 Ersetzen der Logik durch DDL mv_art_2, um FE nicht anzutasten / ssch1303 13.01.2025
-- 
   DISTINCT art_id
   ,mandant_id
   ,zek_id
   FROM DBP_VIEW.V_ART_2
   WHERE dat_bis = '9999-12-31';