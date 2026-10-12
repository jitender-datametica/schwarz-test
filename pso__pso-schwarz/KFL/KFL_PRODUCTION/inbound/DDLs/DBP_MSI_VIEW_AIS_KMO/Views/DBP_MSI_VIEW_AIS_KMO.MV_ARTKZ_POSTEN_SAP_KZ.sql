CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTKZ_POSTEN_SAP_KZ
( 
  mandant_id
, posten_kz
)
AS
SELECT DISTINCT
  v01.mandant_id
, v01.posten_id 

FROM dbp_view.v_artkz_posten v01

WHERE v01.mandant_id <> 1

UNION ALL

SELECT DISTINCT
  v01.mandant_id
, ' ' as posten_id

FROM dbp_view.v_artkz_posten v01

WHERE v01.mandant_id <> 1;