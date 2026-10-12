CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_HERST_FOOD_FLEISCH_1
(
hersteller_food_fleisch_id
)
AS
-- 30.10.2015 twie: Lookup für Zusatzinfo 'Hersteller Food/Fleischwaren' zum Ticket
-- da sich die zusatzinfo_id bei jeder Beladung ändern kann, wird die Zusatzinfo über die deutsche Bezeichnung identifiziert

   SELECT

   v01.zusatzinfo_sel_id AS hersteller_food_fleisch_id

   FROM dbp_view.v_l_geku_zusatzinfo_sel_zu_1 v01

   INNER JOIN dbp_view.v_geku_zusatzinfo_spr_zu_1 v02
   ON  v01.zusatzinfo_id = v02.zusatzinfo_id

   WHERE  v02.spr_id = 22 -- fix
   AND v02.zusatzinfo_bez = 'Hersteller Food/Fleischwaren'

   UNION ALL -- Dummywert

   SELECT

   -1 AS hersteller_food_fleisch_id

   FROM dbp_view.v_mandant_1
   WHERE mandant_id = 1;