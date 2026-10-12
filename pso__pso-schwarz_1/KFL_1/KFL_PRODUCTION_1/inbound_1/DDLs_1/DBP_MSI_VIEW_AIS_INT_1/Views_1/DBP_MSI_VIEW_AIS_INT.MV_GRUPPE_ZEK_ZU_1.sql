CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_GRUPPE_ZEK_ZU_1
(
  gruppe_id
, mandant_id
, anz_mandant
, zek_id
, alle_zek_fg
)
AS

SELECT 
  v01.gruppe_id
, v01.mandant_id
/* Zählung wie vielen Ländern eine_1 Gruppe_1 zugeordnet ist */
, COUNT (DISTINCT v01.mandant_id) OVER (PARTITION BY v01.gruppe_id) AS anz_mandant
, v01.zek_id
, v01.alle_zek_fg

FROM dbp_security.gruppe_zek_zu_1 v01;