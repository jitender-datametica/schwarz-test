CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_L_FAKTURAART_2
-- 25.03.2014 twie: Lookup Fakturaart
-- 14.04.2014 twie: Z41 + Z42 manuell angefügt, eigentlich keine echte Fakturaart, aber Bewegungsdaten Pfand Polen wurden damit reingeladen

(
fakturaart_id
,mandant_id
)
AS
   SELECT
   fakturaart_id, mandant_id
   FROM dbp_view.v_l_fakturaart_2


   UNION

   SELECT
   'Z41' AS fakturaart_id, mandant_id
   FROM dbp_view.v_mandant_2

   UNION

   SELECT
   'Z42' AS fakturaart_id, mandant_id
   FROM dbp_view.v_mandant_2

;