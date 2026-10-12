CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_IN_KOSTENSTELLE AS
-- 21.08.2013 twie: Lookup für Kostenstelle, immer den aktuellsten Eintrag aus der Historie
-- 23.08.2013 twie: wenn keine pc_id vorhanden, Dummy -1 ausgeben

   SELECT
   mandant_id,
   kostenstelle_id,
   krk_id,
   COALESCE(pc_id, '-1' ) AS pc_id,
   buchungskreis_id,
   geschaeftsbereich_id,
   kostenstellenart_id

   FROM dbp_view.v_in_kostenstelle_per

   QUALIFY ROW_NUMBER() OVER (PARTITION BY kostenstelle_id, mandant_id  ORDER BY dat_bis DESC NULLS LAST) =1;