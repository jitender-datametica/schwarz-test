CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_ENERGIEART_KOSTENART
(
zaehlerart
, kostenart_energie_id
)
AS
   SELECT
   trim(CASE
   WHEN  ka_lv5  =  'K314-31' THEN  'wasser_m3 '

   WHEN  ka_lv5 =  'K314-32' THEN 'gas_m3'

   ELSE   'strom_kwh'

   END)  zaehlerart,
   ka_lv11 as kostenart_energie_id

   FROM dbp_msi_v_view.v_ka_ka_grp_denorm
   WHERE ka_lv5  IN ( 'K314-31',  'K314-32')
   OR
   ka_lv3 = 'K313';