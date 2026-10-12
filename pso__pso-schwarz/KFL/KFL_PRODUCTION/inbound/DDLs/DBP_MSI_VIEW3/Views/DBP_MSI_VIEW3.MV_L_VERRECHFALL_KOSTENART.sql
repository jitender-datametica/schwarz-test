CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_VERRECHFALL_KOSTENART
( mandant_id
,verrechfall_kostenart_id
,verrechnungsart_id
)
AS
--21-06-2021, AP0091617, SPEC0113162, adding verrechnungsart_id, dknop
-- 02-08-2024, dknop, adding new kostenart_id
   SELECT

   mandant_id
  ,verrechfall_kostenart_id
  ,verrechnungsart_id

   FROM dbp_view.v_l_verrechfall_kostenart
 
UNION
SELECT mandant_id,'MDIES','M'
FROM dbp_view.v_mandant
UNION
SELECT mandant_id,'MSTRO','M'
FROM dbp_view.v_mandant
UNION
SELECT mandant_id,'MGAS','M'
FROM dbp_view.v_mandant
UNION
SELECT mandant_id,'MMAUT','M'
FROM dbp_view.v_mandant
UNION
SELECT mandant_id,'MKUEH','M'
FROM dbp_view.v_mandant;