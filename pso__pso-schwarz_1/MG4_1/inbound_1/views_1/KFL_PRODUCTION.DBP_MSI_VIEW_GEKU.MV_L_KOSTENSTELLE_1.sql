create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_KOSTENSTELLE_1(
	KOSTENSTELLE_ID,
	MANDANT_ID,
	KOSTENSTELLE_BEZ,
	DAT_BIS
) as
-- 11.02.2016 twie: Lookup Kostenstelle für Gutscheine

   SELECT

   kostenstelle_id
   , mandant_id
   , kostenstelle_bez
   , dat_bis

   FROM dbp_view.v_kostenstelle_per_1

   -- Tabelle ist historisiert, immer nur den neuesten Eintrag pro Kostenstelle
   QUALIFY ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, mandant_id  ORDER BY dat_bis DESC NULLS LAST) =1;