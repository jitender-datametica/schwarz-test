CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_KREISTYP_GRUPPE_SPR_ZU
-- 15.02.2017 twie1305: SPEC0018113 Sprachzuordnung fuer Regionalcluster
-- 20.02.2017 ttez1905: -1 Zeilen durch UNION hinzugefuegt weil nicht alle Kunden zu eine Kreistyp_gruppe zugeordnet sind. Dadurch Metrik-Zaehlung Mandant != Metrik-Zaehlung Summe der Gruppen

(
mandant_id
, kreistyp_gruppe_id
, kreistyp_gruppe_bez
)
AS
   SELECT

   mandant_id, kreistyp_gruppe_id, kreistyp_gruppe_bez

   FROM dbp_view.v_kreistyp_gruppe_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id in (1,2)

   UNION ALL

   SELECT
   mandant_id, '-1' as kreistyp_gruppe_id, '-' as kreistyp_gruppe_bez
   FROM dbp_view.v_mandant
   where mandant_id in (1,2);