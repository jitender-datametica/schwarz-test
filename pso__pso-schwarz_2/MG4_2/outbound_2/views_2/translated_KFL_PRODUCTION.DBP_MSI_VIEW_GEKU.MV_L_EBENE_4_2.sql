-- in diesem Attribut gibt es durch die Gruppierung nur ein Eintrag für geku_artikel_id, auch wenn es mehrere geku_artikel_uid gibt ggf. aktive und inaktive

-- 23.10.2015 twie: neues Attribut als Eltern von Artikel_2 (Ebene 4), da Artikel_2 nicht auswertbar ist aufgrund aktiv/deaktiv

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_ebene_4_2 (geku_artikel_id, geku_dwh_artikel_id) AS SELECT
 geku_artikel_id,
 geku_dwh_artikel_id
FROM kfl_production_dbp_view.v_l_geku_artikel_2
GROUP BY geku_artikel_id,
 geku_dwh_artikel_id;