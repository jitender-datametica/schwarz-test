CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_HERSTELLER_FOOD
(
hersteller_food_id
)
AS
-- 13.03.2015 twie: Lookup für Zusatzinfo 'Hersteller KLM-Food' zum Ticket
-- da sich die zusatzinfo_id bei jeder Beladung ändern kann, wird die Zusatzinfo über die deutsche Bezeichnung identifiziert
-- 31.08.2015 twie: Umbenennung von 'Hersteller KLM-Food' auf 'Hersteller Food'

   SELECT

   v01.zusatzinfo_sel_id AS hersteller_food_id

   FROM dbp_view.v_l_geku_zusatzinfo_sel_zu v01
   
   INNER JOIN dbp_view.v_geku_zusatzinfo_spr_zu v02
   ON  v01.zusatzinfo_id = v02.zusatzinfo_id

   WHERE  v02.spr_id = 22 -- fix
   AND v02.zusatzinfo_bez = 'Hersteller Food'

   UNION ALL -- Dummywert

   SELECT

   -1 AS hersteller_food_id

   FROM dbp_view.v_mandant
   WHERE mandant_id = 1;