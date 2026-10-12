CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_MANDANT_EINKGR_1
-- 23.02.2015 Mandantlookup für Attribut Einkäufergruppe Lieferant, dieses braucht im Gegensatz zu allen anderen Attributen das Land_1 99 International für internationale Einkäufergruppen
-- 08.12.2015 twie: Land_1 100 Gesamt hinzugefügt für Dashboard Managementcockpit (Excelupload) Ggf. wieder entfernen wenn auf Warehousedaten umgestellt wird.
-- 03.01.2018 twie: SPEC0029243 Umbenennung 'international' zu 'International'

(
mandant_id
,mandant_bez
,mandant_kbez
,wrg_id
)
AS

   SELECT mandant_id,
   mandant_bez,
   mandant_kbez,
   wrg_id
   FROM
   (
   SELECT
   99 AS mandant_id,
   'International' AS mandant_bez,
   'INT' AS mandant_kbez,
   'EUR' AS wrg_id
   ) t0

   UNION

   SELECT mandant_id,
   mandant_bez,
   mandant_kbez,
   wrg_id
   FROM
   (
   SELECT
   100 AS mandant_id,
   'Gesamt' AS mandant_bez,
   'GES' AS mandant_kbez,
   'EUR' AS wrg_id
   ) t0

   UNION

   SELECT mandant_id,
   mandant_bez,
   mandant_kbez,
   wrg_id
   FROM
   (
   SELECT
   mandant_id,
   mandant_bez,
   mandant_kbez,
   CASE WHEN v04.wrg_typ_id = 1 THEN default_wrg
   ELSE 'EUR'
   END wrg_id
   FROM dbp_view.v_mandant_1 v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v04
   ) t1_1
;