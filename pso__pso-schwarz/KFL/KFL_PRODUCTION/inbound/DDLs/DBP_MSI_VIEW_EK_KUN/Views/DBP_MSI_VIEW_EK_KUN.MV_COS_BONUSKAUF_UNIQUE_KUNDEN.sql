CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_KUN.MV_COS_BONUSKAUF_UNIQUE_KUNDEN
--AP0144054/SPEC0168968 Neuanlage wegen Redesign - sschuecke 03.11.2022
(
  bonuskauf_id
, mandant_id
, bonuskauf_partner_fg
, anz_unique_kunden_bp_flag0
, anz_unique_kunden_bp_flag1
)
AS
SELECT
  v01.bonuskauf_id
, v01.mandant_id
, v02.bonuskauf_partner_fg
-- Vorberechnung auf Ebene bonuskauf_partner_fg, da nun auch Partnercoupons vorhanden SPEC0206759 / ssch1303 29.12.2023
, CASE WHEN v02.bonuskauf_partner_fg = 0 THEN COUNT (DISTINCT v01.crm_kunde_id) END AS anz_unique_kunden_bp_flag0
, CASE WHEN v02.bonuskauf_partner_fg = 1 THEN COUNT (DISTINCT v01.crm_kunde_id) END AS anz_unique_kunden_bp_flag1
--, COUNT (DISTINCT v01.crm_kunde_id) AS anz_unique_kunden
FROM DBP_VIEW.V_COS_BONUSKAUF_KUNDE_ZU v01
JOIN DBP_VIEW.V_COS_BONUSKAUF v02
ON v01.mandant_id = v02.mandant_id
AND v01.bonuskauf_id = v02.bonuskauf_id
WHERE v01.anz_einloesung > 0
--AND v02.bonuskauf_partner_fg = 0
GROUP BY
  v01.bonuskauf_id
, v01.mandant_id
, v02.bonuskauf_partner_fg
;