create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_ABT_INVENTURART_INT_ZU(
	ABT_INVART_ID,
	ABT_ID,
	INVENTURART_INT_ID
) as
   -- MAPPING : Inventurart im Reporting
   -- Zuordnung Inventurart INT abhaenig von Abteilung
   -- 2018.1128 ssch0611 : Initial - Umstellung OWG

   SELECT  DISTINCT
   CASE
   WHEN inventurart_int_id = 8 THEN 90 + abt_id                 -- Historie GJ    : umgedreht (Invart + Abteilung)
   WHEN abt_id = 5                                     THEN 50  -- Ultra Frische  : Immer Abteilung
   WHEN abt_id = 4 AND inventurart_int_id IN (3, 6, 7) THEN 43  -- Nebengeschaeft : Mapping 7 Frische, 6 irrelevant auf 3 WG
   WHEN abt_id = 6 AND inventurart_int_id IN (3, 6, 7) THEN 63  -- Food Frische   : Mapping 7 Frische, 6 irrelevant auf 3 WG
   WHEN abt_id = 7 AND inventurart_int_id IN (3, 6, 7) THEN 73  -- Food           : Mapping 7 Frische, 6 irrelevant auf 3 WG
   WHEN abt_id = 8 AND inventurart_int_id IN (3, 6, 7) THEN 83  -- Nonfood        : Mapping 7 Frische, 6 irrelevant auf 3 WG
   ELSE abt_id * 10 + inventurart_int_id                        -- default        : Abteilung + Inventurart
   END AS abt_invart_id, abt.abt_id, inv.inventurart_int_id
   FROM dbp_view.v_abt_per  abt
   CROSS JOIN dbp_view.v_l_inventurart_int inv;
