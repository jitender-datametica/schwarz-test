CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GEKU_ARTIKEL
(
geku_artikel_uid
,geku_artikel_id
,geku_grund_uid
,land_iso
,geku_dwh_artikel_id
,kmr_quelle_id
,aktiv_fg
)
AS
-- 30.03.2015 twie: neues aktiv_fg, da mit Einführung neuer Kategorienbaum alte Kategorien deaktiviert werden
-- 07.06.2018 twie: SPEC0038139 Schlüssel für DWH Artikel um kmr_quelle_id ergänzt für Zusammenführung Hierarchie

   SELECT
   geku_artikel_uid
   , geku_artikel_id
   , geku_grund_uid
   , land_iso
   , geku_dwh_artikel_id
   , 3 AS kmr_quelle_id
   , aktiv_fg
   FROM dbp_view.v_l_geku_artikel;