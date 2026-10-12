CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_KOSTENSTELLE
AS
-- 11.02.2016 twie: Lookup Kostenstelle für Gutscheine

   SELECT

   kostenstelle_id
   , mandant_id
   , kostenstelle_bez
   , dat_bis

   FROM dbp_view.v_kostenstelle_per

   -- Tabelle ist historisiert, immer nur den neuesten Eintrag pro Kostenstelle
   QUALIFY ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, mandant_id  ORDER BY dat_bis DESC NULLS LAST) =1;