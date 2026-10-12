CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS_DT.MV_MANDANT_2
(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ,
	WRG_ID,
	MANDANT_SORT_ID
)
AS
-- 04.04.2013 twie: Lookup Mandant_2
-- 27.06.2013 twie: Userwährung mit ausgeben
-- 24.06.2014 twie: neu dazu: mandant_sort_id, Sortierung für CO

   SELECT
   mandant_id,
   mandant_bez,
   mandant_kbez,
   CASE
  --Land_2
  WHEN v04.wrg_typ_id = 1 THEN default_wrg
  ELSE 'EUR'
  END wrg_id,
   mandant_sort_id

   FROM dbp_view.v_mandant_2
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v04
   ;