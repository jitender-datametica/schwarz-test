CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_OBJEKT_DEBITOR_ZU(
	MANDANT_ID,
	DEBITOR_ID,
	IMMO_OBJEKT_ID
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS
 

SELECT
  dp.mandant_id
, dp.debitor_id
, COALESCE(sub01.immo_objekt_id, 'IW----------0') AS immo_objekt_id
FROM dbp_view.v_ivs_debitor_per dp

LEFT JOIN (
  
  SELECT DISTINCT
    med.mandant_id
  , med.debitor_id
  , med.immo_objekt_id
  FROM dbp_view.v_ivs_mietertrag_detail med
  WHERE med.mandant_id <> 1
  
  UNION ALL
  
  SELECT DISTINCT
    dioz.mandant_id
  , dioz.debitor_id
  , dioz.immo_objekt_id
  FROM dbp_view.v_ivs_debitor_immo_objekt_zu dioz
  WHERE dioz.mandant_id = 1
) sub01
ON sub01.mandant_id = dp.mandant_id
AND sub01.debitor_id = dp.debitor_id

WHERE dp.ivs_fg=1;