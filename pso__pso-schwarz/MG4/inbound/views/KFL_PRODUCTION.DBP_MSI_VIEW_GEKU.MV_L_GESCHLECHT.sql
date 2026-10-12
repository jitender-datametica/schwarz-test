create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GESCHLECHT(
	GESCHLECHT_ID
) as
-- 29.01.2014 twie: Lookup für Zusatzinfo 'Geschlecht' zum Ticket
-- da sich die zusatzinfo_id bei jeder Beladung ändern kann, wird die Zusatzinfo über die deutsche Bezeichnung identifiziert

   SELECT

   v01.zusatzinfo_sel_id AS geschlecht_id

   FROM dbp_view.v_l_geku_zusatzinfo_sel_zu v01
   
   INNER JOIN dbp_view.v_geku_zusatzinfo_spr_zu v02
   ON  v01.zusatzinfo_id = v02.zusatzinfo_id

   WHERE  v02.spr_id = 22 -- fix
   AND v02.zusatzinfo_bez = 'Geschlecht'

   UNION ALL -- Dummywert

   SELECT

   -1 AS geschlecht_id

   FROM dbp_view.v_mandant
   WHERE mandant_id = 1;