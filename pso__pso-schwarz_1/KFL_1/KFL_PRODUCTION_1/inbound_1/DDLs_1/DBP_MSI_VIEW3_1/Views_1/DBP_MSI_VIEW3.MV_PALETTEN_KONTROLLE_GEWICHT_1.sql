CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_PALETTEN_KONTROLLE_GEWICHT_1
-- 23.01.2018 HMue, AP0022531, SPEC0031624

(
mandant_id,
lagernummer_id,
wup_id,
nb_id,
handling_unit_id,
handling_unit_id_traeger,
status_id,
gewicht_ist,
gewicht_soll,
gewicht_abweichung
)
AS
   SELECT
  v01.mandant_id,
   v01.lagernummer_id,
   v01.wup_id,
   v01.nb_id,
   v01.handling_unit_id,
   v01.handling_unit_id_traeger,
   v01.status_id,
   v01.gewicht_ist,
   v01.gewicht_soll,
   CASE WHEN CAST(v01.gewicht_ist AS DECIMAL(18,5)) > 0.00000 THEN ( ABS(CAST(v01.gewicht_ist AS DECIMAL(18,5))- CAST(v01.gewicht_soll AS DECIMAL(18,5))) / CAST(v01.gewicht_soll AS DECIMAL(18,5)))ELSE NULL END AS gewicht_abweichung

   FROM dbp_view.v_paletten_kontrolle_gewicht_1 v01;