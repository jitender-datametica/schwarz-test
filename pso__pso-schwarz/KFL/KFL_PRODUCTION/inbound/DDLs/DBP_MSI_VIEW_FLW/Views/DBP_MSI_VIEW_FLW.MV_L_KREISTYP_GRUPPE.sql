CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_KREISTYP_GRUPPE
-- 20170202: TTEZ1905; SPEC0018113 Initialanlage fuer den Bericht Analyse der Scanningquote
-- 20172002: TTEZ1905; -1 Zeilen hinzugefuegt weil nicht alle Kunden zu eine Kreistyp_gruppe zugeordnet sind. Dadurch Metrik-Zaehlung Mandant != Metrik-Zaehlung Summe der Gruppen
(
mandant_id
, kreistyp_gruppe_id
)
AS
   SELECT

   mandant_id, kreistyp_gruppe_id

   FROM dbp_view.v_l_kreistyp_gruppe

   WHERE mandant_id in (1,2)

   UNION ALL

   SELECT
   mandant_id, '-1' as kreistyp_gruppe_id
   FROM dbp_view.v_mandant
   where mandant_id in (1,2);