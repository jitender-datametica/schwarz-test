-- 11.02.2016 twie: Lookup Kostenstelle für Gutscheine
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_l_kostenstelle_1 (kostenstelle_id
, mandant_id, kostenstelle_bez, dat_bis) AS
-- Tabelle ist historisiert, immer nur den neuesten Eintrag pro Kostenstelle
 SELECT kostenstelle_id,
 mandant_id,
 kostenstelle_bez,
 dat_bis
FROM kfl_production_dbp_view.v_kostenstelle_per_1
QUALIFY (ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, mandant_id ORDER BY dat_bis IS NULL, dat_bis)) = 1;