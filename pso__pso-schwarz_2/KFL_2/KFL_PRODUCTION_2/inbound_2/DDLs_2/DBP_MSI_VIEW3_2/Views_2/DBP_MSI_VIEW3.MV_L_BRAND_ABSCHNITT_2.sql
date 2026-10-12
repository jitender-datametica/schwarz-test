CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_BRAND_ABSCHNITT_2
(
mandant_id
,lagernummer_id
,brand_abschnitt_id
)
AS
   SELECT
   v01.mandant_id, v01.lagernummer_id, v01.brand_abschnitt_id
   FROM dbp_view.v_brand_abschnitt_spr_zu_2 v01
   GROUP BY  v01.mandant_id
   ,v01.lagernummer_id
   ,v01.brand_abschnitt_id

   UNION

   SELECT
   v01.mandant_id, v01.lagernummer_id, '-1' AS brand_abschnitt_id
   FROM dbp_view.v_brand_abschnitt_spr_zu_2 v01
   GROUP BY  v01.mandant_id
   ,v01.lagernummer_id
   ,brand_abschnitt_id

   UNION

   SELECT
   v01.mandant_id, v01.lagernummer_id, '  ' AS brand_abschnitt_id
   FROM dbp_view.v_brand_abschnitt_spr_zu_2 v01
   GROUP BY  v01.mandant_id
   ,v01.lagernummer_id
   ,brand_abschnitt_id
;