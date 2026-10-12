create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_EBENE_4_2(
	GEKU_ARTIKEL_ID,
	GEKU_DWH_ARTIKEL_ID
) as
-- 23.10.2015 twie: neues Attribut als Eltern von Artikel_2 (Ebene 4), da Artikel_2 nicht auswertbar ist aufgrund aktiv/deaktiv
-- in diesem Attribut gibt es durch die Gruppierung nur ein Eintrag für geku_artikel_id, auch wenn es mehrere geku_artikel_uid gibt ggf. aktive und inaktive

   SELECT
   geku_artikel_id
   , geku_dwh_artikel_id
   FROM dbp_view.v_l_geku_artikel_2
   GROUP BY 1,2;