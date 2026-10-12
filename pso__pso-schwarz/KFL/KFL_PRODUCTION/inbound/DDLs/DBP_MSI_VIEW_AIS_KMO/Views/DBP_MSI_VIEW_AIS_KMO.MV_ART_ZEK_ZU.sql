CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ART_ZEK_ZU
-- Filter auf mandant_id > 1 wegen Erweiterung Tabelle bzgl. Security AIS_INT / 08.02.2019 sschuecke
(
  art_id
, mandant_id
, zek_id
)
AS
   SELECT
   -- AP0239494/SPEC0286865 Ersetzen der Logik durch DDL mv_wg, um FE nicht anzutasten / ssch1303 20.12.2024
   --v01.art_id,
   --v01.mandant_id,
   --v01.zek_id

   --FROM dbp_msi_v_view.v_art_zek_zu v01
   --WHERE mandant_id > 1;
    DISTINCT art_id
   ,mandant_id
   ,zek_id
   FROM DBP_VIEW.V_ART 
   WHERE mandant_id > 1 
   AND dat_bis = '9999-12-31';