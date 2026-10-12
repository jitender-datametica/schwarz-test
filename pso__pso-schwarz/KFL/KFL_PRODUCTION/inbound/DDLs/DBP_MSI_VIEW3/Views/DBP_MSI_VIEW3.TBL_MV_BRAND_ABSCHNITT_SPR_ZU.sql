CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_BRAND_ABSCHNITT_SPR_ZU
(
brand_abschnitt_id
,mandant_id
,lagernummer_id
,spr_id
,brand_abschnitt_bez
)
AS
   SELECT
   v01.brand_abschnitt_id, v01.mandant_id, v01.lagernummer_id, v01.spr_id, v01.brand_abschnitt_bez

   FROM dbp_view.v_brand_abschnitt_spr_zu v01

   UNION

   SELECT
   '-1' AS brand_abschnitt_id, v01.mandant_id, v01.lagernummer_id, v01.spr_id, 'system generated' AS brand_abschnitt_bez

   FROM dbp_view.v_brand_abschnitt_spr_zu v01
   GROUP BY brand_abschnitt_id
   ,v01.mandant_id
   ,v01.lagernummer_id
   ,v01.spr_id

   UNION

   SELECT
   '  ' AS brand_abschnitt_id, v01.mandant_id, v01.lagernummer_id, v01.spr_id, 'system generated' AS brand_abschnitt_bez

   FROM dbp_view.v_brand_abschnitt_spr_zu v01
   GROUP BY brand_abschnitt_id
   ,v01.mandant_id
   ,v01.lagernummer_id
   ,v01.spr_id

   ;